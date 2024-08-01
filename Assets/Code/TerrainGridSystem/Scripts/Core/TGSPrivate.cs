//#define SHOW_DEBUG_GIZMOS

using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using TGS.Geom;
using TGS.Poly2Tri;

namespace TGS
{
    [ExecuteInEditMode]
    [Serializable]
    public partial class TerrainGridSystem 
    {
        // internal fields
        private const double MIN_VERTEX_DISTANCE = 0.002;
        private const double SQR_MIN_VERTEX_DIST = MIN_VERTEX_DISTANCE * MIN_VERTEX_DISTANCE;
        private const double SQR_MAX_VERTEX_DIST = 10 * SQR_MIN_VERTEX_DIST;
        private const string SKW_NEAR_CLIP_FADE = "NEAR_CLIP_FADE";
        private const string SKW_TEX_HIGHLIGHT_ADDITIVE = "TGS_TEX_HIGHLIGHT_ADDITIVE";
        private const string SKW_TEX_HIGHLIGHT_MULTIPLY = "TGS_TEX_HIGHLIGHT_MULTIPLY";
        private const string SKW_TEX_HIGHLIGHT_COLOR = "TGS_TEX_HIGHLIGHT_COLOR";
        private const string SKW_TEX_HIGHLIGHT_SCALE = "TGS_TEX_HIGHLIGHT_SCALE";

        private Rect _canvasRect = new Rect(-0.5f, -0.5f, 1, 1);

        // Custom inspector stuff
        public const int MAX_TERRITORIES = 512;
        public int maxCellsSqrt = 100;
        public bool isDirty;
        public const int MAX_CELLS_FOR_CURVATURE = 500;
        public const int MAX_CELLS_FOR_RELAXATION = 1000;

        // Materials and resources
        private Material _territoriesMat,
            _cellsThinMat,
            _cellsGeoMat,
            _hudMatTerritoryOverlay,
            _hudMatTerritoryGround,
            _hudMatCellOverlay,
            _hudMatCellGround;

        private Material _territoriesDisputedMat;
        private Material _coloredMatGround, _coloredMatOverlay;
        private Material _texturizedMatGround, _texturizedMatOverlay;

        // Cell mesh data
        private const string CELLS_LAYER_NAME = "Cells";
        private Vector3[][] _cellMeshBorders;
        private int[][] _cellMeshIndices;
        private Dictionary<Segment, Region> _cellNeighbourHit;
        private float _meshStep;
        private bool _recreateCells, _recreateTerritories;
        private Dictionary<int, Cell> _cellTagged;
        private bool _needUpdateTerritories;

        // Territory mesh data
        private const string TERRITORIES_LAYER_NAME = "Territories";
        private Dictionary<Segment, Region> _territoryNeighbourHit;
        private List<Segment> _territoryFrontiers;
        private List<Territory> _sortedTerritories;
        private List<TerritoryMesh> _territoryMeshes;

        // Common territory & cell structures
        private List<Vector3> _frontiersPoints;
        private Dictionary<Segment, bool> _segmentHit;
        private List<TriangulationPoint> _steinerPoints;
        private Dictionary<TriangulationPoint, int> _surfaceMeshHit;
        private List<Vector3> _meshPoints;
        int[] _triNew;
        int _triNewIndex;
        int _newPointsCount;

        // Terrain data
        private float[,] _terrainHeights;
        private float[] _terrainRoughnessMap;
        private float[] _tempTerrainRoughnessMap;
        private int _terrainRoughnessMapWidth, _terrainRoughnessMapHeight;
        private int _heightMapWidth, _heightMapHeight;
        private const int TERRAIN_CHUNK_SIZE = 8;

        float _effectiveRoughness;
        // = _gridRoughness * terrainHeight

        // Placeholders and layers
        private GameObject _territoryLayer;
        private GameObject _surfacesLayer;

        private GameObject SurfacesLayer
        {
            get
            {
                if (_surfacesLayer == null)
                    CreateSurfacesLayer();
                return _surfacesLayer;
            }
        }

        private GameObject _highlightedObj;
        private GameObject _cellLayer;

        // Caches
        private Dictionary<int, GameObject> _surfaces;
        private Dictionary<Cell, int> _cellLookup;
        private int _lastCellLookupCount = -1;
        private Dictionary<Territory, int> _territoryLookup;
        private int _lastTerritoryLookupCount = -1;
        private Dictionary<Color, Material> _coloredMatCacheGround;
        private Dictionary<Color, Material> _coloredMatCacheOverlay;
        private Dictionary<Color, Material> _frontierColorCache;
        private Color[] _factoryColors;
        private bool _refreshCellMesh, _refreshTerritoriesMesh;
        private List<Cell> _sortedCells;
        private bool _needResortCells;
        private bool _shouldRedraw;
        private DisposalManager _disposalManager;

        // Z-Figther & LOD
        private Vector3 _lastLocalPosition, _lastCamPos, _lastPos;
        private float _lastGridElevation, _lastGridCameraOffset;
        private float _terrainWidth;
        private float _terrainHeight;
        private float _terrainDepth;

        // Interaction
        private static TerrainGridSystem _instance;
        public bool mouseIsOver;
        private Territory _territoryHighlighted;
        private int _territoryHighlightedIndex = -1;
        private Cell _cellHighlighted;
        private int _cellHighlightedIndex = -1;
        private float _highlightFadeStart;
        private int _territoryLastClickedIndex = -1, _cellLastClickedIndex = -1;
        private int _territoryLastOverIndex = -1, _cellLastOverIndex = -1;
        private Territory _territoryLastOver;
        private Cell _cellLastOver;
        private bool _canInteract;
        private List<string> _highlightKeywords;
        private RaycastHit[] _hits;

        // Misc
        private int _lastVertexCount = 0;
        private Color[] _mask;
        private bool _useEditorRay;
        private Ray _editorRay;

        public int LastVertexCount => _lastVertexCount;

        private Dictionary<Cell, int> CellLookup
        {
            get
            {
                if (_cellLookup != null && Cells.Count == _lastCellLookupCount)
                    return _cellLookup;
                if (_cellLookup == null)
                {
                    _cellLookup = new Dictionary<Cell, int>();
                }
                else
                {
                    _cellLookup.Clear();
                }

                _lastCellLookupCount = Cells.Count;
                for (int k = 0; k < _lastCellLookupCount; k++)
                {
                    _cellLookup.Add(Cells[k], k);
                }

                return _cellLookup;
            }
        }


        private bool TerritoriesAreUsed => (showTerritories || colorizeTerritories || highlightMode == HIGHLIGHT_MODE.Territories);

        private List<Territory> SortedTerritories
        {
            get
            {
                if (_sortedTerritories.Count != Territories.Count)
                {
                    _sortedTerritories.AddRange(Territories);
                    _sortedTerritories.Sort(delegate(Territory x, Territory y)
                    {
                        return x.region.rect2DArea.CompareTo(y.region.rect2DArea);
                    });
                }

                return _sortedTerritories;
            }
            set => _sortedTerritories = value;
        }

        private Dictionary<Territory, int> TerritoryLookup
        {
            get
            {
                if (_territoryLookup != null && Territories.Count == _lastTerritoryLookupCount)
                    return _territoryLookup;
                if (_territoryLookup == null)
                {
                    _territoryLookup = new Dictionary<Territory, int>();
                }
                else
                {
                    _territoryLookup.Clear();
                }

                int terrCount = Territories.Count;
                for (int k = 0; k < terrCount; k++)
                {
                    _territoryLookup.Add(Territories[k], k);
                }

                _lastTerritoryLookupCount = Territories.Count;
                return _territoryLookup;
            }
        }

        private Material CellsMat
        {
            get
            {
                if (cellBorderThickness > 1)
                    return _cellsGeoMat;
                else
                    return _cellsThinMat;
            }
        }


        #region Gameloop events

        private void OnEnable()
        {
            if (Cells == null)
            {
                Init();
            }

            if (_hudMatTerritoryOverlay != null && _hudMatTerritoryOverlay.color != territoryHighlightColor)
            {
                _hudMatTerritoryOverlay.color = territoryHighlightColor;
            }

            if (_hudMatTerritoryGround != null && _hudMatTerritoryGround.color != territoryHighlightColor)
            {
                _hudMatTerritoryGround.color = territoryHighlightColor;
            }

            if (_hudMatCellOverlay != null && _hudMatCellOverlay.color != cellHighlightColor)
            {
                _hudMatCellOverlay.color = cellHighlightColor;
            }

            if (_hudMatCellGround != null && _hudMatCellGround.color != cellHighlightColor)
            {
                _hudMatCellGround.color = cellHighlightColor;
            }

            if (_territoriesMat != null && _territoriesMat.color != territoryFrontierColor)
            {
                _territoriesMat.color = territoryFrontierColor;
            }

            if (territoryDisputedFrontierColor == new Color(0, 0, 0, 0))
                territoryDisputedFrontierColor = territoryFrontierColor;
            if (_territoriesDisputedMat != null && _territoriesDisputedMat.color != territoryDisputedFrontierColor)
            {
                _territoriesDisputedMat.color = territoryDisputedFrontierColor;
            }

            if (_cellsThinMat != null && _cellsThinMat.color != cellBorderColor)
            {
                _cellsThinMat.color = cellBorderColor;
            }

            if (_cellsGeoMat != null && _cellsGeoMat.color != cellBorderColor)
            {
                _cellsGeoMat.color = cellBorderColor;
            }

            if (Camera.main != null)
            {
                if ((Camera.main.cullingMask & (1 << gameObject.layer)) == 0)
                {
                    Debug.LogWarning(
                        "Camera is culling Terrain Grid System objects! Check the layer of Terrain Grid System and the culling mask of the camera.");
                }
            }
        }

        private void OnDestroy()
        {
            if (_disposalManager != null)
            {
                _disposalManager.DisposeAll();
            }
        }

        private void LateUpdate()
        {
            if (_needResortCells)
            {
                ResortCells();
            }

            FitToTerrain(); // Verify if there're changes in container and adjust the grid mesh accordingly

            if (_shouldRedraw)
            {
                Redraw();
            }

            if (Application.isMobilePlatform)
            {
                if (Input.touchCount != 1)
                    return;
            }

            bool startPressing = Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Began;

            // Check whether the points is on an UI element, then avoid user interaction
            if (RespectOtherUI)
            {
                if (!_canInteract && Application.isMobilePlatform && !startPressing)
                    return;

                _canInteract = true;
                if (UnityEngine.EventSystems.EventSystem.current != null)
                {
                    if (Application.isMobilePlatform && Input.touchCount > 0 &&
                        UnityEngine.EventSystems.EventSystem.current
                            .IsPointerOverGameObject(Input.GetTouch(0).fingerId))
                    {
                        _canInteract = false;
                    }
                    else if (UnityEngine.EventSystems.EventSystem.current.IsPointerOverGameObject(-1))
                        _canInteract = false;
                }

                if (!_canInteract)
                {
                    HideTerritoryRegionHighlight();
                    HideCellRegionHighlight();
                    return;
                }
            }

            if ((!Application.isMobilePlatform && !Input.GetMouseButton(0)) || startPressing)
            {
                // on mobile only check when touch start and on desktop do not check if dragging
                CheckMousePos(); // Verify if mouse enter a territory boundary 
            }

            TriggerEvents(); // Listen to pointer events

            UpdateHighlightFade(); // Fades current selection
        }

        #endregion


        #region Initialization

        public void Init()
        {
            _disposalManager = new DisposalManager();
            if (_territoriesMat == null)
            {
                _territoriesMat = Instantiate(Resources.Load<Material>("Materials/Territory")) as Material;
                _disposalManager.MarkForDisposal(_territoriesMat);
            }

            if (_territoriesDisputedMat == null)
            {
                _territoriesDisputedMat = Instantiate(_territoriesMat) as Material;
                _disposalManager.MarkForDisposal(_territoriesDisputedMat);
                _territoriesDisputedMat.color = territoryDisputedFrontierColor;
            }

            if (_cellsThinMat == null)
            {
                _cellsThinMat = Instantiate(Resources.Load<Material>("Materials/Cell"));
                _disposalManager.MarkForDisposal(_cellsThinMat);
            }

            if (_cellsGeoMat == null)
            {
                _cellsGeoMat = Instantiate(Resources.Load<Material>("Materials/CellGeo"));
                _disposalManager.MarkForDisposal(_cellsGeoMat);
            }

            if (_hudMatTerritoryOverlay == null)
            {
                _hudMatTerritoryOverlay =
                    Instantiate(Resources.Load<Material>("Materials/HudTerritoryOverlay")) as Material;
                _disposalManager.MarkForDisposal(_hudMatTerritoryOverlay);
            }

            if (_hudMatTerritoryGround == null)
            {
                _hudMatTerritoryGround =
                    Instantiate(Resources.Load<Material>("Materials/HudTerritoryGround")) as Material;
                _disposalManager.MarkForDisposal(_hudMatTerritoryGround);
            }

            if (_hudMatCellOverlay == null)
            {
                _hudMatCellOverlay = Instantiate(Resources.Load<Material>("Materials/HudCellOverlay")) as Material;
                _disposalManager.MarkForDisposal(_hudMatCellOverlay);
            }

            if (_hudMatCellGround == null)
            {
                _hudMatCellGround = Instantiate(Resources.Load<Material>("Materials/HudCellGround")) as Material;
                _disposalManager.MarkForDisposal(_hudMatCellGround);
            }

            if (_coloredMatGround == null)
            {
                _coloredMatGround = Instantiate(Resources.Load<Material>("Materials/ColorizedRegionGround")) as Material;
                _disposalManager.MarkForDisposal(_coloredMatGround);
            }

            if (_coloredMatOverlay == null)
            {
                _coloredMatOverlay =
                    Instantiate(Resources.Load<Material>("Materials/ColorizedRegionOverlay")) as Material;
                _disposalManager.MarkForDisposal(_coloredMatOverlay);
            }

            if (_texturizedMatGround == null)
            {
                _texturizedMatGround = Instantiate(Resources.Load<Material>("Materials/TexturizedRegionGround"));
                _disposalManager.MarkForDisposal(_texturizedMatGround);
            }

            if (_texturizedMatOverlay == null)
            {
                _texturizedMatOverlay = Instantiate(Resources.Load<Material>("Materials/TexturizedRegionOverlay"));
                _disposalManager.MarkForDisposal(_texturizedMatOverlay);
            }

            _coloredMatCacheGround = new Dictionary<Color, Material>();
            _coloredMatCacheOverlay = new Dictionary<Color, Material>();
            _frontierColorCache = new Dictionary<Color, Material>();
            if (_hits == null || _hits.Length == 0)
                _hits = new RaycastHit[100];
            UnityEngine.Random.InitState(Seed);

            if (_factoryColors == null || _factoryColors.Length < MAX_TERRITORIES)
            {
                _factoryColors = new Color[MAX_TERRITORIES];
                for (int k = 0; k < _factoryColors.Length; k++)
                    _factoryColors[k] = new Color(UnityEngine.Random.Range(0.0f, 0.5f),
                        UnityEngine.Random.Range(0.0f, 0.5f), UnityEngine.Random.Range(0.0f, 0.5f));
            }

            if (_sortedTerritories == null)
                _sortedTerritories = new List<Territory>(MAX_TERRITORIES);

            if (textures == null || textures.Length < 32)
                textures = new Texture2D[32];

            ReadMaskContents();
            Redraw();

            if (territoriesTexture != null)
            {
                CreateTerritories(territoriesTexture, territoriesTextureNeutralColor);
            }
        }

        private void CreateSurfacesLayer()
        {
            Transform t = transform.Find("Surfaces");
            if (t != null)
            {
                DestroyImmediate(t.gameObject);
            }

            _surfacesLayer = new GameObject("Surfaces");
            _surfacesLayer.transform.SetParent(transform, false);
            _surfacesLayer.transform.localPosition = Misc.Vector3zero; // Vector3.back * 0.01f;
            _surfacesLayer.layer = gameObject.layer;
        }

        private void DestroySurfaces()
        {
            HideTerritoryRegionHighlight();
            HideCellRegionHighlight();
            if (_segmentHit != null)
                _segmentHit.Clear();
            if (_surfaces != null)
                _surfaces.Clear();
            if (_surfacesLayer != null)
                DestroyImmediate(_surfacesLayer);
        }

        private void ReadMaskContents()
        {
            if (gridMask == null)
                return;
            _mask = gridMask.GetPixels();
        }

        #endregion


        #region Map generation

        private void SetupIrregularGrid()
        {
            int userVoronoiSitesCount = _voronoiSites?.Count ?? 0;
            Point[] centers = new Point[numCells];
            for (int k = 0; k < centers.Length; k++)
            {
                if (k < userVoronoiSitesCount)
                {
                    if (_voronoiSites != null) centers[k] = new Point(_voronoiSites[k].x, _voronoiSites[k].y);
                }
                else
                {
                    centers[k] = new Point(UnityEngine.Random.Range(-0.49f, 0.49f),
                        UnityEngine.Random.Range(-0.49f, 0.49f));
                }
            }

            VoronoiFortune voronoi = new VoronoiFortune();
            for (int k = 0; k < GoodGridRelaxation; k++)
            {
                voronoi.AssignData(centers);
                voronoi.DoVoronoi();
                if (k < GoodGridRelaxation - 1)
                {
                    for (int j = 0; j < numCells; j++)
                    {
                        Point centroid = voronoi.cells[j].centroid;
                        centers[j] = (centers[j] + centroid) / 2;
                    }
                }
            }

            // Make cell regions: we assume cells have only 1 region but that can change in the future
            float curvature = GoodGridCurvature;
            for (int k = 0; k < voronoi.cells.Length; k++)
            {
                VoronoiCell voronoiCell = voronoi.cells[k];
                Cell cell = new Cell(voronoiCell.center.vector3);
                Region cr = new Region(cell);
                if (curvature > 0)
                {
                    cr.polygon = voronoiCell.GetPolygon(3, curvature);
                }
                else
                {
                    cr.polygon = voronoiCell.GetPolygon(1, 0);
                }

                if (cr.polygon != null)
                {
                    // Add segments
                    int segCount = voronoiCell.segments.Count;
                    for (int i = 0; i < segCount; i++)
                    {
                        Segment s = voronoiCell.segments[i];
                        if (!s.deleted)
                        {
                            if (curvature > 0)
                            {
                                cr.segments.AddRange(s.subdivisions);
                            }
                            else
                            {
                                cr.segments.Add(s);
                            }
                        }
                    }

                    cell.polygon = cr.polygon.Clone();
                    cell.region = cr;
                    Cells.Add(cell);
                }
            }
        }

        private void SetupBoxGrid(bool strictQuads)
        {
            int qx = cellColumnCount;
            int qy = cellRowCount;

            double stepX = 1.0 / qx;
            double stepY = 1.0 / qy;

            double halfStepX = stepX * 0.5;
            double halfStepY = stepY * 0.5;

            Segment[,,] sides = new Segment[qx, qy, 4]; // 0 = left, 1 = top, 2 = right, 3 = bottom
            int subdivisions = GoodGridCurvature > 0 ? 3 : 1;
            for (int j = 0; j < qy; j++)
            {
                for (int k = 0; k < qx; k++)
                {
                    Point center = new Point((double)k / qx - 0.5 + halfStepX, (double)j / qy - 0.5 + halfStepY);
                    Cell cell = new Cell(new Vector2((float)center.x, (float)center.y));
                    cell.column = k;
                    cell.row = j;

                    Segment left = k > 0
                        ? sides[k - 1, j, 2]
                        : new Segment(center.Offset(-halfStepX, -halfStepY), center.Offset(-halfStepX, halfStepY),
                            true);
                    sides[k, j, 0] = left;

                    Segment top = new Segment(center.Offset(-halfStepX, halfStepY), center.Offset(halfStepX, halfStepY),
                        j == qy - 1);
                    sides[k, j, 1] = top;

                    Segment right = new Segment(center.Offset(halfStepX, halfStepY),
                        center.Offset(halfStepX, -halfStepY), k == qx - 1);
                    sides[k, j, 2] = right;

                    Segment bottom = j > 0
                        ? sides[k, j - 1, 1]
                        : new Segment(center.Offset(halfStepX, -halfStepY), center.Offset(-halfStepX, -halfStepY),
                            true);
                    sides[k, j, 3] = bottom;

                    Region cr = new Region(cell);
                    if (subdivisions > 1)
                    {
                        cr.segments.AddRange(top.Subdivide(subdivisions, gridCurvature));
                        cr.segments.AddRange(right.Subdivide(subdivisions, gridCurvature));
                        cr.segments.AddRange(bottom.Subdivide(subdivisions, gridCurvature));
                        cr.segments.AddRange(left.Subdivide(subdivisions, gridCurvature));
                    }
                    else
                    {
                        cr.segments.Add(top);
                        cr.segments.Add(right);
                        cr.segments.Add(bottom);
                        cr.segments.Add(left);
                    }

                    Connector connector = new Connector();
                    connector.AddRange(cr.segments);
                    cr.polygon = connector.ToPolygon(); // FromLargestLineStrip();
                    if (cr.polygon != null)
                    {
                        cell.region = cr;
                        Cells.Add(cell);
                    }
                }
            }
        }

        private void SetupHexagonalGrid()
        {
            double qx = 1.0 + (cellColumnCount - 1.0) * 3.0 / 4.0;
            double qy = cellRowCount + 0.5;
            int qy2 = cellRowCount;
            int qx2 = cellColumnCount;

            double stepX = 1.0 / qx;
            double stepY = 1.0 / qy;

            double halfStepX = stepX * 0.5;
            double halfStepY = stepY * 0.5;
            int evenLayout = this.evenLayout ? 1 : 0;

            Segment[,,]
                sides = new Segment[qx2, qy2,
                    6]; // 0 = left-up, 1 = top, 2 = right-up, 3 = right-down, 4 = down, 5 = left-down
            int subdivisions = GoodGridCurvature > 0 ? 3 : 1;
            for (int j = 0; j < qy2; j++)
            {
                for (int k = 0; k < qx2; k++)
                {
                    Point center = new(k / qx - 0.5 + halfStepX, j / qy - 0.5 + stepY);
                    center.x -= k * halfStepX / 2;
                    Cell cell = new(new Vector2((float)center.x, (float)center.y))
                    {
                        row = j,
                        column = k
                    };

                    double offsetY = (k % 2 == evenLayout) ? 0 : -halfStepY;

                    Segment leftUp = (k > 0 && offsetY < 0)
                        ? sides[k - 1, j, 3]
                        : new Segment(center.Offset(-halfStepX, offsetY),
                            center.Offset(-halfStepX / 2, halfStepY + offsetY),
                            k == 0 || (j == qy2 - 1 && offsetY == 0));
                    sides[k, j, 0] = leftUp;

                    Segment top = new Segment(center.Offset(-halfStepX / 2, halfStepY + offsetY),
                        center.Offset(halfStepX / 2, halfStepY + offsetY), j == qy2 - 1);
                    sides[k, j, 1] = top;

                    Segment rightUp = new Segment(center.Offset(halfStepX / 2, halfStepY + offsetY),
                        center.Offset(halfStepX, offsetY), k == qx2 - 1 || (j == qy2 - 1 && offsetY == 0));
                    sides[k, j, 2] = rightUp;

                    Segment rightDown = (j > 0 && k < qx2 - 1 && offsetY < 0)
                        ? sides[k + 1, j - 1, 0]
                        : new Segment(center.Offset(halfStepX, offsetY),
                            center.Offset(halfStepX / 2, -halfStepY + offsetY),
                            (j == 0 && offsetY < 0) || k == qx2 - 1);
                    sides[k, j, 3] = rightDown;

                    Segment bottom = j > 0
                        ? sides[k, j - 1, 1]
                        : new Segment(center.Offset(halfStepX / 2, -halfStepY + offsetY),
                            center.Offset(-halfStepX / 2, -halfStepY + offsetY), true);
                    sides[k, j, 4] = bottom;

                    Segment leftDown;
                    if (offsetY < 0 && j > 0 && k > 0)
                    {
                        leftDown = sides[k - 1, j - 1, 2];
                    }
                    else if (offsetY == 0 && k > 0)
                    {
                        leftDown = sides[k - 1, j, 2];
                    }
                    else
                    {
                        leftDown = new Segment(center.Offset(-halfStepX / 2, -halfStepY + offsetY),
                            center.Offset(-halfStepX, offsetY), true);
                    }

                    sides[k, j, 5] = leftDown;

                    cell.center.y += (float)offsetY;

                    Region cr = new(cell);
                    if (subdivisions > 1)
                    {
                        if (!top.deleted)
                            cr.segments.AddRange(top.Subdivide(subdivisions, gridCurvature));
                        if (!rightUp.deleted)
                            cr.segments.AddRange(rightUp.Subdivide(subdivisions, gridCurvature));
                        if (!rightDown.deleted)
                            cr.segments.AddRange(rightDown.Subdivide(subdivisions, gridCurvature));
                        if (!bottom.deleted)
                            cr.segments.AddRange(bottom.Subdivide(subdivisions, gridCurvature));
                        if (!leftDown.deleted)
                            cr.segments.AddRange(leftDown.Subdivide(subdivisions, gridCurvature));
                        if (!leftUp.deleted)
                            cr.segments.AddRange(leftUp.Subdivide(subdivisions, gridCurvature));
                    }
                    else
                    {
                        if (!top.deleted)
                            cr.segments.Add(top);
                        if (!rightUp.deleted)
                            cr.segments.Add(rightUp);
                        if (!rightDown.deleted)
                            cr.segments.Add(rightDown);
                        if (!bottom.deleted)
                            cr.segments.Add(bottom);
                        if (!leftDown.deleted)
                            cr.segments.Add(leftDown);
                        if (!leftUp.deleted)
                            cr.segments.Add(leftUp);
                    }

                    Connector connector = new Connector();
                    connector.AddRange(cr.segments);
                    cr.polygon = connector.ToPolygon();
                    if (cr.polygon != null)
                    {
                        cell.region = cr;
                        Cells.Add(cell);
                    }
                }
            }
        }

        private void CreateCells()
        {
            UnityEngine.Random.InitState(Seed);

            numCells = Mathf.Max(numTerritories, 2, CellCount);
            if (Cells == null)
            {
                Cells = new List<Cell>(numCells);
            }
            else
            {
                Cells.Clear();
            }

            if (_cellTagged == null)
                _cellTagged = new Dictionary<int, Cell>();
            else
                _cellTagged.Clear();
            _lastCellLookupCount = -1;

            switch (gridTopology)
            {
                case GRID_TOPOLOGY.Box:
                    SetupBoxGrid(true);
                    break;
                case GRID_TOPOLOGY.Hexagonal:
                    SetupHexagonalGrid();
                    break;
                default:
                    SetupIrregularGrid();
                    break; // case GRID_TOPOLOGY.Irregular:
            }

            CellsFindNeighbours();
            CellsUpdateBounds();

            // Update sorted cell list
            _sortedCells = new List<Cell>(Cells);
            ResortCells();

            ClearLastOver();

            _recreateCells = false;
        }

        private void ResortCells()
        {
            _needResortCells = false;
            _sortedCells.Sort((cell1, cell2) => cell1.region.rect2DArea.CompareTo(cell2.region.rect2DArea));
        }

        /// <summary>
        /// Takes the center of each cell and checks the alpha component of the mask to confirm visibility
        /// </summary>
        private void CellsApplyVisibilityFilters()
        {
            int cellsCount = Cells.Count;
            if (GridMask != null && _mask != null)
            {
                int tw = GridMask.width;
                int th = GridMask.height;
                for (int k = 0; k < cellsCount; k++)
                {
                    Cell cell = Cells[k];
                    int pointCount = cell.region.points.Count;
                    bool visible = false;
                    for (int v = 0; v < pointCount; v++)
                    {
                        Vector2 p = cell.region.points[v];
                        float y = p.y + 0.5f;
                        float x = p.x + 0.5f;
                        int ty = (int)(y * th);
                        int tx = (int)(x * tw);
                        if (ty >= 0 && ty < th && tx >= 0 && tx < tw && _mask[ty * tw + tx].a > 0)
                        {
                            visible = true;
                            break;
                        }
                    }

                    cell.visible = visible;
                }
            }

            if (terrain != null)
            {
                if (cellsMaxSlope < 1f)
                {
                    for (int k = 0; k < cellsCount; k++)
                    {
                        Cell cell = Cells[k];
                        if (!cell.visible)
                            continue;
                        Vector3 norm =
                            terrain.terrainData.GetInterpolatedNormal(cell.center.x + 0.5f, cell.center.y + 0.5f);
                        if (Mathf.Abs(norm.y) < cellsMaxSlope)
                        {
                            cell.visible = false;
                        }
                    }
                }

                if (cellsMinimumAltitude != 0f)
                {
                    for (int k = 0; k < cellsCount; k++)
                    {
                        Cell cell = Cells[k];
                        if (!cell.visible)
                            continue;
                        Vector3 wpos = GetWorldSpacePosition(cell.scaledCenter);
                        if (wpos.y < cellsMinimumAltitude)
                            cell.visible = false;
                    }
                }
            }

            ClearLastOver();
            _needRefreshRouteMatrix = true;
        }

        private void CellsUpdateBounds()
        {
            // Update cells polygon
            int count = Cells.Count;
            for (int k = 0; k < count; k++)
            {
                CellUpdateBounds(Cells[k]);
            }
        }

        private void CellUpdateBounds(Cell cell)
        {
            cell.polygon = cell.region.polygon;
            if (cell.polygon.contours.Count == 0)
                return;

            List<Vector2> points = cell.polygon.contours[0].GetVector2Points(gridCenter, gridScale);
            cell.region.points = points;
            // Update bounding rect
            float minx, miny, maxx, maxy;
            minx = miny = float.MaxValue;
            maxx = maxy = float.MinValue;
            int pointsCount = points.Count;
            for (int p = 0; p < pointsCount; p++)
            {
                Vector2 point = points[p];
                if (point.x < minx)
                    minx = point.x;
                if (point.x > maxx)
                    maxx = point.x;
                if (point.y < miny)
                    miny = point.y;
                if (point.y > maxy)
                    maxy = point.y;
            }

            float rectWidth = maxx - minx;
            float rectHeight = maxy - miny;
            cell.region.rect2D = new Rect(minx, miny, rectWidth, rectHeight);
            cell.region.rect2DArea = rectWidth * rectHeight;
            cell.scaledCenter = GetScaledVector(cell.center);
        }


        /// <summary>
        /// Must be called after changing one cell geometry.
        /// </summary>
        private void UpdateCellGeometry(Cell cell, TGS.Geom.Polygon poly)
        {
            // Copy new polygon definition
            cell.region.polygon = poly;
            cell.polygon = cell.region.polygon.Clone();
            // Update segments list
            cell.region.segments.Clear();
            List<Segment> segmentCache = new List<Segment>(_cellNeighbourHit.Keys);
            int segmentsCacheCount = segmentCache.Count;
            int pointsCount = poly.contours[0].points.Count;
            for (int k = 0; k < pointsCount; k++)
            {
                Segment s = poly.contours[0].GetSegment(k);
                bool found = false;
                // Search this segment in the segment cache
                for (int j = 0; j < segmentsCacheCount; j++)
                {
                    Segment o = segmentCache[j];
                    if ((Point.EqualsBoth(o.start, s.start) && Point.EqualsBoth(o.end, s.end)) ||
                        (Point.EqualsBoth(o.end, s.start) && Point.EqualsBoth(o.start, s.end)))
                    {
                        cell.region.segments.Add(o);
//						((Cell)cellNeighbourHit[o].entity).territoryIndex = cell.territoryIndex; // updates the territory index of this segment in the cache 
                        found = true;
                        break;
                    }
                }

                if (!found)
                    cell.region.segments.Add(s);
            }

            // Refresh neighbours
            CellsUpdateNeighbours();
            // Refresh rect2D
            CellUpdateBounds(cell);

            _needResortCells = true;

            // Refresh territories
            if (TerritoriesAreUsed)
            {
                FindTerritoryFrontiers();
                UpdateTerritoryBoundaries();
            }

            if (cell == _cellLastOver)
            {
                ClearLastOver();
            }
        }

        private void CellsUpdateNeighbours()
        {
            int cellCount = Cells.Count;
            for (int k = 0; k < cellCount; k++)
            {
                Cells[k].region.neighbours.Clear();
            }

            CellsFindNeighbours();
        }

        private void CellsFindNeighbours()
        {
            if (_cellNeighbourHit == null)
            {
                _cellNeighbourHit = new Dictionary<Segment, Region>(50000);
            }
            else
            {
                _cellNeighbourHit.Clear();
            }

            int cellCount = Cells.Count;
            for (int k = 0; k < cellCount; k++)
            {
                Cell cell = Cells[k];
                Region region = cell.region;
                int numSegments = region.segments.Count;
                for (int i = 0; i < numSegments; i++)
                {
                    Segment seg = region.segments[i];
                    Region neighbour;
                    if (_cellNeighbourHit.TryGetValue(seg, out neighbour))
                    {
                        if (neighbour != region)
                        {
                            if (!region.neighbours.Contains(neighbour))
                            {
                                region.neighbours.Add(neighbour);
                                neighbour.neighbours.Add(region);
                            }
                        }
                    }
                    else
                    {
                        _cellNeighbourHit.Add(seg, region);
                    }
                }
            }
        }

        private void FindTerritoryFrontiers()
        {
            if (Territories == null || Territories.Count == 0)
                return;

            if (_territoryFrontiers == null)
            {
                _territoryFrontiers = new List<Segment>(_cellNeighbourHit.Count);
            }
            else
            {
                _territoryFrontiers.Clear();
            }

            if (_territoryNeighbourHit == null)
            {
                _territoryNeighbourHit = new Dictionary<Segment, Region>(50000);
            }
            else
            {
                _territoryNeighbourHit.Clear();
            }

            int terrCount = Territories.Count;
            Connector[] connectors = new Connector[terrCount];
            for (int k = 0; k < terrCount; k++)
            {
                connectors[k] = new Connector();
                Territory territory = Territories[k];
                territory.cells.Clear();
                if (territory.region == null)
                {
                    territory.region = new Region(territory);
                }

                Territories[k].region.neighbours.Clear();
            }

            int cellCount = Cells.Count;
            for (int k = 0; k < cellCount; k++)
            {
                Cell cell = Cells[k];
                if (cell.territoryIndex >= terrCount)
                    continue;
                bool validCell = cell.visible && cell.territoryIndex >= 0;
                if (validCell)
                    Territories[cell.territoryIndex].cells.Add(cell);
                Region region = cell.region;
                int numSegments = region.segments.Count;
                for (int i = 0; i < numSegments; i++)
                {
                    Segment seg = region.segments[i];
                    if (seg.border)
                    {
                        if (validCell)
                        {
                            _territoryFrontiers.Add(seg);
                            int territory1 = cell.territoryIndex;
                            connectors[territory1].Add(seg);
                            seg.territoryIndex = territory1;
                        }

                        continue;
                    }

                    Region neighbour;
                    if (_territoryNeighbourHit.TryGetValue(seg, out neighbour))
                    {
                        Cell neighbourCell = (Cell)neighbour.entity;
                        int territory1 = cell.territoryIndex;
                        int territory2 = neighbourCell.territoryIndex;
                        if (territory2 != territory1)
                        {
                            _territoryFrontiers.Add(seg);
                            if (validCell)
                            {
                                connectors[territory1].Add(seg);
                                bool territory1IsNeutral = Territories[territory1].neutral;
                                // check segment ownership
                                if (territory2 >= 0)
                                {
                                    bool territory2IsNeutral = Territories[territory2].neutral;
                                    if (territory1IsNeutral && territory2IsNeutral)
                                    {
                                        seg.territoryIndex = territory1;
                                    }
                                    else if (territory1IsNeutral && !territory2IsNeutral)
                                    {
                                        seg.territoryIndex = territory2;
                                    }
                                    else if (!territory1IsNeutral && territory2IsNeutral)
                                    {
                                        seg.territoryIndex = territory1;
                                    }
                                    else
                                    {
                                        seg.territoryIndex =
                                            -1; // if segment belongs to a visible cell and valid territory2, mark this segment as disputed. Otherwise make it part of territory1
                                    }
                                }
                                else
                                {
                                    seg.territoryIndex = territory1;
                                }

                                if (seg.territoryIndex < 0)
                                {
                                    // add territory neigbhours
                                    Region territory1Region = Territories[territory1].region;
                                    Region territory2Region = Territories[territory2].region;
                                    if (!territory1Region.neighbours.Contains(territory2Region))
                                    {
                                        territory1Region.neighbours.Add(territory2Region);
                                    }

                                    if (!territory2Region.neighbours.Contains(territory1Region))
                                    {
                                        territory2Region.neighbours.Add(territory1Region);
                                    }
                                }
                            }

                            if (territory2 >= 0)
                            {
                                connectors[territory2].Add(seg);
                            }
                        }
                    }
                    else
                    {
                        _territoryNeighbourHit[seg] = region;
                        seg.territoryIndex = cell.territoryIndex;
                    }
                }
            }

            for (int k = 0; k < terrCount; k++)
            {
                if (Territories[k].cells.Count > 0)
                {
                    Territories[k].polygon = connectors[k].ToPolygonFromLargestLineStrip();
                }
                else
                {
                    Territories[k].region.Clear();
                    Territories[k].polygon = null;
                }
            }
        }

        private void AddSegmentToMesh(Vector3 p0, Vector3 p1)
        {
            float h0 = terrain.SampleHeight(transform.TransformPoint(p0));
            float h1 = terrain.SampleHeight(transform.TransformPoint(p1));
            if (gridNormalOffset > 0)
            {
                Vector3 invNormal =
                    transform.InverseTransformVector(
                        terrain.terrainData.GetInterpolatedNormal(p0.x + 0.5f, p0.y + 0.5f));
                p0 += invNormal * gridNormalOffset;
                invNormal = transform.InverseTransformVector(
                    terrain.terrainData.GetInterpolatedNormal(p1.x + 0.5f, p1.y + 0.5f));
                p1 += invNormal * gridNormalOffset;
            }

            p0.z -= h0;
            p1.z -= h1;
            _frontiersPoints.Add(p0);
            _frontiersPoints.Add(p1);
        }

        /// <summary>
        /// Subdivides the segment in smaller segments
        /// </summary>
        /// <returns><c>true</c>, if segment was drawn, <c>false</c> otherwise.</returns>
        private void SurfaceSegmentForMesh(Vector3 p0, Vector3 p1)
        {
            // trace the line until roughness is exceeded
            float dist = (float)Math.Sqrt((p1.x - p0.x) * (p1.x - p0.x) + (p1.y - p0.y) * (p1.y - p0.y));
            Vector3 direction = p1 - p0;

            int numSteps = Mathf.FloorToInt(_meshStep * dist);
            Vector3 t0 = p0;
            float h0 = terrain.SampleHeight(transform.TransformPoint(t0));
            if (gridNormalOffset > 0)
            {
                Vector3 invNormal =
                    transform.InverseTransformVector(
                        terrain.terrainData.GetInterpolatedNormal(t0.x + 0.5f, t0.y + 0.5f));
                t0 += invNormal * gridNormalOffset;
            }

            t0.z -= h0;
            Vector3 ta = t0;
            float h1, ha = h0;
            for (int i = 1; i < numSteps; i++)
            {
                Vector3 t1 = p0 + direction * i / numSteps;
                h1 = terrain.SampleHeight(transform.TransformPoint(t1));
                if (h0 < h1 || h0 - h1 > _effectiveRoughness)
                {
                    _frontiersPoints.Add(t0);
                    if (t0 != ta)
                    {
                        if (gridNormalOffset > 0)
                        {
                            Vector3 invNormal =
                                transform.InverseTransformVector(
                                    terrain.terrainData.GetInterpolatedNormal(ta.x + 0.5f, ta.y + 0.5f));
                            ta += invNormal * gridNormalOffset;
                        }

                        ta.z -= ha;
                        _frontiersPoints.Add(ta);
                        _frontiersPoints.Add(ta);
                    }

                    if (gridNormalOffset > 0)
                    {
                        Vector3 invNormal =
                            transform.InverseTransformVector(
                                terrain.terrainData.GetInterpolatedNormal(t1.x + 0.5f, t1.y + 0.5f));
                        t1 += invNormal * gridNormalOffset;
                    }

                    t1.z -= h1;
                    _frontiersPoints.Add(t1);
                    t0 = t1;
                    h0 = h1;
                }

                ta = t1;
                ha = h1;
            }

            // Add last point
            h1 = terrain.SampleHeight(transform.TransformPoint(p1));
            if (gridNormalOffset > 0)
            {
                Vector3 invNormal =
                    transform.InverseTransformVector(
                        terrain.terrainData.GetInterpolatedNormal(p1.x + 0.5f, p1.y + 0.5f));
                p1 += invNormal * gridNormalOffset;
            }

            p1.z -= h1;
            _frontiersPoints.Add(t0);
            _frontiersPoints.Add(p1);
        }

        private void GenerateCellsMesh()
        {
            if (_segmentHit == null)
            {
                _segmentHit = new Dictionary<Segment, bool>(50000);
            }
            else
            {
                _segmentHit.Clear();
            }

            if (_frontiersPoints == null)
            {
                _frontiersPoints = new List<Vector3>(100000);
            }
            else
            {
                _frontiersPoints.Clear();
            }

            int cellCount = Cells.Count;
            if (terrain == null)
            {
                for (int k = 0; k < cellCount; k++)
                {
                    Cell cell = Cells[k];
                    if (cell.visible)
                    {
                        Region region = cell.region;
                        int numSegments = region.segments.Count;
                        for (int i = 0; i < numSegments; i++)
                        {
                            Segment s = region.segments[i];
                            if (!_segmentHit.ContainsKey(s))
                            {
                                _segmentHit.Add(s, true);
                                _frontiersPoints.Add(GetScaledVector(s.startToVector3));
                                _frontiersPoints.Add(GetScaledVector(s.endToVector3));
                            }
                        }
                    }
                }
            }
            else
            {
                _meshStep = (2.0f - gridRoughness) / (float)MIN_VERTEX_DISTANCE;
                for (int k = 0; k < cellCount; k++)
                {
                    Cell cell = Cells[k];
                    if (cell.visible)
                    {
                        Region region = cell.region;
                        int numSegments = region.segments.Count;
                        for (int i = 0; i < numSegments; i++)
                        {
                            Segment s = region.segments[i];
                            if (!_segmentHit.ContainsKey(s))
                            {
                                _segmentHit.Add(s, true);
                                SurfaceSegmentForMesh(GetScaledVector(s.start.vector3),
                                    GetScaledVector(s.end.vector3));
                            }
                        }
                    }
                }
            }

            int meshGroups = (_frontiersPoints.Count / 65000) + 1;
            int meshIndex = -1;
            if (_cellMeshIndices == null || _cellMeshIndices.GetUpperBound(0) != meshGroups - 1)
            {
                _cellMeshIndices = new int[meshGroups][];
                _cellMeshBorders = new Vector3[meshGroups][];
            }

            if (_frontiersPoints.Count == 0)
            {
                _cellMeshBorders[0] = new Vector3[0];
                _cellMeshIndices[0] = new int[0];
            }
            else
            {
                int frontiersPointsCount = _frontiersPoints.Count;
                for (int k = 0; k < frontiersPointsCount; k += 65000)
                {
                    int max = Mathf.Min(frontiersPointsCount - k, 65000);
                    ++meshIndex;
                    if (_cellMeshBorders[meshIndex] == null || _cellMeshBorders[0].GetUpperBound(0) != max - 1)
                    {
                        _cellMeshBorders[meshIndex] = new Vector3[max];
                        _cellMeshIndices[meshIndex] = new int[max];
                    }

                    for (int j = 0; j < max; j++)
                    {
                        _cellMeshBorders[meshIndex][j] = _frontiersPoints[j + k];
                        _cellMeshIndices[meshIndex][j] = j;
                    }
                }
            }
        }

        private void CreateTerritories()
        {
            numTerritories = Mathf.Clamp(numTerritories, 1, CellCount);

            if (!colorizeTerritories && !showTerritories && highlightMode != HIGHLIGHT_MODE.Territories)
            {
                if (Territories != null)
                    Territories.Clear();
                if (_territoryLayer != null)
                    DestroyImmediate(_territoryLayer);
                return;
            }

            if (Territories == null)
            {
                Territories = new List<Territory>(numTerritories);
            }
            else
            {
                Territories.Clear();
            }

            CheckCells();
            // Freedom for the cells!...
            int cellsCount = Cells.Count;
            for (int k = 0; k < cellsCount; k++)
            {
                Cells[k].territoryIndex = -1;
            }

            UnityEngine.Random.InitState(Seed);

            for (int c = 0; c < numTerritories; c++)
            {
                Territory territory = new(c.ToString())
                {
                    fillColor = _factoryColors[c]
                };
                int territoryIndex = Territories.Count;
                int p = UnityEngine.Random.Range(0, cellsCount);
                int z = 0;
                while ((Cells[p].territoryIndex != -1 || !Cells[p].visible) && z++ <= cellsCount)
                {
                    p++;
                    if (p >= cellsCount)
                        p = 0;
                }

                if (z > cellsCount)
                    break; // no more territories can be found - this should not happen
                Cell cell = Cells[p];
                cell.territoryIndex = territoryIndex;
                territory.center = cell.center;
                territory.cells.Add(cell);
                Territories.Add(territory);
            }

            // Continue conquering cells
            int[] territoryCellIndex = new int[Territories.Count];

            // Iterate one cell per country (this is not efficient but ensures balanced distribution)
            bool remainingCells = true;
            while (remainingCells)
            {
                remainingCells = false;
                int terrCount = Territories.Count;
                for (int k = 0; k < terrCount; k++)
                {
                    Territory territory = Territories[k];
                    int territoryCellsCount = territory.cells.Count;
                    for (int p = territoryCellIndex[k]; p < territoryCellsCount; p++)
                    {
                        Region cellRegion = territory.cells[p].region;
                        int nCount = cellRegion.neighbours.Count;
                        for (int n = 0; n < nCount; n++)
                        {
                            Region otherRegion = cellRegion.neighbours[n];
                            Cell otherProv = (Cell)otherRegion.entity;
                            if (otherProv.territoryIndex == -1 && otherProv.visible)
                            {
                                otherProv.territoryIndex = k;
                                territory.cells.Add(otherProv);
                                territoryCellsCount++;
                                remainingCells = true;
                                p = territoryCellsCount;
                                break;
                            }
                        }

                        if (p < territoryCellsCount)
                        {
                            // no free neighbours left for this cell
                            territoryCellIndex[k]++;
                        }
                    }
                }
            }

            FindTerritoryFrontiers();
            UpdateTerritoryBoundaries();

            _recreateTerritories = false;
        }

        private void UpdateTerritoryBoundaries()
        {
            if (Territories == null)
                return;

            // Update territory region
            int terrCount = Territories.Count;
            for (int k = 0; k < terrCount; k++)
            {
                Territory territory = Territories[k];
                if (territory.polygon == null)
                {
                    continue;
                }

                Region territoryRegion = territory.region;
                territoryRegion.points = territory.polygon.contours[0].GetVector2Points(gridCenter, gridScale);
                territory.scaledCenter = GetScaledVector(territory.center);

                List<Point> points = territory.polygon.contours[0].points;
                int pointCount = points.Count;
                territoryRegion.segments.Clear();
                for (int j = 0; j < pointCount; j++)
                {
                    Point p0 = points[j];
                    Point p1;
                    if (j == pointCount - 1)
                    {
                        p1 = points[0];
                    }
                    else
                    {
                        p1 = points[j + 1];
                    }

                    territoryRegion.segments.Add(new Segment(p0, p1));
                }

                // Update bounding rect
                float minx, miny, maxx, maxy;
                minx = miny = float.MaxValue;
                maxx = maxy = float.MinValue;
                int terrPointCount = territoryRegion.points.Count;
                for (int p = 0; p < terrPointCount; p++)
                {
                    Vector3 point = territoryRegion.points[p];
                    if (point.x < minx)
                        minx = point.x;
                    if (point.x > maxx)
                        maxx = point.x;
                    if (point.y < miny)
                        miny = point.y;
                    if (point.y > maxy)
                        maxy = point.y;
                }

                float rectWidth = maxx - minx;
                float rectHeight = maxy - miny;
                territoryRegion.rect2D = new Rect(minx, miny, rectWidth, rectHeight);
                territoryRegion.rect2DArea = rectWidth * rectHeight;
            }

            _sortedTerritories.Clear();
        }

        private void GenerateTerritoriesMesh()
        {
            if (Territories == null)
                return;

            if (_frontiersPoints == null)
                _frontiersPoints = new List<Vector3>(10000);

            int terrCount = Territories.Count;
            if (_territoryMeshes == null)
            {
                _territoryMeshes = new List<TerritoryMesh>(terrCount + 1);
            }
            else
            {
                _territoryMeshes.Clear();
            }

            if (_territoryFrontiers == null)
                return;

            TerritoryMesh tm;
            for (int k = 0; k < terrCount; k++)
            {
                tm = new TerritoryMesh();
                tm.territoryIndex = k;
                if (GenerateTerritoryMesh(tm))
                {
                    _territoryMeshes.Add(tm);
                }
            }

            // Generate disputed frontiers
            tm = new TerritoryMesh();
            tm.territoryIndex = -1;
            if (GenerateTerritoryMesh(tm))
            {
                _territoryMeshes.Add(tm);
            }
        }

        /// <summary>
        /// Generates the territory mesh.
        /// </summary>
        /// <returns>True if something was produced.
        private bool GenerateTerritoryMesh(TerritoryMesh tm)
        {
            _frontiersPoints.Clear();

            int territoryFrontiersCount = _territoryFrontiers.Count;
            if (terrain == null)
            {
                for (int k = 0; k < territoryFrontiersCount; k++)
                {
                    Segment s = _territoryFrontiers[k];
                    if (s.territoryIndex != tm.territoryIndex)
                        continue;
                    if (!s.border || showTerritoriesOuterBorder)
                    {
                        _frontiersPoints.Add(GetScaledVector(s.startToVector3));
                        _frontiersPoints.Add(GetScaledVector(s.endToVector3));
                    }
                }
            }
            else
            {
                _meshStep = (2.0f - gridRoughness) / (float)MIN_VERTEX_DISTANCE;
                for (int k = 0; k < territoryFrontiersCount; k++)
                {
                    Segment s = _territoryFrontiers[k];
                    if (s.territoryIndex != tm.territoryIndex)
                        continue;
                    if (!s.border || showTerritoriesOuterBorder)
                    {
                        SurfaceSegmentForMesh(GetScaledVector(s.start.vector3), GetScaledVector(s.end.vector3));
                    }
                }
            }

            int meshGroups = (_frontiersPoints.Count / 65000) + 1;
            int meshIndex = -1;
            if (tm.territoryMeshIndices == null || tm.territoryMeshIndices.GetUpperBound(0) != meshGroups - 1)
            {
                tm.territoryMeshIndices = new int[meshGroups][];
                tm.territoryMeshBorders = new Vector3[meshGroups][];
            }

            int frontiersPointsCount = _frontiersPoints.Count;
            for (int k = 0; k < frontiersPointsCount; k += 65000)
            {
                int max = Mathf.Min(frontiersPointsCount - k, 65000);
                ++meshIndex;
                if (tm.territoryMeshBorders[meshIndex] == null ||
                    tm.territoryMeshBorders[meshIndex].GetUpperBound(0) != max - 1)
                {
                    tm.territoryMeshBorders[meshIndex] = new Vector3[max];
                    tm.territoryMeshIndices[meshIndex] = new int[max];
                }

                for (int j = 0; j < max; j++)
                {
                    tm.territoryMeshBorders[meshIndex][j] = _frontiersPoints[j + k];
                    tm.territoryMeshIndices[meshIndex][j] = j;
                }
            }

            return _frontiersPoints.Count > 0;
        }

        private void FitToTerrain()
        {
            if (terrain == null || Camera.main == null)
                return;

            // Fit to terrain
            Vector3 terrainSize = terrain.terrainData.size;
            _terrainWidth = terrainSize.x;
            _terrainHeight = terrainSize.y;
            _terrainDepth = terrainSize.z;
            transform.localRotation = Quaternion.Euler(90, 0, 0);
            transform.localScale = new Vector3(_terrainWidth, _terrainDepth, 1);
            _effectiveRoughness = gridRoughness * _terrainHeight;

            Vector3 camPos = Camera.main.transform.position;
            bool refresh = camPos != _lastCamPos || transform.position != _lastPos ||
                           GridElevationCurrent != _lastGridElevation || gridCameraOffset != _lastGridCameraOffset;
            if (refresh)
            {
                Vector3 localPosition = new(_terrainWidth * 0.5f, 0.01f + GridElevationCurrent, _terrainDepth * 0.5f);
                if (gridCameraOffset > 0)
                {
                    localPosition += (camPos - transform.position).normalized * ((camPos - transform.position).sqrMagnitude * gridCameraOffset * 0.001f);
                }

                transform.localPosition = localPosition;
                _lastPos = transform.position;
                _lastCamPos = camPos;
                _lastGridElevation = GridElevationCurrent;
                _lastGridCameraOffset = gridCameraOffset;
            }
        }

        private bool UpdateTerrainReference(Terrain terrain, bool reuseTerrainData)
        {
            this.terrain = terrain;
            MeshRenderer renderer = GetComponent<MeshRenderer>();
            if (this.terrain == null)
            {
                if (renderer == null)
                {
#if UNITY_EDITOR
                    // Check if user attached TGS directly to the terrain
                    GameObject obj = Instantiate(Resources.Load<GameObject>("Prefabs/TerrainGridSystem")) as GameObject;
                    obj.name = "TerrainGridSystem";
                    TerrainGridSystem tgs = obj.GetComponent<TerrainGridSystem>();
                    tgs.Terrain = GetComponent<Terrain>();
                    UnityEditor.Selection.activeGameObject = tgs.gameObject;
                    DestroyImmediate(this);
#endif
                    return false;
                }

                if (renderer.enabled && transparentBackground)
                {
                    renderer.enabled = false;
                }
                else if (!renderer.enabled && !transparentBackground)
                {
                    renderer.enabled = true;
                }

                if (transform.parent != null)
                {
                    transform.SetParent(null);
                    transform.localScale = new Vector3(100, 100, 1);
                    transform.localRotation = Quaternion.Euler(0, 0, 0);
                }

                // Check if box collider exists
                BoxCollider2D bc = GetComponent<BoxCollider2D>();
                if (bc == null)
                {
                    MeshCollider mc = GetComponent<MeshCollider>();
                    if (mc == null)
                        gameObject.AddComponent<MeshCollider>();
                }
            }
            else
            {
                transform.SetParent(this.terrain.transform, false);
                if (renderer.enabled)
                {
                    renderer.enabled = false;
                }

                MeshCollider mc = GetComponent<MeshCollider>();
                if (mc != null)
                    DestroyImmediate(mc);
                _lastCamPos = Camera.main.transform.position - Vector3.up; // just to force update on first frame
                FitToTerrain();
                _lastCamPos =
                    Camera.main.transform.position - Vector3.up; // just to force update on first update as well
                if (CalculateTerrainRoughness(reuseTerrainData))
                {
                    _refreshCellMesh = true;
                    _refreshTerritoriesMesh = true;
                    // Clear geometry
                    if (_cellLayer != null)
                    {
                        DestroyImmediate(_cellLayer);
                    }

                    if (_territoryLayer != null)
                    {
                        DestroyImmediate(_territoryLayer);
                    }
                }
            }

            return true;
        }

        /// <summary>
        /// Calculates the terrain roughness.
        /// </summary>
        /// <returns><c>true</c>, if terrain roughness has changed, <c>false</c> otherwise.</returns>
        private bool CalculateTerrainRoughness(bool reuseTerrainData)
        {
            if (reuseTerrainData && terrain.terrainData.heightmapResolution == _heightMapWidth &&
                terrain.terrainData.heightmapResolution == _heightMapHeight && _terrainHeights != null &&
                _terrainRoughnessMap != null)
            {
                return false;
            }

            _heightMapWidth = terrain.terrainData.heightmapResolution;
            _heightMapHeight = terrain.terrainData.heightmapResolution;
            _terrainHeights = terrain.terrainData.GetHeights(0, 0, _heightMapWidth, _heightMapHeight);
            _terrainRoughnessMapWidth = _heightMapWidth / TERRAIN_CHUNK_SIZE;
            _terrainRoughnessMapHeight = _heightMapHeight / TERRAIN_CHUNK_SIZE;
            if (_terrainRoughnessMap == null)
            {
                _terrainRoughnessMap = new float[_terrainRoughnessMapHeight * _terrainRoughnessMapWidth];
                _tempTerrainRoughnessMap = new float[_terrainRoughnessMapHeight * _terrainRoughnessMapWidth];
            }
            else
            {
                for (int k = 0; k < _terrainRoughnessMap.Length; k++)
                {
                    _terrainRoughnessMap[k] = 0;
                    _tempTerrainRoughnessMap[k] = 0;
                }
            }

#if SHOW_DEBUG_GIZMOS
			if (GameObject.Find ("ParentDot")!=null) DestroyImmediate(GameObject.Find ("ParentDot"));
			GameObject parentDot = new GameObject("ParentDot");
			parentDotdisposalManager.MarkForDisposal();
			parentDot.transform.position = Misc.Vector3zero;
#endif

            float maxStep = (float)TERRAIN_CHUNK_SIZE / _heightMapWidth;
            float minStep = 1.0f / _heightMapWidth;
            for (int y = 0, l = 0; l < _terrainRoughnessMapHeight; y += TERRAIN_CHUNK_SIZE, l++)
            {
                int linePos = l * _terrainRoughnessMapWidth;
                for (int x = 0, c = 0; c < _terrainRoughnessMapWidth; x += TERRAIN_CHUNK_SIZE, c++)
                {
                    int j0 = y == 0 ? 1 : y;
                    int j1 = y + TERRAIN_CHUNK_SIZE;
                    int k0 = x == 0 ? 1 : x;
                    int k1 = x + TERRAIN_CHUNK_SIZE;
                    float maxDiff = 0;
                    for (int j = j0; j < j1; j++)
                    {
                        for (int k = k0; k < k1; k++)
                        {
                            float diff = _terrainHeights[j, k] - _terrainHeights[j, k - 1];
                            if (diff > maxDiff || -diff > maxDiff)
                                maxDiff = Mathf.Abs(diff);
                            diff = _terrainHeights[j, k] - _terrainHeights[j + 1, k - 1];
                            if (diff > maxDiff || -diff > maxDiff)
                                maxDiff = Mathf.Abs(diff);
                            diff = _terrainHeights[j, k] - _terrainHeights[j + 1, k];
                            if (diff > maxDiff || -diff > maxDiff)
                                maxDiff = Mathf.Abs(diff);
                            diff = _terrainHeights[j, k] - _terrainHeights[j + 1, k + 1];
                            if (diff > maxDiff || -diff > maxDiff)
                                maxDiff = Mathf.Abs(diff);
                            diff = _terrainHeights[j, k] - _terrainHeights[j, k + 1];
                            if (diff > maxDiff || -diff > maxDiff)
                                maxDiff = Mathf.Abs(diff);
                            diff = _terrainHeights[j, k] - _terrainHeights[j - 1, k + 1];
                            if (diff > maxDiff || -diff > maxDiff)
                                maxDiff = Mathf.Abs(diff);
                            diff = _terrainHeights[j, k] - _terrainHeights[j - 1, k];
                            if (diff > maxDiff || -diff > maxDiff)
                                maxDiff = Mathf.Abs(diff);
                            diff = _terrainHeights[j, k] - _terrainHeights[j - 1, k - 1];
                            if (diff > maxDiff || -diff > maxDiff)
                                maxDiff = Mathf.Abs(diff);
                        }
                    }

                    maxDiff /= (gridRoughness * 5.0f);
                    maxDiff = Mathf.Lerp(minStep, maxStep, (1.0f - maxDiff) / (1.0f + maxDiff));
                    _tempTerrainRoughnessMap[linePos + c] = maxDiff;
                }
            }

            // collapse chunks with low gradient
            float flatThreshold = maxStep * (1.0f - gridRoughness * 0.1f);
            for (int j = 0; j < _terrainRoughnessMapHeight; j++)
            {
                int jPos = j * _terrainRoughnessMapWidth;
                for (int k = 0; k < _terrainRoughnessMapWidth - 1; k++)
                {
                    if (_tempTerrainRoughnessMap[jPos + k] >= flatThreshold)
                    {
                        int i = k + 1;
                        while (i < _terrainRoughnessMapWidth && _tempTerrainRoughnessMap[jPos + i] >= flatThreshold)
                            i++;
                        while (k < i && k < _terrainRoughnessMapWidth)
                            _tempTerrainRoughnessMap[jPos + k] = maxStep * (i - k++);
                    }
                }
            }

            // spread min step
            for (int l = 0; l < _terrainRoughnessMapHeight; l++)
            {
                int linePos = l * _terrainRoughnessMapWidth;
                int prevLinePos = linePos - _terrainRoughnessMapWidth;
                int postLinePos = linePos + _terrainRoughnessMapWidth;
                for (int c = 0; c < _terrainRoughnessMapWidth; c++)
                {
                    minStep = _tempTerrainRoughnessMap[linePos + c];
                    if (l > 0)
                    {
                        if (_tempTerrainRoughnessMap[prevLinePos + c] < minStep)
                            minStep = _tempTerrainRoughnessMap[prevLinePos + c];
                        if (c > 0)
                            if (_tempTerrainRoughnessMap[prevLinePos + c - 1] < minStep)
                                minStep = _tempTerrainRoughnessMap[prevLinePos + c - 1];
                        if (c < _terrainRoughnessMapWidth - 1)
                            if (_tempTerrainRoughnessMap[prevLinePos + c + 1] < minStep)
                                minStep = _tempTerrainRoughnessMap[prevLinePos + c + 1];
                    }

                    if (c > 0 && _tempTerrainRoughnessMap[linePos + c - 1] < minStep)
                        minStep = _tempTerrainRoughnessMap[linePos + c - 1];
                    if (c < _terrainRoughnessMapWidth - 1 && _tempTerrainRoughnessMap[linePos + c + 1] < minStep)
                        minStep = _tempTerrainRoughnessMap[linePos + c + 1];
                    if (l < _terrainRoughnessMapHeight - 1)
                    {
                        if (_tempTerrainRoughnessMap[postLinePos + c] < minStep)
                            minStep = _tempTerrainRoughnessMap[postLinePos + c];
                        if (c > 0)
                            if (_tempTerrainRoughnessMap[postLinePos + c - 1] < minStep)
                                minStep = _tempTerrainRoughnessMap[postLinePos + c - 1];
                        if (c < _terrainRoughnessMapWidth - 1)
                            if (_tempTerrainRoughnessMap[postLinePos + c + 1] < minStep)
                                minStep = _tempTerrainRoughnessMap[postLinePos + c + 1];
                    }

                    _terrainRoughnessMap[linePos + c] = minStep;
                }
            }


#if SHOW_DEBUG_GIZMOS
			for (int l = 0;l<terrainRoughnessMapHeight-1;l++) {
				for (int c = 0;c<terrainRoughnessMapWidth-1;c++) {
					if (terrainRoughnessMap[l,c]<0.005f) {
						GameObject marker = Instantiate(Resources.Load<GameObject>("Prefabs/Dot"));
						marker.transform.SetParent(parentDot.transform, false);
						markerdisposalManager.MarkForDisposal();
						marker.transform.localPosition =
 new Vector3(500 * ((float)c / 64 + 0.5f/64) , 1, 500* ((float)l / 64 +  0.5f/64));
						marker.transform.localScale = Misc.Vector3one * 350/512.0f;
					}
				}
			}
#endif

            return true;
        }

        private void UpdateMaterialDepthOffset()
        {
            if (Territories != null)
            {
                int territoriesCount = Territories.Count;
                for (int c = 0; c < territoriesCount; c++)
                {
                    int cacheIndex = GetCacheIndexForTerritoryRegion(c);
                    GameObject surf;
                    if (_surfaces.TryGetValue(cacheIndex, out surf))
                    {
                        if (surf != null)
                        {
                            surf.GetComponent<Renderer>().sharedMaterial.SetInt("_Offset", gridSurfaceDepthOffset);
                        }
                    }
                }
            }

            if (Cells != null)
            {
                int cellsCount = Cells.Count;
                for (int c = 0; c < cellsCount; c++)
                {
                    int cacheIndex = GetCacheIndexForCellRegion(c);
                    GameObject surf;
                    if (_surfaces.TryGetValue(cacheIndex, out surf))
                    {
                        if (surf != null)
                        {
                            surf.GetComponent<Renderer>().sharedMaterial.SetInt("_Offset", gridSurfaceDepthOffset);
                        }
                    }
                }
            }

            float depthOffset = gridMeshDepthOffset / 10000.0f;
            _cellsThinMat.SetFloat("_Offset", depthOffset);
            _cellsGeoMat.SetFloat("_Offset", depthOffset);
            _territoriesMat.SetFloat("_Offset", depthOffset);
            _territoriesDisputedMat.SetFloat("_Offset", depthOffset);
            foreach (Material mat in _frontierColorCache.Values)
            {
                mat.SetFloat("_Offset", depthOffset);
            }

            _hudMatCellOverlay.SetInt("_Offset", gridSurfaceDepthOffset);
            _hudMatCellGround.SetInt("_Offset", gridSurfaceDepthOffset - 1);
            _hudMatTerritoryOverlay.SetInt("_Offset", gridSurfaceDepthOffset);
            _hudMatTerritoryGround.SetInt("_Offset", gridSurfaceDepthOffset - 1);
        }

        private void UpdateMaterialNearClipFade()
        {
            float nearClipFade;
            float nearClipFadeFallOff;
            if (terrain == null)
            {
                nearClipFade = 0f;
                nearClipFadeFallOff = 0.0001f;
            }
            else
            {
                nearClipFade = this.nearClipFade;
                nearClipFadeFallOff = this.nearClipFadeFallOff;
            }

            if (nearClipFadeEnabled)
            {
                _cellsThinMat.EnableKeyword(SKW_NEAR_CLIP_FADE);
                _cellsThinMat.SetFloat("_NearClip", nearClipFade);
                _cellsThinMat.SetFloat("_FallOff", nearClipFadeFallOff);
                _cellsGeoMat.EnableKeyword(SKW_NEAR_CLIP_FADE);
                _cellsGeoMat.SetFloat("_NearClip", nearClipFade);
                _cellsGeoMat.SetFloat("_FallOff", nearClipFadeFallOff);
                _territoriesMat.EnableKeyword(SKW_NEAR_CLIP_FADE);
                _territoriesMat.SetFloat("_NearClip", nearClipFade);
                _territoriesMat.SetFloat("_FallOff", nearClipFadeFallOff);
                _territoriesDisputedMat.EnableKeyword(SKW_NEAR_CLIP_FADE);
                _territoriesDisputedMat.SetFloat("_NearClip", nearClipFade);
                _territoriesDisputedMat.SetFloat("_FallOff", nearClipFadeFallOff);
                foreach (Material mat in _frontierColorCache.Values)
                {
                    mat.EnableKeyword(SKW_NEAR_CLIP_FADE);
                    mat.SetFloat("_NearClip", nearClipFade);
                    mat.SetFloat("_FallOff", nearClipFadeFallOff);
                }
            }
            else
            {
                _cellsThinMat.DisableKeyword(SKW_NEAR_CLIP_FADE);
                _cellsGeoMat.DisableKeyword(SKW_NEAR_CLIP_FADE);
                _territoriesMat.DisableKeyword(SKW_NEAR_CLIP_FADE);
                _territoriesDisputedMat.EnableKeyword(SKW_NEAR_CLIP_FADE);
                foreach (Material mat in _frontierColorCache.Values)
                {
                    mat.DisableKeyword(SKW_NEAR_CLIP_FADE);
                }
            }
        }


        private void UpdateHighlightEffect()
        {
            if (_highlightKeywords == null)
            {
                _highlightKeywords = new List<string>();
            }
            else
            {
                _highlightKeywords.Clear();
            }

            switch (highlightEffect)
            {
                case HIGHLIGHT_EFFECT.TextureAdditive:
                    _highlightKeywords.Add(SKW_TEX_HIGHLIGHT_ADDITIVE);
                    break;
                case HIGHLIGHT_EFFECT.TextureMultiply:
                    _highlightKeywords.Add(SKW_TEX_HIGHLIGHT_MULTIPLY);
                    break;
                case HIGHLIGHT_EFFECT.TextureColor:
                    _highlightKeywords.Add(SKW_TEX_HIGHLIGHT_COLOR);
                    break;
                case HIGHLIGHT_EFFECT.TextureScale:
                    _highlightKeywords.Add(SKW_TEX_HIGHLIGHT_SCALE);
                    break;
            }

            string[] keywords = _highlightKeywords.ToArray();
            _hudMatCellGround.shaderKeywords = keywords;
            _hudMatCellOverlay.shaderKeywords = keywords;
            _hudMatTerritoryGround.shaderKeywords = keywords;
            _hudMatTerritoryOverlay.shaderKeywords = keywords;
        }

        #endregion

        #region Drawing stuff

        private int GetCacheIndexForTerritoryRegion(int territoryIndex)
        {
            return territoryIndex; // * 1000 + regionIndex;
        }

        private Material HUDMatTerritory => overlayMode == OVERLAY_MODE.Overlay ? _hudMatTerritoryOverlay : _hudMatTerritoryGround;

        private Material HUDMatCell => overlayMode == OVERLAY_MODE.Overlay ? _hudMatCellOverlay : _hudMatCellGround;

        private Material GetColoredTexturedMaterial(Color color, Texture2D texture, bool overlay)
        {
            Dictionary<Color, Material> matCache = overlay ? _coloredMatCacheOverlay : _coloredMatCacheGround;
            Material mat;
            if (texture == null && matCache.TryGetValue(color, out mat))
            {
                return mat;
            }
            else
            {
                Material customMat;
                if (texture != null)
                {
                    mat = overlay ? _texturizedMatOverlay : _texturizedMatGround;
                    customMat = Instantiate(mat);
                    customMat.name = mat.name;
                    customMat.mainTexture = texture;
                }
                else
                {
                    mat = overlay ? _coloredMatOverlay : _coloredMatGround;
                    customMat = Instantiate(mat);
                    customMat.name = mat.name;
                    matCache[color] = customMat;
                }

                customMat.color = color;
                _disposalManager.MarkForDisposal(customMat);
                customMat.SetFloat("_Offset", gridSurfaceDepthOffset);
                return customMat;
            }
        }

        private Material GetFrontierColorMaterial(Color color)
        {
            if (color == _territoriesMat.color)
                return _territoriesMat;

            Material mat;
            if (_frontierColorCache.TryGetValue(color, out mat))
            {
                return mat;
            }
            else
            {
                Material customMat = Instantiate(_territoriesMat) as Material;
                customMat.name = _territoriesMat.name;
                customMat.color = color;
                _disposalManager.MarkForDisposal(customMat);
                _frontierColorCache[color] = customMat;
                return customMat;
            }
        }

        private void ApplyMaterialToSurface(Renderer renderer, Material sharedMaterial)
        {
            if (renderer != null)
            {
                renderer.sharedMaterial = sharedMaterial;
            }
        }

        private void DrawColorizedTerritories()
        {
            if (Territories == null)
                return;
            int territoriesCount = Territories.Count;
            for (int k = 0; k < territoriesCount; k++)
            {
                Territory territory = Territories[k];
                Region region = territory.region;
                if (region.customMaterial != null)
                {
                    TerritoryToggleRegionSurface(k, true, region.customMaterial.color,
                        (Texture2D)region.customMaterial.mainTexture, region.customTextureScale,
                        region.customTextureOffset, region.customTextureRotation, region.customRotateInLocalSpace);
                }
                else
                {
                    Color fillColor = Territories[k].fillColor;
                    fillColor.a *= ColorizedTerritoriesAlpha;
                    TerritoryToggleRegionSurface(k, true, fillColor);
                }
            }
        }

        public void GenerateMap()
        {
            _recreateCells = true;
            _recreateTerritories = true;
            if (Cells != null)
                Cells.Clear();
            if (Territories != null)
                Territories.Clear();
            Redraw();
            if (territoriesTexture != null)
            {
                CreateTerritories(territoriesTexture, territoriesTextureNeutralColor);
            }

            // Reload configuration if component exists
            TGSConfig[] configs = GetComponents<TGSConfig>();
            for (int k = 0; k < configs.Length; k++)
            {
                if (configs[k].enabled)
                    configs[k].LoadConfiguration();
            }
        }

        private void ReloadMask()
        {
            ReadMaskContents();
            if (gridMask == null || _mask == null)
            {
                int cellsCount = Cells.Count;
                for (int k = 0; k < cellsCount; k++)
                {
                    Cells[k].visible = true;
                }
            }

            CellsApplyVisibilityFilters();
            _recreateTerritories = true;
            Redraw();
            if (territoriesTexture != null)
            {
                CreateTerritories(territoriesTexture, territoriesTextureNeutralColor);
            }
        }


        private void ComputeGridScale()
        {
            if (regularHexagons && gridTopology == GRID_TOPOLOGY.Hexagonal)
            {
                gridScale = new Vector2(1f + (cellColumnCount - 1f) * 0.75f,
                    cellRowCount * 0.8660254f); // cos(60), sqrt(3)/2
                gridScale.x *= hexSize;
                gridScale.y *= hexSize;
            }

            float aspectRatio = gridScale.y / gridScale.x;
            gridScale.x = Mathf.Clamp(gridScale.x, 0.0001f, 1f);
            gridScale.y = gridScale.x * aspectRatio;
        }

        /// <summary>
        /// Refresh grid.
        /// </summary>
        public void Redraw()
        {
            Redraw(false);
        }

        /// <summary>
        /// Refresh grid. Set reuseTerrainData to true to avoid computation of terrain heights and slope (useful if terrain is not changed).
        /// </summary>
        public void Redraw(bool reuseTerrainData)
        {
            if (!gameObject.activeInHierarchy)
                return;

            _shouldRedraw = false;

            // Initialize surface cache
            if (_surfaces != null)
            {
                List<GameObject> cached = new List<GameObject>(_surfaces.Values);
                int cachedCount = cached.Count;
                for (int k = 0; k < cachedCount; k++)
                {
                    if (cached[k] != null)
                        DestroyImmediate(cached[k]);
                }
            }
            else
            {
                _surfaces = new Dictionary<int, GameObject>();
            }

            DestroySurfaces();
            ClearLastOver();

            if (!UpdateTerrainReference(terrain, reuseTerrainData))
                return;
            _refreshCellMesh = true;
            _lastVertexCount = 0;
            ComputeGridScale();
            CheckCells();
            if (showCells)
            {
                DrawCellBorders();
                DrawColorizedCells();
            }

            _refreshTerritoriesMesh = true;
            CheckTerritories();
            if (showTerritories)
            {
                DrawTerritoryBorders();
            }

            if (colorizeTerritories)
            {
                DrawColorizedTerritories();
            }

            UpdateMaterialDepthOffset();
            UpdateMaterialNearClipFade();
            UpdateHighlightEffect();
        }

        private void CheckCells()
        {
            if (!showCells && !showTerritories && !colorizeTerritories && highlightMode == HIGHLIGHT_MODE.None)
                return;
            if (Cells == null || _recreateCells)
            {
                CreateCells();
                _refreshCellMesh = true;
            }

            if (_refreshCellMesh)
            {
                CellsApplyVisibilityFilters();
                GenerateCellsMesh();
                _refreshCellMesh = false;
                _refreshTerritoriesMesh = true;
            }
        }

        private void DrawCellBorders()
        {
            if (_cellLayer != null)
            {
                DestroyImmediate(_cellLayer);
            }
            else
            {
                Transform t = transform.Find(CELLS_LAYER_NAME);
                if (t != null)
                    DestroyImmediate(t.gameObject);
            }

            if (Cells.Count == 0)
                return;

            _cellLayer = new GameObject(CELLS_LAYER_NAME);
            _disposalManager.MarkForDisposal(_cellLayer);
            _cellLayer.transform.SetParent(transform, false);
            _cellLayer.transform.localPosition = Vector3.back * 0.001f;

            for (int k = 0; k < _cellMeshBorders.Length; k++)
            {
                GameObject flayer = new("flayer");
                _disposalManager.MarkForDisposal(flayer);
                flayer.hideFlags |= HideFlags.HideInHierarchy;
                flayer.transform.SetParent(_cellLayer.transform, false);
                flayer.transform.localPosition = Misc.Vector3zero;
                flayer.transform.localRotation = Quaternion.Euler(Misc.Vector3zero);

                Mesh mesh = new()
                {
                    vertices = _cellMeshBorders[k]
                };
                mesh.SetIndices(_cellMeshIndices[k], MeshTopology.Lines, 0);

                mesh.RecalculateBounds();
                _disposalManager.MarkForDisposal(mesh);

                MeshFilter mf = flayer.AddComponent<MeshFilter>();
                mf.sharedMesh = mesh;
                _lastVertexCount += mesh.vertexCount;

                MeshRenderer mr = flayer.AddComponent<MeshRenderer>();
                mr.receiveShadows = false;
                mr.reflectionProbeUsage = UnityEngine.Rendering.ReflectionProbeUsage.Off;
                mr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                mr.sharedMaterial = CellsMat;
            }

            _cellLayer.SetActive(showCells);
            _cellsGeoMat.SetFloat("_Thickness", cellBorderThickness - 0.8f);
        }

        private void DrawColorizedCells()
        {
            int cellsCount = Cells.Count;
            for (int k = 0; k < cellsCount; k++)
            {
                Cell cell = Cells[k];
                Region region = cell.region;
                if (region.customMaterial != null && cell.visible)
                {
                    CellToggleRegionSurface(k, true, region.customMaterial.color, false,
                        (Texture2D)region.customMaterial.mainTexture, region.customTextureScale,
                        region.customTextureOffset, region.customTextureRotation, region.customRotateInLocalSpace);
                }
            }
        }

        private void CheckTerritories()
        {
            if (!TerritoriesAreUsed)
                return;
            if (Territories == null || _recreateTerritories)
            {
                CreateTerritories();
                _refreshTerritoriesMesh = true;
            }
            else if (_needUpdateTerritories)
            {
                FindTerritoryFrontiers();
                UpdateTerritoryBoundaries();
                _needUpdateTerritories = false;
                _refreshTerritoriesMesh = true;
            }

            if (_refreshTerritoriesMesh)
            {
                GenerateTerritoriesMesh();
                _refreshTerritoriesMesh = false;
            }
        }

        private void DrawTerritoryBorders()
        {
            if (_territoryLayer != null)
            {
                DestroyImmediate(_territoryLayer);
            }
            else
            {
                Transform t = transform.Find(TERRITORIES_LAYER_NAME);
                if (t != null)
                    DestroyImmediate(t.gameObject);
            }

            if (Territories.Count == 0)
                return;

            _territoryLayer = new GameObject(TERRITORIES_LAYER_NAME);
            _disposalManager.MarkForDisposal(_territoryLayer);
            _territoryLayer.transform.SetParent(transform, false);
            _territoryLayer.transform.localPosition = Vector3.back * 0.001f;

            for (int t = 0; t < _territoryMeshes.Count; t++)
            {
                TerritoryMesh tm = _territoryMeshes[t];

                for (int k = 0; k < tm.territoryMeshBorders.Length; k++)
                {
                    GameObject flayer = new("flayer");
                    _disposalManager.MarkForDisposal(flayer);
                    flayer.hideFlags |= HideFlags.HideInHierarchy;
                    flayer.transform.SetParent(_territoryLayer.transform, false);
                    flayer.transform.localPosition = Vector3.back * 0.001f;
                    flayer.transform.localRotation = Quaternion.Euler(Misc.Vector3zero);

                    Mesh mesh = new Mesh();
                    mesh.vertices = tm.territoryMeshBorders[k];
                    mesh.SetIndices(tm.territoryMeshIndices[k], MeshTopology.Lines, 0);

                    mesh.RecalculateBounds();
                    _disposalManager.MarkForDisposal(mesh);

                    MeshFilter mf = flayer.AddComponent<MeshFilter>();
                    mf.sharedMesh = mesh;
                    _lastVertexCount += mesh.vertexCount;

                    MeshRenderer mr = flayer.AddComponent<MeshRenderer>();
                    mr.receiveShadows = false;
                    mr.reflectionProbeUsage = UnityEngine.Rendering.ReflectionProbeUsage.Off;
                    mr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

                    Material mat;
                    if (tm.territoryIndex < 0)
                    {
                        mat = _territoriesDisputedMat;
                    }
                    else
                    {
                        Color frontierColor = Territories[tm.territoryIndex].frontierColor;
                        if (frontierColor.a == 0 && frontierColor.r == 0 && frontierColor.g == 0 &&
                            frontierColor.b == 0)
                        {
                            mat = _territoriesMat;
                        }
                        else
                        {
                            mat = GetFrontierColorMaterial(frontierColor);
                        }
                    }

                    mr.sharedMaterial = mat;
                }
            }

            _territoryLayer.SetActive(showTerritories);
        }

        private void PrepareNewSurfaceMesh(int pointCount)
        {
            if (_meshPoints == null)
            {
                _meshPoints = new List<Vector3>(pointCount);
            }
            else
            {
                _meshPoints.Clear();
            }

            _triNew = new int[pointCount];
            if (_surfaceMeshHit == null)
                _surfaceMeshHit = new Dictionary<TriangulationPoint, int>(20000);
            else
                _surfaceMeshHit.Clear();

            _triNewIndex = -1;
            _newPointsCount = -1;
        }

        private void AddPointToSurfaceMeshWithNormalOffset(TriangulationPoint p)
        {
            int tri;
            if (_surfaceMeshHit.TryGetValue(p, out tri))
            {
                _triNew[++_triNewIndex] = tri;
            }
            else
            {
                Vector3 np = new(p.Xf - 2, p.Yf - 2, -p.Zf);
                np += transform.InverseTransformVector(
                    terrain.terrainData.GetInterpolatedNormal(np.x + 0.5f, np.y + 0.5f)) * gridNormalOffset;
                _meshPoints.Add(np);
                _surfaceMeshHit.Add(p, ++_newPointsCount);
                _triNew[++_triNewIndex] = _newPointsCount;
            }
        }

        private void AddPointToSurfaceMeshWithoutNormalOffset(TriangulationPoint p)
        {
            int tri;
            if (_surfaceMeshHit.TryGetValue(p, out tri))
            {
                _triNew[++_triNewIndex] = tri;
            }
            else
            {
                Vector3 np = new(p.Xf - 2, p.Yf - 2, -p.Zf);
                _meshPoints.Add(np);
                _surfaceMeshHit.Add(p, ++_newPointsCount);
                _triNew[++_triNewIndex] = _newPointsCount;
            }
        }

        private Poly2Tri.Polygon GetPolygon(Region region, out List<PolygonPoint> ppoints, bool reduce = false)
        {
            // Calculate region's surface points
            ppoints = null;
            int numSegments = region.segments.Count;
            if (numSegments == 0)
                return null;

            Connector connector = new();
            if (terrain == null)
            {
                for (int i = 0; i < numSegments; i++)
                {
                    Segment s = region.segments[i];
                    connector.Add(GetScaledSegment(s));
                }
            }
            else
            {
                for (int i = 0; i < numSegments; i++)
                {
                    Segment s = region.segments[i];
                    SurfaceSegmentForSurface(GetScaledSegment(s), connector);
                }
            }

            Geom.Polygon surfacedPolygon = connector.ToPolygonFromLargestLineStrip();
            if (surfacedPolygon == null)
                return null;

            List<Point> surfacedPoints = surfacedPolygon.contours[0].points;

            int spCount = surfacedPoints.Count;
            ppoints = new List<PolygonPoint>(spCount);
            double midX = 0, midY = 0;
            for (int k = 0; k < spCount; k++)
            {
                double
                    x = surfacedPoints[k].x + 2 +
                        k / 1000000.0; // these additions are required to prevent issues with polytri library
                double y = surfacedPoints[k].y + 2 + k / 1000000.0;
                if (!IsTooNearPolygon(x, y, ppoints))
                {
                    float h = terrain != null
                        ? terrain.SampleHeight(transform.TransformPoint((float)x - 2, (float)y - 2, 0))
                        : 0;
                    ppoints.Add(new PolygonPoint(x, y, h));
                    midX += x;
                    midY += y;
                }
            }

            int pPointsCount = ppoints.Count;
            if (pPointsCount < 3)
                return null;
            if (reduce)
            {
                midX /= pPointsCount;
                midY /= pPointsCount;
                for (int k = 0; k < pPointsCount; k++)
                {
                    PolygonPoint p = ppoints[k];
                    double DX = midX - p.X;
                    double DY = midY - p.Y;
                    ppoints[k] = new PolygonPoint(p.X + DX * 0.0001, p.Y + DY * 0.0001);
                }
            }

            return new Poly2Tri.Polygon(ppoints);
        }

        private  GameObject GenerateRegionSurface(Region region, int cacheIndex, Material material, Vector2 textureScale,
            Vector2 textureOffset, float textureRotation, bool rotateInLocalSpace)
        {
            List<PolygonPoint> pPoints;
            Poly2Tri.Polygon poly = GetPolygon(region, out pPoints);
            if (poly == null)
                return null;

            // Support for internal territories
            if (allowTerritoriesInsideTerritories && region.entity is Territory)
            {
                int terrCount = Territories.Count;
                for (int ot = 0; ot < terrCount; ot++)
                {
                    Territory outer = Territories[ot];
                    if (outer.region != region && region.Contains(outer.region))
                    {
                        Poly2Tri.Polygon outerPoly = GetPolygon(outer.region, out _, true);
                        if (outerPoly != null)
                            poly.AddHole(outerPoly);
                    }
                }
            }

            if (terrain != null)
            {
                if (_steinerPoints == null)
                {
                    _steinerPoints = new List<TriangulationPoint>(6000);
                }
                else
                {
                    _steinerPoints.Clear();
                }

                float stepX = 1.0f / _heightMapWidth;
                float smallStep = 1.0f / _heightMapWidth;
                float y = region.rect2D.yMin + smallStep;
                float yMax = region.rect2D.yMax - smallStep;
                float[] acmY = new float[_terrainRoughnessMapWidth];
                int steinerPointsCount = 0;
                while (y < yMax)
                {
                    int j = (int)((y + 0.5f) * _terrainRoughnessMapHeight); // * heightMapHeight)) / TERRAIN_CHUNK_SIZE;
                    if (j >= _terrainRoughnessMapHeight)
                        j = _terrainRoughnessMapHeight - 1;
                    else if (j < 0)
                        j = 0;
                    int jPos = j * _terrainRoughnessMapWidth;
                    float sy = y + 2;
                    float xin, xout;
                    GetFirstAndLastPointInRow(sy, pPoints, out xin, out xout);
//																				float xin = GetFirstPointInRow (sy, ppoints) + smallStep;
//																				float xout = GetLastPointInRow (sy, ppoints) - smallStep;
                    xin += smallStep;
                    xout -= smallStep;
                    int k0 = -1;
                    for (float x = xin; x < xout; x += stepX)
                    {
                        int k = (int)((x + 0.5f) * _terrainRoughnessMapWidth); //)) / TERRAIN_CHUNK_SIZE;
                        if (k >= _terrainRoughnessMapWidth)
                            k = _terrainRoughnessMapWidth - 1;
                        else if (k < 0)
                            k = 0;
                        if (k0 != k)
                        {
                            k0 = k;
                            stepX = _terrainRoughnessMap[jPos + k];
                            if (acmY[k] >= stepX)
                                acmY[k] = 0;
                            acmY[k] += smallStep;
                        }

                        if (acmY[k] >= stepX)
                        {
                            // Gather precision height
                            float h = terrain.SampleHeight(transform.TransformPoint(x, y, 0));
                            float htl = terrain.SampleHeight(transform.TransformPoint(x - smallStep, y + smallStep, 0));
                            if (htl > h)
                                h = htl;
                            float htr = terrain.SampleHeight(transform.TransformPoint(x + smallStep, y + smallStep, 0));
                            if (htr > h)
                                h = htr;
                            float hbr = terrain.SampleHeight(transform.TransformPoint(x + smallStep, y - smallStep, 0));
                            if (hbr > h)
                                h = hbr;
                            float hbl = terrain.SampleHeight(transform.TransformPoint(x - smallStep, y - smallStep, 0));
                            if (hbl > h)
                                h = hbl;
                            _steinerPoints.Add(new PolygonPoint(x + 2, sy, h));
                            steinerPointsCount++;
                        }
                    }

                    y += smallStep;
                    if (steinerPointsCount > 80000)
                    {
                        break;
                    }
                }

                poly.AddSteinerPoints(_steinerPoints);
            }

            P2T.Triangulate(poly);

            string cacheIndexStr = cacheIndex.ToString();
            // Deletes potential residual surface
            Transform t = SurfacesLayer.transform.Find(cacheIndexStr);
            if (t != null)
            {
                DestroyImmediate(t.gameObject);
            }

            Rect rect = (canvasTexture != null && material != null && material.mainTexture == canvasTexture)
                ? _canvasRect
                : region.rect2D;

            // Calculate & optimize mesh data
            int triCount = poly.Triangles.Count;
            GameObject parentSurf = null;

            for (int triBase = 0; triBase < triCount; triBase += 65500)
            {
                int meshTriCount = 65500;
                if (triBase + meshTriCount > triCount)
                {
                    meshTriCount = triCount - triBase;
                }

                PrepareNewSurfaceMesh(meshTriCount * 3);

                if (terrain != null && gridNormalOffset > 0)
                {
                    for (int k = 0; k < meshTriCount; k++)
                    {
                        DelaunayTriangle dt = poly.Triangles[k + triBase];
                        AddPointToSurfaceMeshWithNormalOffset(dt.Points[0]);
                        AddPointToSurfaceMeshWithNormalOffset(dt.Points[2]);
                        AddPointToSurfaceMeshWithNormalOffset(dt.Points[1]);
                    }
                }
                else
                {
                    for (int k = 0; k < meshTriCount; k++)
                    {
                        DelaunayTriangle dt = poly.Triangles[k + triBase];
                        AddPointToSurfaceMeshWithoutNormalOffset(dt.Points[0]);
                        AddPointToSurfaceMeshWithoutNormalOffset(dt.Points[2]);
                        AddPointToSurfaceMeshWithoutNormalOffset(dt.Points[1]);
                    }
                }

                string surfName = triBase == 0 ? cacheIndexStr : "splitMesh";
                GameObject surf = Drawing.CreateSurface(surfName, _meshPoints.ToArray(), _triNew, material, rect,
                    textureScale, textureOffset, textureRotation, rotateInLocalSpace, _disposalManager);
                _lastVertexCount += _meshPoints.Count;
                if (triBase == 0)
                {
                    surf.transform.SetParent(SurfacesLayer.transform, false);
                    _surfaces[cacheIndex] = surf;
                }
                else
                {
                    surf.transform.SetParent(parentSurf.transform, false);
                }

                surf.transform.localPosition = Misc.Vector3zero;
                surf.layer = gameObject.layer;
                region.surfaceGameObject = surf;
                parentSurf = surf;
            }

            return parentSurf;
        }

        #endregion


        #region Internal API

        public string GetMapData()
        {
            return "";
        }

        private float GoodGridRelaxation
        {
            get
            {
                if (numCells >= MAX_CELLS_FOR_RELAXATION)
                {
                    return 1;
                }
                else
                {
                    return gridRelaxation;
                }
            }
        }

        private float GoodGridCurvature
        {
            get
            {
                if (numCells >= MAX_CELLS_FOR_CURVATURE)
                {
                    return 0;
                }
                else
                {
                    return gridCurvature;
                }
            }
        }

        private int FastConvertToInt(string s)
        {
            int value = 0;
            int start, sign;
            if (s[0] == '-')
            {
                start = 1;
                sign = -1;
            }
            else
            {
                start = 0;
                sign = 1;
            }

            for (int i = start; i < s.Length; i++)
            {
                value = value * 10 + (s[i] - '0');
            }

            return value * sign;
        }

        /// <summary>
        /// Issues a selection check based on a given ray. Used by editor to manipulate cells from Scene window.
        /// Returns true if ray hits the grid.
        /// </summary>
        public bool CheckRay(Ray ray)
        {
            _useEditorRay = true;
            _editorRay = ray;
            return CheckMousePos();
        }

        #endregion


        #region Highlighting

        private void OnMouseEnter()
        {
            mouseIsOver = true;
            ClearLastOver();
        }

        private void OnMouseExit()
        {
            // Make sure it's outside of grid
            Vector3 mousePos = Input.mousePosition;
            Ray ray = Camera.main.ScreenPointToRay(mousePos);
            int hitCount = Physics.RaycastNonAlloc(ray, _hits);
            if (hitCount > 0)
            {
                for (int k = 0; k < hitCount; k++)
                {
                    if (_hits[k].collider.gameObject == gameObject)
                        return;
                }
            }

            mouseIsOver = false;
            ClearLastOver();
        }

        private void ClearLastOver()
        {
            NotifyExitingEntities();
            _cellLastOver = null;
            _cellLastOverIndex = -1;
            _territoryLastOver = null;
            _territoryLastOverIndex = -1;
        }

        private void NotifyExitingEntities()
        {
            if (_territoryLastOverIndex >= 0 && OnTerritoryExit != null)
                OnTerritoryExit(_territoryLastOverIndex);
            if (_cellLastOverIndex >= 0 && OnCellExit != null)
                OnCellExit(_cellLastOverIndex);
        }

        private bool GetLocalHitFromMousePos(out Vector3 localPoint)
        {
            Ray ray;
            localPoint = Misc.Vector3zero;

            if (_useEditorRay && !Application.isPlaying)
            {
                ray = _editorRay;
            }
            else
            {
                if (!mouseIsOver && !Application.isMobilePlatform)
                    return false;
                Vector3 mousePos = Input.mousePosition;
                if (mousePos.x < 0 || mousePos.x > Screen.width || mousePos.y < 0 || mousePos.y > Screen.height)
                {
                    localPoint = Misc.Vector3zero;
                    return false;
                }

                ray = Camera.main.ScreenPointToRay(mousePos);
            }

            int hitCount = Physics.RaycastNonAlloc(ray, _hits);
            if (hitCount > 0)
            {
                if (terrain != null)
                {
                    float minDistance = highlightMinimumTerrainDistance * highlightMinimumTerrainDistance;
                    for (int k = 0; k < hitCount; k++)
                    {
                        if (_hits[k].collider.gameObject == terrain.gameObject)
                        {
                            if ((_hits[k].point - ray.origin).sqrMagnitude > minDistance)
                            {
                                localPoint = terrain.transform.InverseTransformPoint(_hits[k].point);
                                float w = terrain.terrainData.size.x;
                                float d = terrain.terrainData.size.z;
                                localPoint.x = localPoint.x / w - 0.5f;
                                localPoint.y = localPoint.z / d - 0.5f;
                                return true;
                            }
                        }
                    }
                }
                else
                {
                    for (int k = 0; k < hitCount; k++)
                    {
                        if (_hits[k].collider.gameObject == gameObject)
                        {
                            localPoint = transform.InverseTransformPoint(_hits[k].point);
                            return true;
                        }
                    }
                }
            }

            return false;
        }

        private bool GetLocalHitFromWorldPosition(ref Vector3 position)
        {
            if (terrain != null)
            {
                Ray ray = new Ray(position - transform.forward * 100, transform.forward);
                int hitCount = Physics.RaycastNonAlloc(ray, _hits);
                bool goodHit = false;
                if (hitCount > 0)
                {
                    for (int k = 0; k < hitCount; k++)
                    {
                        if (_hits[k].collider.gameObject == terrain.gameObject)
                        {
                            Vector3 localPoint = terrain.transform.InverseTransformPoint(_hits[k].point);
                            float w = terrain.terrainData.size.x;
                            float d = terrain.terrainData.size.z;
                            position.x = localPoint.x / w - 0.5f;
                            position.y = localPoint.z / d - 0.5f;
                            position.z = 0;
                            goodHit = true;
                            break;
                        }
                    }
                }

                if (!goodHit)
                    return false;
            }
            else
            {
                position = transform.InverseTransformPoint(position);
            }

            return true;
        }

        private bool CheckMousePos()
        {
            if (highlightMode == HIGHLIGHT_MODE.None || (!Application.isPlaying && !_useEditorRay))
                return false;

            Vector3 localPoint;
            bool goodHit = GetLocalHitFromMousePos(out localPoint);
            if (!goodHit)
            {
                NotifyExitingEntities();
                HideTerritoryRegionHighlight();
                ClearLastOver();
                return false;
            }

            // verify if last highlighted territory remains active
            bool sameTerritoryHighlight = false;
            float sameTerritoryArea = float.MaxValue;
            if (_territoryLastOver != null)
            {
                if (_territoryLastOver.visible && _territoryLastOver.region.Contains(localPoint.x, localPoint.y))
                {
                    sameTerritoryHighlight = true;
                    sameTerritoryArea = _territoryLastOver.region.rect2DArea;
                }
            }

            int newTerritoryHighlightedIndex = -1;

            // mouse if over the grid - verify if hitPos is inside any territory polygon
            if (Territories != null)
            {
                int terrCount = SortedTerritories.Count;
                for (int c = 0; c < terrCount; c++)
                {
                    Region sreg = _sortedTerritories[c].region;
                    if (sreg != null && _sortedTerritories[c].visible && _sortedTerritories[c].cells != null &&
                        _sortedTerritories[c].cells.Count > 0)
                    {
                        if (sreg.Contains(localPoint.x, localPoint.y))
                        {
                            newTerritoryHighlightedIndex = TerritoryGetIndex(_sortedTerritories[c]);
                            sameTerritoryHighlight = newTerritoryHighlightedIndex == _territoryLastOverIndex;
                            break;
                        }

                        if (sreg.rect2DArea > sameTerritoryArea)
                            break;
                    }
                }
            }

            if (!sameTerritoryHighlight)
            {
                if (_territoryLastOverIndex >= 0 && OnTerritoryExit != null)
                    OnTerritoryExit(_territoryLastOverIndex);
                if (newTerritoryHighlightedIndex >= 0 && OnTerritoryEnter != null)
                    OnTerritoryEnter(newTerritoryHighlightedIndex);
                _territoryLastOverIndex = newTerritoryHighlightedIndex;
                if (_territoryLastOverIndex >= 0)
                    _territoryLastOver = Territories[_territoryLastOverIndex];
                else
                    _territoryLastOver = null;
            }

            // verify if last highlited cell remains active
            bool sameCellHighlight = false;
            if (_cellLastOver != null)
            {
                if (_cellLastOver.region.Contains(localPoint.x, localPoint.y))
                {
                    sameCellHighlight = true;
                }
            }

            int newCellHighlightedIndex = -1;

            if (!sameCellHighlight)
            {
                if (highlightMode == HIGHLIGHT_MODE.Cells || !Application.isPlaying)
                {
                    Cell newCellHighlighted = GetCellAtPoint(localPoint, false, _territoryLastOverIndex);
                    if (newCellHighlighted != null)
                    {
                        newCellHighlightedIndex = CellGetIndex(newCellHighlighted);
                    }
                }
            }

            if (!sameCellHighlight)
            {
                if (_cellLastOverIndex >= 0 && OnCellExit != null)
                    OnCellExit(_cellLastOverIndex);
                if (newCellHighlightedIndex >= 0 && OnCellEnter != null)
                    OnCellEnter(newCellHighlightedIndex);
                _cellLastOverIndex = newCellHighlightedIndex;
                if (newCellHighlightedIndex >= 0)
                    _cellLastOver = Cells[newCellHighlightedIndex];
                else
                    _cellLastOver = null;
            }

            if (highlightMode == HIGHLIGHT_MODE.Cells || !Application.isPlaying)
            {
                if (!sameCellHighlight)
                {
                    if (newCellHighlightedIndex >= 0 &&
                        (Cells[newCellHighlightedIndex].visible || cellHighlightNonVisible))
                    {
                        HighlightCellRegion(newCellHighlightedIndex, false);
                    }
                    else
                    {
                        HideCellRegionHighlight();
                    }
                }
            }
            else if (highlightMode == HIGHLIGHT_MODE.Territories)
            {
                if (!sameTerritoryHighlight)
                {
                    if (newTerritoryHighlightedIndex >= 0 && Territories[newTerritoryHighlightedIndex].visible)
                    {
                        HighlightTerritoryRegion(newTerritoryHighlightedIndex, false);
                    }
                    else
                    {
                        HideTerritoryRegionHighlight();
                    }
                }
            }

            return true;
        }

        private void UpdateHighlightFade()
        {
            if (highlightFadeAmount == 0)
                return;

            if (_highlightedObj != null)
            {
                float newAlpha = highlightFadeMin + Mathf.PingPong(Time.time * highlightFadeSpeed - _highlightFadeStart,
                    highlightFadeAmount - highlightFadeMin);
                Material mat = HighlightMode == HIGHLIGHT_MODE.Territories ? HUDMatTerritory : HUDMatCell;
                mat.SetFloat("_FadeAmount", newAlpha);
                float newScale = highlightScaleMin +
                                 Mathf.PingPong(Time.time * HighlightFadeSpeed, highlightScaleMax - highlightScaleMin);
                mat.SetFloat("_Scale", 1f / (newScale + 0.0001f));
                _highlightedObj.GetComponent<Renderer>().sharedMaterial = mat;
            }
        }

        private void TriggerEvents()
        {
            int buttonIndex = -1;
            bool leftButtonClick = Input.GetMouseButtonDown(0);
            bool rightButtonClick = Input.GetMouseButtonDown(1);
            bool leftButtonUp = Input.GetMouseButtonUp(0);
            bool rightButtonUp = Input.GetMouseButtonUp(1);
            if (leftButtonUp || leftButtonClick)
            {
                buttonIndex = 0;
            }
            else if (rightButtonUp || rightButtonClick)
            {
                buttonIndex = 1;
            }

            if (leftButtonClick || rightButtonClick)
            {
                // record last clicked cell/territory
                _cellLastClickedIndex = _cellLastOverIndex;
                _territoryLastClickedIndex = _territoryLastOverIndex;

                if (_territoryLastOverIndex >= 0 && OnTerritoryMouseDown != null)
                {
                    OnTerritoryMouseDown(_territoryLastOverIndex, buttonIndex);
                }

                if (_cellLastOverIndex >= 0 && OnCellMouseDown != null)
                {
                    OnCellMouseDown(_cellLastOverIndex, buttonIndex);
                }
            }
            else if (leftButtonUp || rightButtonUp)
            {
                if (_territoryLastOverIndex >= 0)
                {
                    if (_territoryLastOverIndex == _territoryLastClickedIndex && OnTerritoryClick != null)
                    {
                        OnTerritoryClick(_territoryLastOverIndex, buttonIndex);
                    }

                    if (OnTerritoryMouseUp != null)
                    {
                        OnTerritoryMouseUp(_territoryLastOverIndex, buttonIndex);
                    }
                }

                if (_cellLastOverIndex >= 0)
                {
                    if (_cellLastOverIndex == _cellLastClickedIndex && OnCellClick != null)
                    {
                        OnCellClick(_cellLastOverIndex, buttonIndex);
                    }

                    if (OnCellMouseUp != null)
                    {
                        OnCellMouseUp(_cellLastOverIndex, buttonIndex);
                    }
                }
            }
        }

        #endregion


        #region Geometric functions

        private Vector3 GetWorldSpacePosition(Vector2 localPosition)
        {
            if (terrain != null)
            {
                Vector3 localCenter = new Vector3((localPosition.x + 0.5f) * _terrainWidth, 0,
                    (localPosition.y + 0.5f) * _terrainDepth);
                localCenter.y = terrain.SampleHeight(terrain.transform.TransformPoint(localCenter));
                return terrain.transform.TransformPoint(localCenter);
            }
            else
            {
                return transform.TransformPoint(localPosition);
            }
        }

        private Vector3 GetScaledVector(Vector3 p)
        {
            p.x *= gridScale.x;
            p.x += gridCenter.x;
            p.y *= gridScale.y;
            p.y += gridCenter.y;
            return p;
        }

        private Point GetScaledPoint(Point p)
        {
            p.x *= gridScale.x;
            p.x += gridCenter.x;
            p.y *= gridScale.y;
            p.y += gridCenter.y;
            return p;
        }

        Segment GetScaledSegment(Segment s)
        {
            Segment ss = new Segment(s.start, s.end, s.border);
            ss.start = GetScaledPoint(ss.start);
            ss.end = GetScaledPoint(ss.end);
            return ss;
        }

        #endregion


        #region Territory stuff

        private void HideTerritoryRegionHighlight()
        {
            HideCellRegionHighlight();
            if (TerritoryHighlighted == null)
                return;
            if (_highlightedObj != null)
            {
                if (TerritoryHighlighted.region.customMaterial != null)
                {
                    ApplyMaterialToSurface(_highlightedObj.GetComponent<Renderer>(),
                        TerritoryHighlighted.region.customMaterial);
                }
                else if (_highlightedObj.GetComponent<SurfaceFader>() == null)
                {
                    _highlightedObj.SetActive(false);
                }

                _highlightedObj = null;
            }

            _territoryHighlighted = null;
            _territoryHighlightedIndex = -1;
        }

        /// <summary>
        /// Highlights the territory region specified. Returns the generated highlight surface gameObject.
        /// Internally used by the Map UI and the Editor component, but you can use it as well to temporarily mark a territory region.
        /// </summary>
        /// <param name="refreshGeometry">Pass true only if you're sure you want to force refresh the geometry of the highlight (for instance, if the frontiers data has changed). If you're unsure, pass false.</param>
        private GameObject HighlightTerritoryRegion(int territoryIndex, bool refreshGeometry)
        {
            if (TerritoryHighlighted != null)
                HideTerritoryRegionHighlight();
            if (territoryIndex < 0 || territoryIndex >= Territories.Count)
                return null;

            if (highlightEffect != HIGHLIGHT_EFFECT.None)
            {
                if (OnTerritoryHighlight != null)
                {
                    bool cancelHighlight = false;
                    OnTerritoryHighlight(territoryIndex, ref cancelHighlight);
                    if (cancelHighlight)
                        return null;
                }

                int cacheIndex = GetCacheIndexForTerritoryRegion(territoryIndex);
                bool existsInCache = _surfaces.ContainsKey(cacheIndex);
                if (refreshGeometry && existsInCache)
                {
                    GameObject obj = _surfaces[cacheIndex];
                    _surfaces.Remove(cacheIndex);
                    DestroyImmediate(obj);
                    existsInCache = false;
                }

                if (existsInCache)
                {
                    _highlightedObj = _surfaces[cacheIndex];
                    if (_highlightedObj == null)
                    {
                        _surfaces.Remove(cacheIndex);
                    }
                    else
                    {
                        if (!_highlightedObj.activeSelf)
                            _highlightedObj.SetActive(true);
                        Renderer rr = _highlightedObj.GetComponent<Renderer>();
                        if (rr.sharedMaterial != HUDMatTerritory)
                            rr.sharedMaterial = HUDMatTerritory;
                    }
                }
                else
                {
                    _highlightedObj = GenerateTerritoryRegionSurface(territoryIndex, HUDMatTerritory, Misc.Vector2one,
                        Misc.Vector2zero, 0, false);
                }

                // Reuse territory texture
                Territory territory = Territories[territoryIndex];
                if (territory.region.customMaterial != null)
                {
                    HUDMatTerritory.mainTexture = territory.region.customMaterial.mainTexture;
                }
                else
                {
                    HUDMatTerritory.mainTexture = null;
                }

                _highlightFadeStart = Time.time;
            }

            _territoryHighlightedIndex = territoryIndex;
            _territoryHighlighted = Territories[territoryIndex];

            return _highlightedObj;
        }

        private GameObject GenerateTerritoryRegionSurface(int territoryIndex, Material material, Vector2 textureScale,
            Vector2 textureOffset, float textureRotation, bool rotateInLocalSpace)
        {
            if (territoryIndex < 0 || territoryIndex >= Territories.Count)
                return null;
            Region region = Territories[territoryIndex].region;
            int cacheIndex = GetCacheIndexForTerritoryRegion(territoryIndex);
            return GenerateRegionSurface(region, cacheIndex, material, textureScale, textureOffset, textureRotation,
                rotateInLocalSpace);
        }

        private void UpdateColorizedTerritoriesAlpha()
        {
            if (Territories == null)
                return;
            int territoriesCount = Territories.Count;
            for (int c = 0; c < territoriesCount; c++)
            {
                Territory territory = Territories[c];
                int cacheIndex = GetCacheIndexForTerritoryRegion(c);
                GameObject surf;
                if (_surfaces.TryGetValue(cacheIndex, out surf))
                {
                    if (surf != null)
                    {
                        Color newColor = surf.GetComponent<Renderer>().sharedMaterial.color;
                        newColor.a = territory.fillColor.a * colorizedTerritoriesAlpha;
                        surf.GetComponent<Renderer>().sharedMaterial.color = newColor;
                    }
                }
            }
        }

        private Territory GetTerritoryAtPoint(Vector3 position, bool worldSpace)
        {
            if (worldSpace)
            {
                if (!GetLocalHitFromWorldPosition(ref position))
                    return null;
            }

            int territoriesCount = Territories.Count;
            for (int p = 0; p < territoriesCount; p++)
            {
                Territory territory = Territories[p];
                if (territory.region.Contains(position.x, position.y))
                {
                    return territory;
                }
            }

            return null;
        }

        private void TerritoryAnimate(FADER_STYLE style, int territoryIndex, Color color, float duration)
        {
            if (territoryIndex < 0 || territoryIndex >= Territories.Count)
                return;
            int cacheIndex = GetCacheIndexForTerritoryRegion(territoryIndex);
            GameObject territorySurface = null;
            _surfaces.TryGetValue(cacheIndex, out territorySurface);
            if (territorySurface == null)
            {
                territorySurface = TerritoryToggleRegionSurface(territoryIndex, true, color);
                Territories[territoryIndex].region.customMaterial = null;
            }
            else
            {
                territorySurface.SetActive(true);
            }

            Renderer renderer = territorySurface.GetComponent<Renderer>();
            Material oldMaterial = renderer.sharedMaterial;
            Material fadeMaterial = Instantiate(HUDMatTerritory);
            Region region = Territories[territoryIndex].region;
            fadeMaterial.color = region.customMaterial != null ? region.customMaterial.color : oldMaterial.color;
            fadeMaterial.mainTexture = oldMaterial.mainTexture;
            _disposalManager.MarkForDisposal(fadeMaterial);
            fadeMaterial.name = oldMaterial.name;
            renderer.sharedMaterial = fadeMaterial;
            SurfaceFader.Animate(style, this, territorySurface, region, fadeMaterial, color, duration);
        }

        #endregion


        #region Cell stuff

        private int GetCacheIndexForCellRegion(int cellIndex)
        {
            return 1000000 + cellIndex; // * 1000 + regionIndex;
        }

        /// <summary>
        /// Highlights the cell region specified. Returns the generated highlight surface gameObject.
        /// Internally used by the Map UI and the Editor component, but you can use it as well to temporarily mark a territory region.
        /// </summary>
        /// <param name="refreshGeometry">Pass true only if you're sure you want to force refresh the geometry of the highlight (for instance, if the frontiers data has changed). If you're unsure, pass false.</param>
        private GameObject HighlightCellRegion(int cellIndex, bool refreshGeometry)
        {
            if (_cellHighlighted != null)
                HideCellRegionHighlight();
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return null;

            if (highlightEffect != HIGHLIGHT_EFFECT.None)
            {
                if (OnCellHighlight != null)
                {
                    bool cancelHighlight = false;
                    OnCellHighlight(cellIndex, ref cancelHighlight);
                    if (cancelHighlight)
                        return null;
                }

                int cacheIndex = GetCacheIndexForCellRegion(cellIndex);
                GameObject obj;
                bool existsInCache = _surfaces.TryGetValue(cacheIndex, out obj);
                if (refreshGeometry && existsInCache)
                {
                    _surfaces.Remove(cacheIndex);
                    DestroyImmediate(obj);
                    existsInCache = false;
                }

                if (existsInCache)
                {
                    _highlightedObj = _surfaces[cacheIndex];
                    if (_highlightedObj != null)
                    {
                        _highlightedObj.SetActive(true);
                        _highlightedObj.GetComponent<Renderer>().sharedMaterial = HUDMatCell;
                    }
                    else
                    {
                        _surfaces.Remove(cacheIndex);
                    }
                }
                else
                {
                    _highlightedObj = GenerateCellRegionSurface(cellIndex, HUDMatCell, Misc.Vector2one,
                        Misc.Vector2zero, 0, false);
                }

                // Reuse cell texture
                Cell cell = Cells[cellIndex];
                if (cell.region.customMaterial != null)
                {
                    HUDMatCell.mainTexture = cell.region.customMaterial.mainTexture;
                }
                else
                {
                    HUDMatCell.mainTexture = null;
                }

                _highlightFadeStart = Time.time;
            }

            _cellHighlighted = Cells[cellIndex];
            _cellHighlightedIndex = cellIndex;
            return _highlightedObj;
        }

        private void HideCellRegionHighlight()
        {
            if (_cellHighlighted == null)
                return;
            if (_highlightedObj != null)
            {
                if (CellHighlighted.region.customMaterial != null)
                {
                    ApplyMaterialToSurface(_highlightedObj.GetComponent<Renderer>(),
                        _cellHighlighted.region.customMaterial);
                }
                else if (_highlightedObj.GetComponent<SurfaceFader>() == null)
                {
                    _highlightedObj.SetActive(false);
                }

                _highlightedObj = null;
            }

            _cellHighlighted = null;
            _cellHighlightedIndex = -1;
        }

        private void SurfaceSegmentForSurface(Segment s, Connector connector)
        {
            // trace the line until roughness is exceeded
            double dist = s.magnitude; // (float)Math.Sqrt ( (p1.x-p0.x)*(p1.x-p0.x) + (p1.y-p0.y)*(p1.y-p0.y));
            Point direction = s.end - s.start;

            int numSteps = (int)(dist / MIN_VERTEX_DISTANCE);
            Point t0 = s.start;
            float h0 = terrain.SampleHeight(transform.TransformPoint(t0.vector3));
            Point ta = t0;
            float h1;
            for (int i = 1; i < numSteps; i++)
            {
                Point t1 = s.start + direction * i / numSteps;
                h1 = terrain.SampleHeight(transform.TransformPoint(t1.vector3));
                if (h0 < h1 || h0 - h1 > _effectiveRoughness)
                {
                    //-effectiveRoughness) {
                    if (t0 != ta)
                    {
                        Segment s0 = new(t0, ta, s.border);
                        connector.Add(s0);
                        Segment s1 = new(ta, t1, s.border);
                        connector.Add(s1);
                    }
                    else
                    {
                        Segment s0 = new(t0, t1, s.border);
                        connector.Add(s0);
                    }

                    t0 = t1;
                    h0 = h1;
                }

                ta = t1;
            }

            // Add last point
            Segment finalSeg = new(t0, s.end, s.border);
            connector.Add(finalSeg);
        }
        
        private void GetFirstAndLastPointInRow(float y, List<PolygonPoint> points, out float first, out float last)
        {
            int max = points.Count - 1;
            float minX = float.MaxValue;
            float maxX = float.MinValue;
            for (int k = 0; k <= max; k++)
            {
                PolygonPoint p0 = points[k];
                PolygonPoint p1;
                if (k == max)
                {
                    p1 = points[0];
                }
                else
                {
                    p1 = points[k + 1];
                }

                // if line crosses the horizontal line
                if (p0.Yf >= y && p1.Yf <= y || p0.Yf <= y && p1.Yf >= y)
                {
                    float x;
                    if (p1.X == p0.Xf)
                    {
                        x = p0.Xf;
                    }
                    else
                    {
                        float a = (p1.Xf - p0.Xf) / (p1.Yf - p0.Yf);
                        x = p0.Xf + a * (y - p0.Yf);
                    }

                    if (x > maxX)
                        maxX = x;
                    if (x < minX)
                        minX = x;
                }
            }

            first = minX - 2f;
            last = maxX - 2f;
        }

        private bool IsTooNearPolygon(double x, double y, List<PolygonPoint> points)
        {
            int pointsCount = points.Count;
            for (int j = 0; j < pointsCount; j++)
            {
                PolygonPoint p1 = points[j];
                if ((x - p1.X) * (x - p1.X) + (y - p1.Y) * (y - p1.Y) < SQR_MIN_VERTEX_DIST)
                {
                    return true;
                }
            }

            return false;
        }

        private GameObject GenerateCellRegionSurface(int cellIndex, Material material, Vector2 textureScale,
            Vector2 textureOffset, float textureRotation, bool rotateInLocalSpace)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return null;
            Region region = Cells[cellIndex].region;
            int cacheIndex = GetCacheIndexForCellRegion(cellIndex);
            return GenerateRegionSurface(region, cacheIndex, material, textureScale, textureOffset, textureRotation,
                rotateInLocalSpace);
        }

        private Cell GetCellAtPoint(Vector3 position, bool worldSpace, int territoryIndex = -1)
        {
            // Compute local point
            if (worldSpace)
            {
                if (!GetLocalHitFromWorldPosition(ref position))
                    return null;
            }

            int cellsCount = Cells.Count;
            if (gridTopology == GRID_TOPOLOGY.Hexagonal || gridTopology == GRID_TOPOLOGY.Box)
            {
                float px = (position.x - gridCenter.x) / gridScale.x + 0.5f;
                float py = (position.y - gridCenter.y) / gridScale.y + 0.5f;
                int xc = (int)(cellColumnCount * px);
                int yc = (int)(cellRowCount * py);
                for (int y = yc - 1; y < yc + 2; y++)
                {
                    for (int x = xc - 1; x < xc + 2; x++)
                    {
                        int index = y * cellColumnCount + x;
                        if (index < 0 || index >= CellCount)
                            continue;
                        Cell cell = Cells[index];
                        if (cell == null || cell.region == null || cell.region.points == null || !cell.visible)
                            continue;
                        if (cell.region.Contains(position.x, position.y))
                        {
                            return cell;
                        }
                    }
                }
            }
            else
            {
                if (territoryIndex >= 0 && (Territories == null || territoryIndex >= Territories.Count))
                    return null;
                List<Cell> cells = territoryIndex >= 0 ? Territories[territoryIndex].cells : _sortedCells;
                for (int p = 0; p < cellsCount; p++)
                {
                    Cell cell = cells[p];
                    if (cell == null || cell.region == null || cell.region.points == null || !cell.visible)
                        continue;
                    if (cell.region.Contains(position.x, position.y))
                    {
                        return cell;
                    }
                }
            }

            return null;
        }

        private void CellAnimate(FADER_STYLE style, int cellIndex, Color initialColor, Color color, float duration)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return;
            int cacheIndex = GetCacheIndexForCellRegion(cellIndex);
            GameObject cellSurface = null;
            _surfaces.TryGetValue(cacheIndex, out cellSurface);
            if (cellSurface == null)
            {
                cellSurface = CellToggleRegionSurface(cellIndex, true, color, false);
                Cells[cellIndex].region.customMaterial = null;
            }
            else
            {
                cellSurface.SetActive(true);
            }

            Renderer renderer = cellSurface.GetComponent<Renderer>();
            Material oldMaterial = renderer.sharedMaterial;
            Material fadeMaterial = Instantiate(HUDMatCell);
            fadeMaterial.SetFloat("_FadeAmount", 0);
            Region region = Cells[cellIndex].region;
            fadeMaterial.color = (initialColor.a == 0 && region.customMaterial != null)
                ? region.customMaterial.color
                : initialColor;
            fadeMaterial.mainTexture = oldMaterial.mainTexture;
            _disposalManager.MarkForDisposal(fadeMaterial);
            renderer.sharedMaterial = fadeMaterial;

            SurfaceFader.Animate(style, this, cellSurface, region, fadeMaterial, color, duration);
        }

        private bool ToggleCellsVisibility(Rect rect, bool visible, bool worldSpace = false)
        {
            if (Cells == null)
                return false;
            int count = Cells.Count;
            if (worldSpace)
            {
                Vector3 pos = rect.min;
                if (!GetLocalHitFromWorldPosition(ref pos))
                    return false;
                rect.min = pos;
                pos = rect.max;
                if (!GetLocalHitFromWorldPosition(ref pos))
                    return false;
                rect.max = pos;
            }

            if (rect.xMin < -0.4999f)
                rect.xMin = -0.4999f;
            if (rect.yMin < -0.4999f)
                rect.yMin = -0.4999f;
            if (rect.xMax > 0.4999f)
                rect.xMax = 0.4999f;
            if (rect.yMax > 0.4999f)
                rect.yMax = 0.4999f;
            if (gridTopology == GRID_TOPOLOGY.Irregular)
            {
                float xMin = rect.xMin;
                float xMax = rect.xMax;
                float yMin = rect.yMin;
                float yMax = rect.yMax;
                for (int k = 0; k < count; k++)
                {
                    Cell cell = Cells[k];
                    if (cell.center.x >= xMin && cell.center.x <= xMax && cell.center.y >= yMin &&
                        cell.center.y <= yMax)
                    {
                        cell.visible = visible;
                    }
                }
            }
            else
            {
                Cell topLeft = CellGetAtPosition(rect.min, worldSpace);
                Cell bottomRight = CellGetAtPosition(rect.max, worldSpace);
                if (topLeft == null || bottomRight == null)
                    return false;
                int row0 = topLeft.row;
                int col0 = topLeft.column;
                int row1 = bottomRight.row;
                int col1 = bottomRight.column;
                if (row1 < row0)
                {
                    (row0, row1) = (row1, row0);
                }

                if (col1 < col0)
                {
                    int tmp = col0;
                    col0 = row1;
                    col1 = tmp;
                }

                for (int k = 0; k < count; k++)
                {
                    Cell cell = Cells[k];
                    if (cell.row >= row0 && cell.row <= row1 && cell.column >= col0 && cell.column <= col1)
                    {
                        cell.visible = visible;
                    }
                }
            }

            ClearLastOver();
            _needRefreshRouteMatrix = true;
            _refreshCellMesh = true;
            _shouldRedraw = true;
            return true;
        }

        #endregion
    }
}
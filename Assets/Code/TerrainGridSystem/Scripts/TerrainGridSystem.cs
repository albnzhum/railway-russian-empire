using UnityEngine;
using System;
using UnityEngine.Serialization;

namespace TGS
{
    public enum HIGHLIGHT_MODE
    {
        None = 0,
        Territories = 1,
        Cells = 2
    }

    public enum OVERLAY_MODE
    {
        Overlay = 0,
        Ground = 1
    }

    public enum GRID_TOPOLOGY
    {
        Irregular = 0,
        Box = 1,

        //		Rectangular = 2,	// deprecated: use Box
        Hexagonal = 3
    }

    public enum HIGHLIGHT_EFFECT
    {
        Default = 0,
        TextureAdditive = 1,
        TextureMultiply = 2,
        TextureColor = 3,
        TextureScale = 4,
        None = 5
    }

    /* Event definitions */

    public delegate int OnPathFindingCrossCell(int cellIndex);


    public partial class TerrainGridSystem : MonoBehaviour
    {
        [SerializeField] Terrain terrain;

        /// <summary>
        /// Terrain reference. Assign a terrain to this property to fit the grid to terrain height and dimensions
        /// </summary>
        public Terrain Terrain
        {
            get => terrain;
            set
            {
                if (terrain != value)
                {
                    terrain = value;
                    isDirty = true;
                    Redraw();
                }
            }
        }

        /// <summary>
        /// Returns the terrain center in world space.
        /// </summary>
        public Vector3 TerrainCenter =>
            terrain.transform.position + new Vector3(terrainWidth * 0.5f, 0, terrainDepth * 0.5f);

        public Texture2D canvasTexture;

        [SerializeField] bool transparentBackground;

        /// <summary>
        /// When enabled, make sure you have another geometry behind the cells / territories that write to zbuffer because the grid won't be visible otherwise.
        /// </summary>
        public bool TransparentBackground
        {
            get => transparentBackground;
            set
            {
                if (transparentBackground != value)
                {
                    transparentBackground = value;
                    isDirty = true;
                    Redraw(true);
                }
            }
        }

        [SerializeField] Texture2D gridMask;

        /// <summary>
        /// Gets or sets the grid mask. The alpha component of this texture is used to determine cells visibility (0 = cell invisible)
        /// </summary>
        public Texture2D GridMask
        {
            get => gridMask;
            set
            {
                if (gridMask != value)
                {
                    gridMask = value;
                    isDirty = true;
                    ReloadMask();
                }
            }
        }


        [SerializeField] GRID_TOPOLOGY gridTopology = GRID_TOPOLOGY.Irregular;

        /// <summary>
        /// The grid type (boxed, hexagonal or irregular)
        /// </summary>
        public GRID_TOPOLOGY GridTopology
        {
            get => gridTopology;
            set
            {
                if (gridTopology != value)
                {
                    gridTopology = value;
                    GenerateMap();
                    isDirty = true;
                }
            }
        }

        [SerializeField] int seed = 1;

        /// <summary>
        /// Randomize seed used to generate cells. Use this to control randomization.
        /// </summary>
        public int Seed
        {
            get => seed;
            set
            {
                if (seed != value)
                {
                    seed = value;
                    isDirty = true;
                    GenerateMap();
                }
            }
        }

        /// <summary>
        /// Returns the actual number of cells created according to the current grid topology
        /// </summary>
        /// <value>The cell count.</value>
        public int CellCount
        {
            get
            {
                if (gridTopology == GRID_TOPOLOGY.Irregular)
                {
                    return numCells;
                }
                else
                {
                    return cellRowCount * cellColumnCount;
                }
            }
        }

        [SerializeField] bool evenLayout = false;

        /// <summary>
        /// Toggle even corner in hexagonal topology.
        /// </summary>
        public bool EvenLayout
        {
            get => evenLayout;
            set
            {
                if (value != evenLayout)
                {
                    evenLayout = value;
                    isDirty = true;
                    GenerateMap();
                }
            }
        }

        [SerializeField] public bool regularHexagons;

        public bool RegularHexagons
        {
            get => regularHexagons;
            set
            {
                if (value != regularHexagons)
                {
                    regularHexagons = value;
                    isDirty = true;
                    CellsUpdateBounds();
                    UpdateTerritoryBoundaries();
                    Redraw();
                }
            }
        }

        [SerializeField] public float hexSize = 0.01f;

        public float HexSize
        {
            get => hexSize;
            set
            {
                if (value != hexSize)
                {
                    hexSize = value;
                    ComputeGridScale();
                    isDirty = true;
                    CellsUpdateBounds();
                    UpdateTerritoryBoundaries();
                    Redraw();
                }
            }
        }

        [SerializeField] int gridRelaxation = 1;

        /// <summary>
        /// Sets the relaxation iterations used to normalize cells sizes in irregular topology.
        /// </summary>
        public int GridRelaxation
        {
            get => gridRelaxation;
            set
            {
                if (gridRelaxation != value)
                {
                    gridRelaxation = value;
                    GenerateMap();
                    isDirty = true;
                }
            }
        }

        [SerializeField] float gridCurvature = 0.0f;

        /// <summary>
        /// Gets or sets the grid's curvature factor.
        /// </summary>
        public float GridCurvature
        {
            get => gridCurvature;
            set
            {
                if (gridCurvature != value)
                {
                    gridCurvature = value;
                    GenerateMap();
                    isDirty = true;
                }
            }
        }

        [SerializeField] HIGHLIGHT_MODE highlightMode = HIGHLIGHT_MODE.Cells;

        public HIGHLIGHT_MODE HighlightMode
        {
            get => highlightMode;
            set
            {
                if (highlightMode != value)
                {
                    highlightMode = value;
                    isDirty = true;
                    ClearLastOver();
                    HideCellRegionHighlight();
                    HideTerritoryRegionHighlight();
                    CheckCells();
                    CheckTerritories();
                }
            }
        }

        [SerializeField] float highlightFadeMin = 0f;

        public float HighlightFadeMin
        {
            get => highlightFadeMin;
            set
            {
                if (highlightFadeMin != value)
                {
                    highlightFadeMin = value;
                    isDirty = true;
                }
            }
        }


        [SerializeField] float highlightFadeAmount = 0.5f;

        public float HighlightFadeAmount
        {
            get => highlightFadeAmount;
            set
            {
                if (highlightFadeAmount != value)
                {
                    highlightFadeAmount = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] float highlightScaleMin = 0.75f;

        public float HighlightScaleMin
        {
            get => highlightScaleMin;
            set
            {
                if (highlightScaleMin != value)
                {
                    highlightScaleMin = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] float highlightScaleMax = 1.1f;

        public float HighlightScaleMax
        {
            get => highlightScaleMax;
            set
            {
                if (highlightScaleMax != value)
                {
                    highlightScaleMax = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] float highlightFadeSpeed = 1f;

        public float HighlightFadeSpeed
        {
            get => highlightFadeSpeed;
            set
            {
                if (highlightFadeSpeed != value)
                {
                    highlightFadeSpeed = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] float highlightMinimumTerrainDistance = 35f;

        /// <summary>
        /// Minimum distance from camera for cells to be highlighted on terrain
        /// </summary>
        public float HighlightMinimumTerrainDistance
        {
            get => highlightMinimumTerrainDistance;
            set
            {
                if (highlightMinimumTerrainDistance != value)
                {
                    highlightMinimumTerrainDistance = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] HIGHLIGHT_EFFECT highlightEffect = HIGHLIGHT_EFFECT.Default;

        public HIGHLIGHT_EFFECT HighlightEffect
        {
            get => highlightEffect;
            set
            {
                if (highlightEffect != value)
                {
                    highlightEffect = value;
                    isDirty = true;
                    UpdateHighlightEffect();
                }
            }
        }

        [SerializeField] OVERLAY_MODE overlayMode = OVERLAY_MODE.Overlay;

        public OVERLAY_MODE OverlayMode
        {
            get => overlayMode;
            set
            {
                if (overlayMode != value)
                {
                    overlayMode = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] Vector2 gridCenter;

        /// <summary>
        /// Center of the grid relative to the Terrain (by default, 0,0, which means center of terrain)
        /// </summary>
        public Vector2 GridCenter
        {
            get => gridCenter;
            set
            {
                if (gridCenter != value)
                {
                    gridCenter = value;
                    isDirty = true;
                    CellsUpdateBounds();
                    UpdateTerritoryBoundaries();
                    Redraw();
                }
            }
        }

        [SerializeField] Vector3 gridCenterWorldPosition;

        /// <summary>
        /// Center of the grid in world space coordinates. You can also use this property to reposition the grid on a given world position coordinate.
        /// </summary>
        public Vector3 GridCenterWorldPosition
        {
            get => GetWorldSpacePosition(gridCenter);
            set => SetGridCenterWorldPosition(value, false);
        }


        [SerializeField] Vector2 gridScale = new Vector2(1, 1);

        /// <summary>
        /// Scale of the grid on the Terrain (by default, 1,1, which means occupy entire terrain)
        /// </summary>
        public Vector2 GridScale
        {
            get => gridScale;
            set
            {
                if (gridScale != value)
                {
                    gridScale = value;
                    ComputeGridScale();
                    isDirty = true;
                    CellsUpdateBounds();
                    UpdateTerritoryBoundaries();
                    Redraw();
                }
            }
        }

        [SerializeField] float gridElevation = 0;

        public float GridElevation
        {
            get => gridElevation;
            set
            {
                if (gridElevation != value)
                {
                    gridElevation = value;
                    isDirty = true;
                    FitToTerrain();
                }
            }
        }

        [SerializeField] float gridElevationBase = 0;

        public float GridElevationBase
        {
            get => gridElevationBase;
            set
            {
                if (gridElevationBase != value)
                {
                    gridElevationBase = value;
                    isDirty = true;
                    FitToTerrain();
                }
            }
        }

        public float GridElevationCurrent => gridElevation + gridElevationBase;

        [SerializeField] float gridCameraOffset = 0;

        public float GridCameraOffset
        {
            get => gridCameraOffset;
            set
            {
                if (gridCameraOffset != value)
                {
                    gridCameraOffset = value;
                    isDirty = true;
                    FitToTerrain();
                }
            }
        }

        [SerializeField] float gridNormalOffset = 0;

        public float GridNormalOffset
        {
            get => gridNormalOffset;
            set
            {
                if (gridNormalOffset != value)
                {
                    gridNormalOffset = value;
                    isDirty = true;
                    Redraw();
                }
            }
        }

        [Obsolete("Use gridMeshDepthOffset or gridSurfaceDepthOffset.")]
        public int GridDepthOffset
        {
            get => gridMeshDepthOffset;
            set => GridMeshDepthOffset = value;
        }

        [SerializeField] int gridMeshDepthOffset = -1;

        public int GridMeshDepthOffset
        {
            get => gridMeshDepthOffset;
            set
            {
                if (gridMeshDepthOffset != value)
                {
                    gridMeshDepthOffset = value;
                    UpdateMaterialDepthOffset();
                    isDirty = true;
                }
            }
        }


        [SerializeField] int gridSurfaceDepthOffset = -1;

        public int GridSurfaceDepthOffset
        {
            get => gridSurfaceDepthOffset;
            set
            {
                if (gridSurfaceDepthOffset != value)
                {
                    gridSurfaceDepthOffset = value;
                    UpdateMaterialDepthOffset();
                    isDirty = true;
                }
            }
        }


        [SerializeField] float gridRoughness = 0.01f;

        public float GridRoughness
        {
            get => gridRoughness;
            set
            {
                if (gridRoughness != value)
                {
                    gridRoughness = value;
                    isDirty = true;
                    Redraw();
                }
            }
        }

        [SerializeField] int cellRowCount = 8;

        /// <summary>
        /// Returns the number of rows for box and hexagonal grid topologies
        /// </summary>
        public int RowCount
        {
            get => cellRowCount;
            set
            {
                if (value != cellRowCount)
                {
                    cellRowCount = Mathf.Clamp(value, 2, 300);
                    isDirty = true;
                    GenerateMap();
                }
            }
        }

        /// <summary>
        /// Returns the number of rows for box and hexagonal grid topologies
        /// </summary>
        [Obsolete("Use rowCount instead.")]
        public int CellRowCount
        {
            get => RowCount;
            set => RowCount = value;
        }


        [SerializeField] int cellColumnCount = 8;

        /// <summary>
        /// Returns the number of columns for box and hexagonal grid topologies
        /// </summary>
        public int ColumnCount
        {
            get => cellColumnCount;
            set
            {
                if (value != cellColumnCount)
                {
                    cellColumnCount = Mathf.Clamp(value, 2, 300);
                    isDirty = true;
                    GenerateMap();
                }
            }
        }

        /// <summary>
        /// Returns the number of columns for box and hexagonal grid topologies
        /// </summary>
        [Obsolete("Use columnCount instead.")]
        public int CellColumnCount
        {
            get => ColumnCount;
            set => ColumnCount = value;
        }

        public Texture2D[] textures;


        [SerializeField] bool respectOtherUI = true;

        /// <summary>
        /// When enabled, will prevent interaction if pointer is over an UI element
        /// </summary>
        public bool RespectOtherUI
        {
            get => respectOtherUI;
            set
            {
                if (value != respectOtherUI)
                {
                    respectOtherUI = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] bool nearClipFadeEnabled = true;

        /// <summary>
        /// When enabled, lines near the camera will fade out gracefully
        /// </summary>
        public bool NearClipFadeEnabled
        {
            get => nearClipFadeEnabled;
            set
            {
                if (value != nearClipFadeEnabled)
                {
                    nearClipFadeEnabled = value;
                    isDirty = true;
                    UpdateMaterialNearClipFade();
                }
            }
        }

        [SerializeField] float nearClipFade = 25f;

        public float NearClipFade
        {
            get => nearClipFade;
            set
            {
                if (nearClipFade != value)
                {
                    nearClipFade = value;
                    isDirty = true;
                    UpdateMaterialNearClipFade();
                }
            }
        }

        [SerializeField] float nearClipFadeFallOff = 50f;

        public float NearClipFadeFallOff
        {
            get => nearClipFadeFallOff;
            set
            {
                if (nearClipFadeFallOff != value)
                {
                    nearClipFadeFallOff = Mathf.Max(value, 0.001f);
                    isDirty = true;
                    UpdateMaterialNearClipFade();
                }
            }
        }

        [SerializeField] bool enableGridEditor = true;

        /// <summary>
        /// Enabled grid editing options in Scene View
        /// </summary>
        public bool EnableGridEditor
        {
            get => enableGridEditor;
            set
            {
                if (value != enableGridEditor)
                {
                    enableGridEditor = value;
                    isDirty = true;
                }
            }
        }

        public static TerrainGridSystem Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = FindObjectOfType<TerrainGridSystem>();
                    if (_instance == null)
                    {
                        Debug.LogWarning("TerrainGridSystem gameobject not found in the scene!");
                    }
                }

                return _instance;
            }
        }

        /// <summary>
        /// Returns a reference of the currently highlighted gameobject (cell or territory)
        /// </summary>
        public GameObject HighlightedObj => _highlightedObj;


        #region Public General Functions

        /// <summary>
        /// Used to cancel highlighting on a given gameobject. This call is ignored if go is not currently highlighted.
        /// </summary>
        public void HideHighlightedObject(GameObject go)
        {
            if (go != _highlightedObj)
                return;
            _cellHighlightedIndex = -1;
            _cellHighlighted = null;
            _territoryHighlightedIndex = -1;
            _territoryHighlighted = null;
            _territoryLastOver = null;
            _territoryLastOverIndex = -1;
            _highlightedObj = null;
            ClearLastOver();
        }

        public void SetGridCenterWorldPosition(Vector3 position, bool snapToGrid)
        {
            if (snapToGrid)
            {
                position = SnapToCell(position, true, false);
            }

            if (Terrain != null)
            {
                position -= TerrainCenter;
                position.x /= terrainWidth;
                position.z /= terrainDepth;
                GridCenter = new Vector2(position.x, position.z);
            }
            else
            {
                transform.position = position;
            }
        }

        /// <summary>
        /// Snaps a position to the grid
        /// </summary>
        public Vector3 SnapToCell(Vector3 position, bool worldSpace = true, bool snapToCenter = true)
        {
            if (worldSpace) position = transform.InverseTransformPoint(position);
            position.x = (float)Math.Round(position.x, 6);
            position.y = (float)Math.Round(position.y, 6);
            if (gridTopology == GRID_TOPOLOGY.Box)
            {
                float stepX = gridScale.x / cellColumnCount;
                position.x -= gridCenter.x;
                if (snapToCenter && cellColumnCount % 2 == 0)
                {
                    position.x = (Mathf.FloorToInt(position.x / stepX) + 0.5f) * stepX;
                }
                else
                {
                    position.x = (Mathf.FloorToInt(position.x / stepX + 0.5f)) * stepX;
                }

                position.x += gridCenter.x;
                float stepY = gridScale.y / cellRowCount;
                position.y -= gridCenter.y;
                if (snapToCenter && cellRowCount % 2 == 0)
                {
                    position.y = (Mathf.FloorToInt(position.y / stepY) + 0.5f) * stepY;
                }
                else
                {
                    position.y = (Mathf.FloorToInt(position.y / stepY + 0.5f)) * stepY;
                }

                position.y += gridCenter.y;
            }
            else if (gridTopology == GRID_TOPOLOGY.Hexagonal)
            {
                if (snapToCenter)
                {
                    Cell cell = CellGetAtPosition(position);
                    if (cell != null)
                    {
                        position = cell.scaledCenter;
                    }
                }
                else
                {
                    float qx = 1f + (cellColumnCount - 1f) * 3f / 4f;
                    float qy = cellRowCount + 0.5f;

                    float stepX = gridScale.x / qx;
                    float stepY = gridScale.y / qy;

                    float halfStepX = stepX * 0.5f;
                    float halfStepY = stepY * 0.5f;

                    int evenLayout = this.evenLayout ? 1 : 0;

                    float k = Mathf.FloorToInt(position.x * cellColumnCount / gridScale.x);
                    float j = Mathf.FloorToInt(position.y * cellRowCount / gridScale.y);
                    position.x = k * stepX; // + halfStepX;
                    position.y = j * stepY;
                    position.x -= k * halfStepX / 2;
                    float offsetY = (k % 2 == evenLayout) ? 0 : -halfStepY;
                    position.y += offsetY;
                }
            }
            else
            {
                // try to get cell under position and returns its center
                Cell c = CellGetAtPosition(position);
                if (c != null)
                {
                    position = c.center;
                }
            }

            if (worldSpace) position = transform.TransformPoint(position);
            return position;
        }

        /// <summary>
        /// Returns the rectangle area where cells are drawn in local or world space coordinates.
        /// </summary>
        /// <returns>The rect.</returns>
        public Rect GetRect(bool worldSpace = true)
        {
            Rect rect = new Rect();
            Vector3 min = GetScaledVector(new Vector3(-0.5f, -0.5f, 0));
            Vector3 max = GetScaledVector(new Vector3(0.5f, 0.5f, 0));
            if (worldSpace)
            {
                min = transform.TransformPoint(min);
                max = transform.TransformPoint(max);
            }

            rect.min = min;
            rect.max = max;
            return rect;
        }

        /// <summary>
        /// Hides current highlighting effect
        /// </summary>
        public void HideHighlightedRegions()
        {
            HideTerritoryRegionHighlight();
            HideCellRegionHighlight();
        }

        #endregion
    }
}
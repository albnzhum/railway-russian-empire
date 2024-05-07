using UnityEngine;
using System;
using System.Text;
using System.Collections.Generic;
using TGS.Geom;

namespace TGS
{
    /* Event definitions */
    public delegate void CellEvent(int cellIndex);

    public delegate void CellHighlightEvent(int cellIndex, ref bool cancelHighlight);

    public delegate void CellClickEvent(int cellIndex, int buttonIndex);

    public partial class TerrainGridSystem : MonoBehaviour
    {
        public event CellEvent OnCellEnter;
        public event CellEvent OnCellExit;

        /// <summary>
        /// Occurs when user presses the mouse button on a cell
        /// </summary>
        public event CellClickEvent OnCellMouseDown;

        /// <summary>
        /// Occurs when user releases the mouse button on the same cell that started clicking
        /// </summary>
        public event CellClickEvent OnCellClick;

        /// <summary>
        /// Occurs when user releases the mouse button on any cell
        /// </summary>
        public event CellClickEvent OnCellMouseUp;

        /// <summary>
        /// Occurs when a cell is about to get highlighted
        /// </summary>
        public event CellHighlightEvent OnCellHighlight;

        /// <summary>
        /// Complete array of states and cells and the territory name they belong to.
        /// </summary>
        [NonSerialized] public List<Cell> Cells;


        [SerializeField] int numCells = 3;

        /// <summary>
        /// Gets or sets the desired number of cells in irregular topology.
        /// </summary>
        public int NumCells
        {
            get => numCells;
            set
            {
                if (numCells != value)
                {
                    numCells = Mathf.Clamp(value, 2, 20000);
                    GenerateMap();
                    isDirty = true;
                }
            }
        }


        [SerializeField] bool showCells = true;

        /// <summary>
        /// Toggle cells frontiers visibility.
        /// </summary>
        public bool ShowCells
        {
            get => showCells;
            set
            {
                if (value != showCells)
                {
                    showCells = value;
                    isDirty = true;
                    if (cellLayer != null)
                    {
                        cellLayer.SetActive(showCells);
                        ClearLastOver();
                    }
                    else if (showCells)
                    {
                        Redraw();
                    }
                }
            }
        }

        [SerializeField] Color cellBorderColor = new Color(0, 1, 0, 1.0f);

        /// <summary>
        /// Cells border color
        /// </summary>
        public Color CellBorderColor
        {
            get => cellBorderColor;
            set
            {
                if (value != cellBorderColor)
                {
                    cellBorderColor = value;
                    isDirty = true;
                    if (cellsThinMat != null && cellBorderColor != cellsThinMat.color)
                    {
                        cellsThinMat.color = cellBorderColor;
                    }

                    if (cellsGeoMat != null && cellBorderColor != cellsGeoMat.color)
                    {
                        cellsGeoMat.color = cellBorderColor;
                    }
                }
            }
        }

        [SerializeField] float cellBorderThickness = 1f;

        /// <summary>
        /// Cells border thickness
        /// </summary>
        public float CellBorderThickness
        {
            get => cellBorderThickness;
            set
            {
                if (value != cellBorderThickness)
                {
                    cellBorderThickness = value;
                    if (showCells)
                        DrawCellBorders();
                    isDirty = true;
                }
            }
        }

        public float CellBorderAlpha
        {
            get => cellBorderColor.a;
            set
            {
                if (cellBorderColor.a != value)
                {
                    CellBorderColor = new Color(cellBorderColor.r, cellBorderColor.g, cellBorderColor.b,
                        Mathf.Clamp01(value));
                }
            }
        }


        [SerializeField] Color cellHighlightColor = new Color(1, 0, 0, 0.9f);

        /// <summary>
        /// Fill color to use when the mouse hovers a cell's region.
        /// </summary>
        public Color CellHighlightColor
        {
            get => cellHighlightColor;
            set
            {
                if (value != cellHighlightColor)
                {
                    cellHighlightColor = value;
                    isDirty = true;
                    if (hudMatCellOverlay != null && cellHighlightColor != hudMatCellOverlay.color)
                    {
                        hudMatCellOverlay.color = cellHighlightColor;
                    }

                    if (hudMatCellGround != null && cellHighlightColor != hudMatCellGround.color)
                    {
                        hudMatCellGround.color = cellHighlightColor;
                    }
                }
            }
        }

        [SerializeField] bool cellHighlightNonVisible = true;

        /// <summary>
        /// Gets or sets whether invisible cells should also be highlighted when pointer is over them
        /// </summary>
        public bool CellHighlightNonVisible
        {
            get => cellHighlightNonVisible;
            set
            {
                if (cellHighlightNonVisible != value)
                {
                    cellHighlightNonVisible = value;
                    isDirty = true;
                }
            }
        }

        /// <summary>
        /// Returns Cell under mouse position or null if none.
        /// </summary>
        public Cell CellHighlighted => _cellHighlighted;

        /// <summary>
        /// Returns current highlighted cell index.
        /// </summary>
        public int CellHighlightedIndex => _cellHighlightedIndex;

        /// <summary>
        /// Returns Cell index which has been clicked
        /// </summary>
        public int CellLastClickedIndex => _cellLastClickedIndex;


        [SerializeField] float cellsMaxSlope = 1f;

        /// <summary>
        /// Gets or sets the cells max slope. Cells with a greater slope will be hidden.
        /// </summary>
        /// <value>The cells max slope.</value>
        public float CellsMaxSlope
        {
            get => cellsMaxSlope;
            set
            {
                if (cellsMaxSlope != value)
                {
                    cellsMaxSlope = value;
                    needUpdateTerritories = true;
                    Redraw(true);
                }
            }
        }

        [SerializeField] float cellsMinimumAltitude = 0f;

        /// <summary>
        /// Gets or sets the minimum cell altitude. Useful to hide cells under certain altitude, for instance, under water.
        /// </summary>
        public float CellsMinimumAltitude
        {
            get => cellsMinimumAltitude;
            set
            {
                if (cellsMinimumAltitude != value)
                {
                    cellsMinimumAltitude = value;
                    needUpdateTerritories = true;
                    Redraw(true);
                }
            }
        }

        #region Public Cell Functions

        [NonSerialized] List<Vector2> _voronoiSites;

        /// <summary>
        /// Sets or gets a list of Voronoi sites. Full list will be completed with random number up to numCells amount.
        /// </summary>
        /// <value>The voronoi sites.</value>
        public List<Vector2> VoronoiSites
        {
            get => _voronoiSites;
            set
            {
                if (_voronoiSites != value)
                {
                    _voronoiSites = value;
                    GenerateMap();
                }
            }
        }

        /// <summary>
        /// Returns the _numCells index in the cells array by its reference.
        /// </summary>
        public int CellGetIndex(Cell cell)
        {
            if (cell == null)
                return -1;
            if (cellLookup.TryGetValue(cell, out var index))
                return index;
            else
                return -1;
        }

        /// <summary>
        /// Returns the_numCells rovince in the cells array by its reference.
        /// </summary>
        /// <returns>The get index.</returns>
        /// <param name="row">Row.</param>
        /// <param name="column">Column.</param>
        /// <param name="clampToBorders">If set to <c>true</c> row and column values will be clamped inside current grid size (in case their values exceed the number of rows or columns). If set to false, it will wrap around edges.</param>
        public int CellGetIndex(int row, int column, bool clampToBorders = true)
        {
            if (gridTopology != GRID_TOPOLOGY.Box && gridTopology != GRID_TOPOLOGY.Hexagonal)
            {
                Debug.LogWarning("Grid topology does not support row/column indexing.");
                return -1;
            }

            if (clampToBorders)
            {
                row = Mathf.Clamp(row, 0, cellRowCount - 1);
                column = Mathf.Clamp(column, 0, cellColumnCount - 1);
            }
            else
            {
                row = (row + cellRowCount) % cellRowCount;
                column = (column + cellColumnCount) % cellColumnCount;
            }

            return row * cellColumnCount + column;
        }

        /// <summary>
        /// Colorize specified region of a cell by indexes.
        /// </summary>
        /// <returns>The generated color surface positioned and oriented over the given cell.</returns>
        /// <param name="cellIndex">Cell index.</param>
        /// <param name="visible">If the colored surface is shown or not.</param>
        /// <param name="texture">Texture to be used.</param>
        public GameObject CellToggleRegionSurface(int cellIndex, bool visible, Texture2D texture)
        {
            return CellToggleRegionSurface(cellIndex, visible, Color.white, false, texture, Misc.Vector2one,
                Misc.Vector2zero, 0, false);
        }

        /// <summary>
        /// Colorize specified region of a cell by indexes.
        /// </summary>
        /// <returns>The generated color surface positioned and oriented over the given cell.</returns>
        /// <param name="cellIndex">Cell index.</param>
        /// <param name="visible">If the colored surface is shown or not.</param>
        /// <param name="color">Color. Can be partially transparent.</param>
        /// <param name="refreshGeometry">If set to <c>true</c> any cached surface will be destroyed and regenerated. Usually you pass false to improve performance.</param>
        public GameObject CellToggleRegionSurface(int cellIndex, bool visible, Color color,
            bool refreshGeometry = false)
        {
            return CellToggleRegionSurface(cellIndex, visible, color, refreshGeometry, null, Misc.Vector2one,
                Misc.Vector2zero, 0, false);
        }

        /// <summary>
        /// Colorize specified region of a cell by indexes.
        /// </summary>
        /// <returns>The generated color surface positioned and oriented over the given cell.</returns>
        /// <param name="cellIndex">Cell index.</param>
        /// <param name="visible">If the colored surface is shown or not.</param>
        /// <param name="color">Color. Can be partially transparent.</param>
        /// <param name="refreshGeometry">If set to <c>true</c> any cached surface will be destroyed and regenerated. Usually you pass false to improve performance.</param>
        /// <param name="textureIndex">The index of the texture configured in the list of textures of the inspector.</param>
        public GameObject CellToggleRegionSurface(int cellIndex, bool visible, Color color, bool refreshGeometry,
            int textureIndex)
        {
            Texture2D texture = null;
            if (textureIndex >= 0 && textureIndex < textures.Length)
                texture = textures[textureIndex];
            return CellToggleRegionSurface(cellIndex, visible, color, refreshGeometry, texture, Misc.Vector2one,
                Misc.Vector2zero, 0, false);
        }

        /// <summary>
        /// Colorize specified region of a cell by indexes.
        /// </summary>
        /// <returns>The generated color surface positioned and oriented over the given cell.</returns>
        /// <param name="cellIndex">Cell index.</param>
        /// <param name="visible">If the colored surface is shown or not.</param>
        /// <param name="color">Color. Can be partially transparent.</param>
        /// <param name="refreshGeometry">If set to <c>true</c> any cached surface will be destroyed and regenerated. Usually you pass false to improve performance.</param>
        /// <param name="texture">An optional texture. If you pass a color different than white, the texture will be tinted using that color.</param>
        public GameObject CellToggleRegionSurface(int cellIndex, bool visible, Color color, bool refreshGeometry,
            Texture2D texture)
        {
            return CellToggleRegionSurface(cellIndex, visible, color, refreshGeometry, texture, Misc.Vector2one,
                Misc.Vector2zero, 0, false);
        }

        /// <summary>
        /// Colorize specified region of a cell by indexes.
        /// </summary>
        /// <returns>The generated color surface positioned and oriented over the given cell.</returns>
        /// <param name="cellIndex">Cell index.</param>
        /// <param name="visible">If the colored surface is shown or not.</param>
        /// <param name="color">Color. Can be partially transparent.</param>
        /// <param name="refreshGeometry">If set to <c>true</c> any cached surface will be destroyed and regenerated. Usually you pass false to improve performance.</param>
        /// <param name="texture">An optional texture. If you pass a color different than white, the texture will be tinted using that color.</param>
        /// <param name="textureScale">Texture scale.</param>
        /// <param name="textureOffset">Texture offset.</param>
        /// <param name="textureRotation">Texture rotation.</param>
        /// <param name="rotateInLocalSpace"></param>
        public GameObject CellToggleRegionSurface(int cellIndex, bool visible, Color color, bool refreshGeometry,
            Texture2D texture, Vector2 textureScale, Vector2 textureOffset, float textureRotation,
            bool rotateInLocalSpace)
        {
            return CellToggleRegionSurface(cellIndex, visible, color, refreshGeometry, texture, textureScale,
                textureOffset, textureRotation, false, rotateInLocalSpace);
        }

        /// <summary>
        /// Colorize specified region of a cell by indexes.
        /// </summary>
        /// <returns>The generated color surface positioned and oriented over the given cell.</returns>
        /// <param name="cellIndex">Cell index.</param>
        /// <param name="visible">If the colored surface is shown or not.</param>
        /// <param name="color">Color. Can be partially transparent.</param>
        /// <param name="refreshGeometry">If set to <c>true</c> any cached surface will be destroyed and regenerated. Usually you pass false to improve performance.</param>
        /// <param name="texture">An optional texture. If you pass a color different than white, the texture will be tinted using that color.</param>
        /// <param name="textureScale">Texture scale.</param>
        /// <param name="textureOffset">Texture offset.</param>
        /// <param name="textureRotation">Texture rotation.</param>
        /// <param name="overlay">If set to <c>true</c> the colored surface will be shown on top of objects.</param>
        /// <param name="rotateInLocalSpace"></param>
        public GameObject CellToggleRegionSurface(int cellIndex, bool visible, Color color, bool refreshGeometry,
            Texture2D texture, Vector2 textureScale, Vector2 textureOffset, float textureRotation, bool overlay,
            bool rotateInLocalSpace)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return null;

            if (!visible)
            {
                CellHideRegionSurface(cellIndex);
                return null;
            }

            int cacheIndex = GetCacheIndexForCellRegion(cellIndex);
            bool existsInCache = surfaces.TryGetValue(cacheIndex, out GameObject surf);
            if (existsInCache && surf == null)
            {
                surfaces.Remove(cacheIndex);
                existsInCache = false;
            }

            if (refreshGeometry && existsInCache)
            {
                surfaces.Remove(cacheIndex);
                DestroyImmediate(surf);
                existsInCache = false;
                surf = null;
            }

            Region region = Cells[cellIndex].region;

            // Should the surface be recreated?
            Material surfMaterial;
            if (surf != null)
            {
                surfMaterial = surf.GetComponent<Renderer>().sharedMaterial;
                if (texture != null && (textureScale != region.customTextureScale ||
                                        textureOffset != region.customTextureOffset ||
                                        textureRotation != region.customTextureRotation))
                {
                    surfaces.Remove(cacheIndex);
                    DestroyImmediate(surf);
                    surf = null;
                }
            }

            // If it exists, activate and check proper material, if not create surface
            bool isHighlighted = CellHighlightedIndex == cellIndex;
            if (surf != null)
            {
                Material coloredMat = overlay ? coloredMatOverlay : coloredMatGround;
                Material texturizedMat = overlay ? texturizedMatOverlay : texturizedMatGround;
                if (!surf.activeSelf)
                    surf.SetActive(true);
                // Check if material is ok
                Renderer renderer = surf.GetComponent<Renderer>();
                surfMaterial = renderer.sharedMaterial;
                if ((texture == null && !surfMaterial.name.Equals(coloredMat.name)) ||
                    (texture != null && !surfMaterial.name.Equals(texturizedMat.name))
                    || (surfMaterial.color != color && !isHighlighted) || (texture != null &&
                                                                           (region.customMaterial == null ||
                                                                            region.customMaterial.mainTexture !=
                                                                            texture)))
                {
                    Material goodMaterial = GetColoredTexturedMaterial(color, texture, overlay);
                    region.customMaterial = goodMaterial;
                    ApplyMaterialToSurface(renderer, goodMaterial);
                }
            }
            else
            {
                surfMaterial = GetColoredTexturedMaterial(color, texture, overlay);
                surf = GenerateCellRegionSurface(cellIndex, surfMaterial, textureScale, textureOffset, textureRotation,
                    rotateInLocalSpace);
                region.customMaterial = surfMaterial;
                region.customTextureOffset = textureOffset;
                region.customTextureRotation = textureRotation;
                region.customTextureScale = textureScale;
                region.customRotateInLocalSpace = rotateInLocalSpace;
            }

            // If it was highlighted, highlight it again
            if (region.customMaterial != null && isHighlighted)
            {
                if (region.customMaterial != null)
                {
                    hudMatCell.mainTexture = region.customMaterial.mainTexture;
                }
                else
                {
                    hudMatCell.mainTexture = null;
                }

                surf.GetComponent<Renderer>().sharedMaterial = hudMatCell;
                _highlightedObj = surf;
            }

            if (!Cells[cellIndex].visible)
            {
                surf.SetActive(false);
            }

            return surf;
        }

        /// <summary>
        /// Uncolorize/hide specified cell by index in the cells collection.
        /// </summary>
        public void CellHideRegionSurface(int cellIndex)
        {
            if (_cellHighlightedIndex != cellIndex)
            {
                int cacheIndex = GetCacheIndexForCellRegion(cellIndex);
                if (surfaces.TryGetValue(cacheIndex, out GameObject surf))
                {
                    if (surf == null)
                    {
                        surfaces.Remove(cacheIndex);
                    }
                    else
                    {
                        surf.SetActive(false);
                    }
                }
            }

            Cells[cellIndex].region.customMaterial = null;
        }

        /// <summary>
        /// Uncolorize/hide specified all cells.
        /// </summary>
        public void CellHideRegionSurfaces()
        {
            int cellsCount = Cells.Count;
            for (int k = 0; k < cellsCount; k++)
            {
                CellHideRegionSurface(k);
            }
        }

        /// <summary>
        /// Colors a cell and fades it out for "duration" in seconds.
        /// </summary>
        public void CellFadeOut(Cell cell, Color color, float duration)
        {
            int cellIndex = CellGetIndex(cell);
            CellFadeOut(cellIndex, color, duration);
        }

        /// <summary>
        /// Colors a cell and fades it out during "duration" in seconds.
        /// </summary>
        public void CellFadeOut(int cellIndex, Color color, float duration)
        {
            CellAnimate(FADER_STYLE.FadeOut, cellIndex, Misc.ColorNull, color, duration);
        }

        /// <summary>
        /// Fades out a list of cells with "color" and "duration" in seconds.
        /// </summary>
        public void CellFadeOut(List<int> cellIndices, Color color, float duration)
        {
            int cellCount = cellIndices.Count;
            for (int k = 0; k < cellCount; k++)
            {
                CellAnimate(FADER_STYLE.FadeOut, cellIndices[k], Misc.ColorNull, color, duration);
            }
        }

        /// <summary>
        /// Flashes a cell with "color" and "duration" in seconds.
        /// </summary>
        public void CellFlash(int cellIndex, Color color, float duration)
        {
            CellAnimate(FADER_STYLE.Flash, cellIndex, Misc.ColorNull, color, duration);
        }


        /// <summary>
        /// Flashes a cell with "color" and "duration" in seconds.
        /// </summary>
        public void CellFlash(Cell cell, Color color, float duration)
        {
            int cellIndex = CellGetIndex(cell);
            CellAnimate(FADER_STYLE.Flash, cellIndex, Misc.ColorNull, color, duration);
        }

        /// <summary>
        /// Flashes a list of cells with "color" and "duration" in seconds.
        /// </summary>
        public void CellFlash(List<int> cellIndices, Color color, float duration)
        {
            int cellCount = cellIndices.Count;
            for (int k = 0; k < cellCount; k++)
            {
                CellAnimate(FADER_STYLE.Flash, cellIndices[k], Misc.ColorNull, color, duration);
            }
        }


        /// <summary>
        /// Temporarily colors a cell for "duration" in seconds.
        /// </summary>
        public void CellColorTemp(int cellIndex, Color color, float duration)
        {
            CellAnimate(FADER_STYLE.ColorTemp, cellIndex, Misc.ColorNull, color, duration);
        }

        /// <summary>
        /// Temporarily colors a cell for "duration" in seconds.
        /// </summary>
        public void CellColorTemp(Cell cell, Color color, float duration)
        {
            int cellIndex = CellGetIndex(cell);
            CellAnimate(FADER_STYLE.ColorTemp, cellIndex, Misc.ColorNull, color, duration);
        }

        /// <summary>
        /// Temporarily colors a list of cells for "duration" in seconds.
        /// </summary>
        public void CellColorTemp(List<int> cellIndices, Color color, float duration)
        {
            int cellCount = cellIndices.Count;
            for (int k = 0; k < cellCount; k++)
            {
                CellAnimate(FADER_STYLE.ColorTemp, cellIndices[k], Misc.ColorNull, color, duration);
            }
        }

        /// <summary>
        /// Blinks a cell with colors "color1" and "color2" and "duration" in seconds.
        /// </summary>
        public void CellBlink(Cell cell, Color color1, Color color2, float duration)
        {
            int cellIndex = CellGetIndex(cell);
            CellAnimate(FADER_STYLE.Blink, cellIndex, color1, color2, duration);
        }


        /// <summary>
        /// Blinks a cell with colors "color1" and "color2" and "duration" in seconds.
        /// </summary>
        public void CellBlink(int cellIndex, Color color1, Color color2, float duration)
        {
            CellAnimate(FADER_STYLE.Blink, cellIndex, color1, color2, duration);
        }

        /// <summary>
        /// Blinks a list of cells with colors "color1" and "color2" and "duration" in seconds.
        /// </summary>
        public void CellBlink(List<int> cellIndices, Color color1, Color color2, float duration)
        {
            int cellCount = cellIndices.Count;
            for (int k = 0; k < cellCount; k++)
            {
                CellAnimate(FADER_STYLE.Blink, cellIndices[k], color1, color2, duration);
            }
        }


        /// <summary>
        /// Flashes a cell from "initialColor" to "color" and "duration" in seconds.
        /// </summary>
        public void CellFlash(Cell cell, Color initialColor, Color color, float duration)
        {
            int cellIndex = CellGetIndex(cell);
            CellAnimate(FADER_STYLE.Flash, cellIndex, initialColor, color, duration);
        }


        /// <summary>
        /// Flashes a cell from "initialColor" to "color" and "duration" in seconds.
        /// </summary>
        public void CellFlash(int cellIndex, Color initialColor, Color color, float duration)
        {
            CellAnimate(FADER_STYLE.Flash, cellIndex, initialColor, color, duration);
        }

        /// <summary>
        /// Flashes a list of cells from "initialColor" to "color" and "duration" in seconds.
        /// </summary>
        public void CellFlash(List<int> cellIndices, Color initialColor, Color color, float duration)
        {
            int cellCount = cellIndices.Count;
            for (int k = 0; k < cellCount; k++)
            {
                CellAnimate(FADER_STYLE.Flash, cellIndices[k], initialColor, color, duration);
            }
        }

        /// <summary>
        /// Blinks a cell with "color" and "duration" in seconds.
        /// </summary>
        public void CellBlink(Cell cell, Color color, float duration)
        {
            int cellIndex = CellGetIndex(cell);
            CellAnimate(FADER_STYLE.Blink, cellIndex, Misc.ColorNull, color, duration);
        }


        /// <summary>
        /// Blinks a cell with "color" and "duration" in seconds.
        /// </summary>
        public void CellBlink(int cellIndex, Color color, float duration)
        {
            CellAnimate(FADER_STYLE.Blink, cellIndex, Misc.ColorNull, color, duration);
        }

        /// <summary>
        /// Blinks a list of cells with "color" and "duration" in seconds.
        /// </summary>
        public void CellBlink(List<int> cellIndices, Color color, float duration)
        {
            int cellCount = cellIndices.Count;
            for (int k = 0; k < cellCount; k++)
            {
                CellAnimate(FADER_STYLE.Blink, cellIndices[k], Misc.ColorNull, color, duration);
            }
        }

        /// <summary>
        /// Returns the rect enclosing the cell in local or world space coordinates
        /// </summary>
        public Rect CellGetRect(int cellIndex)
        {
            if (Cells == null || cellIndex < 0 || cellIndex >= Cells.Count)
                return new Rect(0, 0, 0, 0);
            Rect rect = Cells[cellIndex].region.rect2D;
            return rect;
        }


        /// <summary>
        /// Returns the rect enclosing the cell in world space
        /// </summary>
        public Bounds CellGetRectWorldSpace(int cellIndex)
        {
            if (Cells == null || cellIndex < 0 || cellIndex >= Cells.Count)
                return new Bounds(Misc.Vector3zero, Misc.Vector3zero);
            Rect rect = Cells[cellIndex].region.rect2D;
            Vector3 min = GetWorldSpacePosition(rect.min);
            Vector3 max = GetWorldSpacePosition(rect.max);
            Bounds bounds = new Bounds((min + max) * 0.5f, max - min);
            return bounds;
        }

        /// <summary>
        /// Returns the size in normalized viewport coordinates (0..1) for the given cell if that cell was on the center of the screen
        /// </summary>
        /// <returns>The get rect screen space.</returns>
        /// <param name="cellIndex">Cell index.</param>
        public Vector2 CellGetViewportSize(int cellIndex)
        {
            Transform t = Camera.main.transform;
            Vector3 oldPos = t.position;
            Quaternion oldRot = t.rotation;

            Plane p = new Plane(transform.forward, transform.position);
            float dist = p.GetDistanceToPoint(oldPos);
            Vector3 cellPos = CellGetPosition(cellIndex);
            t.position = cellPos - transform.forward * dist;
            t.LookAt(cellPos);
            Vector3 cellRectMin = transform.TransformPoint(Cells[cellIndex].region.rect2D.min);
            Vector3 cellRectMax = transform.TransformPoint(Cells[cellIndex].region.rect2D.max);
            Vector3 screenMin = Camera.main.WorldToViewportPoint(cellRectMin);
            Vector3 screenMax = Camera.main.WorldToViewportPoint(cellRectMax);

            t.rotation = oldRot;
            t.position = oldPos;
            return new Vector2(Mathf.Abs(screenMax.x - screenMin.x), Mathf.Abs(screenMax.y - screenMin.y));
        }

        /// <summary>
        /// Gets the cell's center position in world space or local space.
        /// </summary>
        public Vector3 CellGetPosition(int cellIndex, bool worldSpace = true)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return Misc.Vector3zero;
            return CellGetPosition(Cells[cellIndex], worldSpace);
        }

        /// <summary>
        /// Gets the cell's center position in world space.
        /// </summary>
        public Vector3 CellGetPosition(Cell cell, bool worldSpace = true)
        {
            if (cell == null)
                return Misc.Vector3zero;
            Vector2 cellGridCenter = cell.scaledCenter;
            if (worldSpace)
            {
                return GetWorldSpacePosition(cellGridCenter);
            }
            else
            {
                return cellGridCenter;
            }
        }


        /// <summary>
        /// Returns the normal at the center of a cell
        /// </summary>
        /// <returns>The normal in world space coordinates.</returns>
        /// <param name="cellIndex">Cell index.</param>
        public Vector3 CellGetNormal(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count || Terrain == null)
                return Misc.Vector3zero;
            Vector2 cellCenter = Cells[cellIndex].scaledCenter;
            return Terrain.terrainData.GetInterpolatedNormal(cellCenter.x + 0.5f, cellCenter.y + 0.5f);
        }

        /// <summary>
        /// Returns the number of vertices of the cell
        /// </summary>
        public int CellGetVertexCount(int cellIndex)
        {
            if (Cells == null || cellIndex < 0 || cellIndex >= Cells.Count)
                return 0;
            return Cells[cellIndex].region.points.Count;
        }

        /// <summary>
        /// Returns the world space position of the vertex
        /// </summary>
        public Vector3 CellGetVertexPosition(int cellIndex, int vertexIndex)
        {
            Vector2 localPosition = Cells[cellIndex].region.points[vertexIndex];
            return GetWorldSpacePosition(localPosition);
        }


        /// <summary>
        /// Returns a list of neighbour cells for specificed cell.
        /// </summary>
        public List<Cell> CellGetNeighbours(Cell cell)
        {
            int cellIndex = CellGetIndex(cell);
            return CellGetNeighbours(cellIndex);
        }

        /// <summary>
        /// Returns a list of neighbour cells for specificed cell index.
        /// </summary>
        public List<Cell> CellGetNeighbours(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return null;
            List<Cell> neighbours = new List<Cell>();
            Region region = Cells[cellIndex].region;
            int nCount = region.neighbours.Count;
            for (int k = 0; k < nCount; k++)
            {
                neighbours.Add((Cell)region.neighbours[k].entity);
            }

            return neighbours;
        }

        /// <summary>
        /// Get a list of cells which are nearer than a given distance in cell count
        /// </summary>
        public List<int> CellGetNeighbours(int cellIndex, int distance, int cellGroupMask = -1, int maxCost = -1)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return null;
            Cell cell = Cells[cellIndex];
            List<int> cc = new List<int>();
            for (int x = cell.column - distance; x <= cell.column + distance; x++)
            {
                if (x < 0 || x >= cellColumnCount)
                    continue;
                for (int y = cell.row - distance; y <= cell.row + distance; y++)
                {
                    if (y < 0 || y >= cellRowCount)
                        continue;
                    if (x == cell.column && y == cell.row)
                        continue;
                    int ci = CellGetIndex(y, x);
                    List<int> steps = FindPath(cellIndex, ci, maxCost, 0, cellGroupMask);
                    if (steps != null && steps.Count <= distance)
                    {
                        cc.Add(ci);
                    }
                }
            }

            return cc;
        }


        /// <summary>
        /// Returns cell's territory index to which it belongs to.
        /// </summary>
        public int CellGetTerritoryIndex(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return -1;
            return Cells[cellIndex].territoryIndex;
        }

        /// <summary>
        /// Returns current cell's fill color
        /// </summary>
        public Color CellGetColor(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count || Cells[cellIndex].region.customMaterial == null)
                return new Color(0, 0, 0, 0);
            return Cells[cellIndex].region.customMaterial.color;
        }

        /// <summary>
        /// Returns current cell's fill texture
        /// </summary>
        public Texture2D CellGetTexture(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count || Cells[cellIndex].region.customMaterial == null)
                return null;
            return (Texture2D)Cells[cellIndex].region.customMaterial.mainTexture;
        }


        /// <summary>
        /// Sets current cell's fill color. Use CellToggleRegionSurface for more options
        /// </summary>
        public void CellSetColor(int cellIndex, Color color)
        {
            CellToggleRegionSurface(cellIndex, true, color, false, null, Misc.Vector2one, Misc.Vector2zero, 0, false,
                false);
        }


        /// <summary>
        /// Sets current cell's fill texture. Use CellToggleRegionSurface for more options
        /// </summary>
        public void CellSetTexture(int cellIndex, Texture2D texture)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return;
            Cell cell = Cells[cellIndex];
            GameObject cellSurface = null;
            int cacheIndex = GetCacheIndexForCellRegion(cellIndex);
            surfaces.TryGetValue(cacheIndex, out cellSurface);
            if (cellSurface == null)
            {
                CellToggleRegionSurface(cellIndex, true, texture);
                return;
            }

            if (texture != null)
            {
                if (cell.region.customMaterial == null)
                {
                    cell.region.customMaterial =
                        GetColoredTexturedMaterial(Color.white, texture, overlayMode == OVERLAY_MODE.Overlay);
                }

                if (cellSurface != null)
                {
                    surfaces[cacheIndex].SetActive(true);
                }
            }

            if (cell.region.customMaterial != null)
            {
                cell.region.customMaterial.mainTexture = texture;
                Renderer renderer = cellSurface.GetComponent<Renderer>();
                if (renderer != null)
                    renderer.sharedMaterial = cell.region.customMaterial;
            }

            if (_highlightedObj == cellSurface)
            {
                hudMatCell.mainTexture = texture;
            }
        }


        /// <summary>
        /// Returns current cell's fill texture index (if texture exists in textures list).
        /// Texture index is from 1..32. It will return 0 if texture does not exist or it does not match any texture in the list of textures.
        /// </summary>
        public int CellGetTextureIndex(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count || Cells[cellIndex].region.customMaterial == null)
                return 0;
            Texture2D tex = (Texture2D)Cells[cellIndex].region.customMaterial.mainTexture;
            for (int k = 1; k < textures.Length; k++)
            {
                if (tex == textures[k])
                    return k;
            }

            return 0;
        }

        /// <summary>
        /// Returns cell's row or -1 if cellIndex is not valid.
        /// </summary>
        public int CellGetRow(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return -1;
            return Cells[cellIndex].row;
        }

        /// <summary>
        /// Returns cell's column or -1 if cellIndex is not valid.
        /// </summary>
        public int CellGetColumn(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return -1;
            return Cells[cellIndex].column;
        }


        public bool CellIsBorder(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return false;
            Cell cell = Cells[cellIndex];
            return (cell.column == 0 || cell.column == cellColumnCount - 1 || cell.row == 0 ||
                    cell.row == cellRowCount - 1);
        }


        /// <summary>
        /// Returns the_numCellsrovince in the cells array by its reference.
        /// </summary>
        public int TerritoryGetIndex(Territory territory)
        {
            if (territory == null)
                return -1;
            int index;
            if (territoryLookup.TryGetValue(territory, out index))
                return index;
            else
                return -1;
        }

        /// <summary>
        /// Returns true if cell is visible
        /// </summary>
        public bool CellIsVisible(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return false;
            return Cells[cellIndex].visible;
        }


        /// <summary>
        /// Merges cell2 into cell1. Cell2 is removed.
        /// Only cells which are neighbours can be merged.
        /// </summary>
        public bool CellMerge(Cell cell1, Cell cell2)
        {
            if (cell1 == null || cell2 == null)
                return false;
            if (!cell1.region.neighbours.Contains(cell2.region))
                return false;
            cell1.center = (cell2.center + cell1.center) / 2.0f;
            // Polygon UNION operation between both regions
            PolygonClipper pc = new PolygonClipper(cell1.polygon, cell2.polygon);
            pc.Compute(PolygonOp.UNION);
            // Remove cell2 from lists
            CellRemove(cell2);
            // Updates geometry data on cell1
            UpdateCellGeometry(cell1, pc.subject);
            return true;
        }

        /// <summary>
        /// Removes a cell from the cells and territories lists. Note that this operation only removes cell structure but does not affect polygons - mostly internally used
        /// </summary>
        public void CellRemove(Cell cell)
        {
            if (cell == _cellHighlighted)
                HideCellRegionHighlight();
            if (cell == _cellLastOver)
            {
                ClearLastOver();
            }

            int territoryIndex = cell.territoryIndex;
            if (territoryIndex >= 0)
            {
                if (territories[territoryIndex].cells.Contains(cell))
                {
                    territories[territoryIndex].cells.Remove(cell);
                }
            }

            // remove cell from global list
            if (Cells.Contains(cell))
                Cells.Remove(cell);

            needRefreshRouteMatrix = true;
            needUpdateTerritories = true;
        }

        /// <summary>
        /// Tags a cell with a user-defined integer tag. Cell can be later retrieved very quickly using CellGetWithTag.
        /// </summary>
        public void CellSetTag(Cell cell, int tag)
        {
            // remove previous tag register
            if (cellTagged.ContainsKey(cell.tag))
            {
                cellTagged.Remove(cell.tag);
            }

            // override existing tag
            if (cellTagged.ContainsKey(tag))
            {
                cellTagged.Remove(tag);
            }

            cellTagged.Add(tag, cell);
            cell.tag = tag;
        }

        /// <summary>
        /// Tags a cell with a user-defined integer tag. Cell can be later retrieved very quickly using CellGetWithTag.
        /// </summary>
        public void CellSetTag(int cellIndex, int tag)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return;
            CellSetTag(Cells[cellIndex], tag);
        }

        /// <summary>
        /// Returns the tag value of a given cell.
        /// </summary>
        public int CellGetTag(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return 0;
            return Cells[cellIndex].tag;
        }

        /// <summary>
        /// Retrieves Cell object with associated tag.
        /// </summary>
        public Cell CellGetWithTag(int tag)
        {
            if (cellTagged.TryGetValue(tag, out Cell cell))
                return cell;
            return null;
        }


        /// <summary>
        /// Specifies if a given cell can be crossed by using the pathfinding engine.
        /// </summary>
        public void CellSetCanCross(int cellIndex, bool canCross)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return;
            Cells[cellIndex].canCross = canCross;
            needRefreshRouteMatrix = true;
        }

        /// <summary>
        /// Specifies the cell group (by default 1) used by FindPath cellGroupMask optional argument
        /// </summary>
        public void CellSetGroup(int cellIndex, int group)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return;
            Cells[cellIndex].group = group;
            needRefreshRouteMatrix = true;
        }

        /// <summary>
        /// Returns cell group (default 1)
        /// </summary>
        public int CellGetGroup(int cellIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return -1;
            return Cells[cellIndex].group;
        }

        /// <summary>
        /// Specifies if a given cell is visible.
        /// </summary>
        public void CellSetVisible(int cellIndex, bool visible)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return;
            if (Cells[cellIndex].visible == visible)
                return; // nothing to do

            Cells[cellIndex].visible = visible;
            if (cellIndex == _cellLastOverIndex)
            {
                ClearLastOver();
            }

            needRefreshRouteMatrix = true;
            refreshCellMesh = true;
            shouldRedraw = true;
        }


        /// <summary>
        /// Specified visibility for a group of cells that lay within a given rectangle
        /// </summary>
        /// <param name="rect">Rect or boundary. If local space is used, coordinates must be in range (-0.5..0.5)</param>
        /// <param name="visible">If set to <c>true</c> visible.</param>
        /// <param name="worldSpace"></param>
        public bool CellSetVisible(Rect rect, bool visible, bool worldSpace = false)
        {
            return ToggleCellsVisibility(rect, visible, worldSpace);
        }

        /// <summary>
        /// Specified visibility for a group of cells that lay within a given gameObject
        /// </summary>
        /// <param name="obj">GameObject whose mesh or collider will be used.</param>
        /// <param name="visible">If set to <c>true</c> visible.</param>
        public bool CellSetVisible(GameObject obj, bool visible)
        {
            Collider collider = obj.GetComponent<Collider>();
            if (collider != null)
                return CellSetVisible(collider.bounds, visible);
            Renderer renderer = obj.GetComponent<Renderer>();
            if (renderer != null)
                return CellSetVisible(renderer.bounds, visible);
            return false;
        }


        /// <summary>
        /// Specified visibility for a group of cells that lay within a given gameObject
        /// </summary>
        /// <param name="renderer">Renderer whose bounds will be used.</param>
        /// <param name="visible">If set to <c>true</c> visible.</param>
        public bool CellSetVisible(Renderer renderer, bool visible)
        {
            return CellSetVisible(renderer.bounds, visible);
        }


        /// <summary>
        /// Specified visibility for a group of cells that lay within a given collider
        /// </summary>
        /// <param name="collider">Collider that provides boundary.</param>
        /// <param name="visible">If set to <c>true</c> visible.</param>
        public bool CellSetVisible(Collider collider, bool visible)
        {
            if (collider == null)
                return false;
            return CellSetVisible(collider.bounds, visible);
        }


        /// <summary>
        /// Specified visibility for a group of cells that lay within a given bounds
        /// </summary>
        /// <param name="bounds">Bounds in world space coordinates.</param>
        /// <param name="visible">If set to <c>true</c> visible.</param>
        public bool CellSetVisible(Bounds bounds, bool visible)
        {
            Rect rect = new Rect();
            Vector3 pos = bounds.min;
            if (!GetLocalHitFromWorldPosition(ref pos))
                return false;
            rect.min = pos;
            pos = bounds.max;
            if (!GetLocalHitFromWorldPosition(ref pos))
                return false;
            rect.max = pos;
            return ToggleCellsVisibility(rect, visible, false);
        }


        /// <summary>
        /// Returns the cell object under position in local or worldSpace coordinates
        /// </summary>
        /// <returns>The get at position.</returns>
        /// <param name="position">Position.</param>
        /// <param name="worldSpace">If set to <c>true</c>, position is given in world space coordinate units, otherwise position refer to local coordinates.</param>
        /// <param name="territoryIndex">Optional territory index to restrict the search and make it faster.</param>
        public Cell CellGetAtPosition(Vector3 position, bool worldSpace = false, int territoryIndex = -1)
        {
            return GetCellAtPoint(position, worldSpace, territoryIndex);
        }


        /// <summary>
        /// Sets the territory of a cell triggering territory boundary recalculation
        /// </summary>
        /// <returns><c>true</c>, if cell was transferred., <c>false</c> otherwise.</returns>
        public bool CellSetTerritory(int cellIndex, int territoryIndex)
        {
            if (cellIndex < 0 || cellIndex >= Cells.Count)
                return false;
            Cell cell = Cells[cellIndex];
            if (cell.territoryIndex >= 0 && cell.territoryIndex < territories.Count &&
                territories[cell.territoryIndex].cells.Contains(cell))
            {
                territories[cell.territoryIndex].cells.Remove(cell);
            }

            Cells[cellIndex].territoryIndex = territoryIndex;
            needUpdateTerritories = true;
            shouldRedraw = true;
            return true;
        }

        /// <summary>
        /// Returns a string-packed representation of current cells settings.
        /// Each cell separated by ;
        /// Individual settings mean:
        /// Position	Meaning
        /// 0			Visibility (0 = invisible, 1 = visible)
        /// 1			Territory Index
        /// 2			Color R (0..1)
        /// 3			Color G (0..1)
        /// 4			Color B (0..1)
        /// 5			Color A (0..1)
        /// 6			Texture Index
        /// </summary>
        /// <returns>The get configuration data.</returns>
        public string CellGetConfigurationData()
        {
            StringBuilder sb = new StringBuilder();
            int cellsCount = Cells.Count;
            for (int k = 0; k < cellsCount; k++)
            {
                if (k > 0)
                    sb.Append(";");
                // 0
                Cell cell = Cells[k];
                if (cell.visible)
                {
                    sb.Append("1");
                }
                else
                {
                    sb.Append("0");
                }

                // 1 territory index
                sb.Append(",");
                sb.Append(cell.territoryIndex);
                // 2 color.a
                sb.Append(",");
                Color color = CellGetColor(k);
                sb.Append(color.a.ToString("F3"));
                // 3 color.r
                sb.Append(",");
                sb.Append(color.r.ToString("F3"));
                // 4 color.g
                sb.Append(",");
                sb.Append(color.g.ToString("F3"));
                // 5 color.b
                sb.Append(",");
                sb.Append(color.b.ToString("F3"));
                // 6 texture index
                sb.Append(",");
                sb.Append(CellGetTextureIndex(k));
                // 7 tag
                sb.Append(",");
                sb.Append(cell.tag);
            }

            return sb.ToString();
        }

        public void CellSetConfigurationData(string cellData)
        {
            if (Cells == null)
                return;
            string[] cellsInfo = cellData.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            char[] separators = new char[] { ',' };
            for (int k = 0; k < cellsInfo.Length && k < Cells.Count; k++)
            {
                string[] cellInfo = cellsInfo[k].Split(separators, StringSplitOptions.RemoveEmptyEntries);
                int length = cellInfo.Length;
                if (length > 0)
                {
                    if (cellInfo[0].Length > 0)
                    {
                        Cells[k].visible = cellInfo[0][0] != '0'; // cellInfo[0].Equals("0");
                    }
                }

                if (length > 1)
                {
                    Cells[k].territoryIndex = FastConvertToInt(cellInfo[1]);
                }

                Color color = new Color(0, 0, 0, 0);
                if (length > 5)
                {
                    Single.TryParse(cellInfo[2], out color.a);
                    if (color.a > 0)
                    {
                        Single.TryParse(cellInfo[3], out color.r);
                        Single.TryParse(cellInfo[4], out color.g);
                        Single.TryParse(cellInfo[5], out color.b);
                    }
                }

                int textureIndex = -1;
                if (length > 6)
                {
                    textureIndex = FastConvertToInt(cellInfo[6]);
                }

                if (color.a > 0 || textureIndex >= 1)
                {
                    CellToggleRegionSurface(k, true, color, false, textureIndex);
                }

                if (length > 7)
                {
                    CellSetTag(k, FastConvertToInt(cellInfo[7]));
                }
            }

            needUpdateTerritories = true;
            needRefreshRouteMatrix = true;
            Redraw();
            isDirty = true;
        }

        /// <summary>
        /// Returns the cell located at given row and column
        /// </summary>
        public Cell CellGetAtPosition(int column, int row)
        {
            int index = row * cellColumnCount + column;
            if (index >= 0 && index < Cells.Count)
                return Cells[index];
            return null;
        }

        /// <summary>
        /// Traces a line between two positions and check if there's no cell blocking the line
        /// </summary>
        /// <returns><c>true</c>, if there's a straight path of non-blocking cells between the two positions<c>false</c> otherwise.</returns>
        /// <param name="startPosition">Start position.</param>
        /// <param name="endPosition">End position.</param>
        /// <param name="cellIndices">Cell indices.</param>
        /// <param name="cellGroupMask">Optional cell layer mask</param>
        /// <param name="lineResolution">Resolution of the line. Minimum is 1, increase to improve line accuracy.</param>
        /// <param name="exhaustiveCheck">If set to true, all vertices of destination cell will be considered instead of its center</param>
        public bool CellGetLineOfSight(Vector3 startPosition, Vector3 endPosition, ref List<int> cellIndices,
            ref List<Vector3> worldPositions, int cellGroupMask = -1, float lineResolution = 1f,
            bool exhaustiveCheck = false)
        {
            cellIndices = null;

            Cell startCell = CellGetAtPosition(startPosition, true);
            Cell endCell = CellGetAtPosition(endPosition, true);
            if (startCell == null || endCell == null)
            {
                return false;
            }

            int cell1 = CellGetIndex(startCell);
            int cell2 = CellGetIndex(endCell);
            if (cell1 < 0 || cell2 < 0)
                return false;

            return CellGetLineOfSight(cell1, cell2, ref cellIndices, ref worldPositions, cellGroupMask, lineResolution,
                exhaustiveCheck);
        }

        /// <summary>
        /// Traces a line between two positions and check if there's no cell blocking the line
        /// </summary>
        /// <returns><c>true</c>, if there's a straight path of non-blocking cells between the two positions<c>false</c> otherwise.</returns>
        /// <param name="startCellIndex">Start position.</param>
        /// <param name="endCellIndex">End position.</param>
        /// <param name="cellIndices">Cell indices.</param>
        /// <param name="cellGroupMask">Optional cell layer mask</param>
        /// <param name="lineResolution">Resolution of the line. Defaults to 1, increase to improve line accuracy.</param>
        /// <param name="exhaustiveCheck">If set to true, all vertices of destination cell will be considered instead of its center</param>
        public bool CellGetLineOfSight(int startCellIndex, int endCellIndex, ref List<int> cellIndices,
            ref List<Vector3> worldPositions, int cellGroupMask = -1, float lineResolution = 1f,
            bool exhaustiveCheck = false)
        {
            if (cellIndices == null)
                cellIndices = new List<int>();
            else
                cellIndices.Clear();
            if (worldPositions == null)
                worldPositions = new List<Vector3>();
            else
                worldPositions.Clear();
            if (startCellIndex < 0 || startCellIndex >= Cells.Count || endCellIndex < 0 || endCellIndex >= Cells.Count)
                return false;

            Vector3 startPosition = CellGetPosition(startCellIndex);
            Vector3 endPosition;
            int vertexCount = exhaustiveCheck ? Cells[endCellIndex].region.points.Count : 0;
            bool success = true;

            for (int p = 0; p <= vertexCount; p++)
            {
                if (p == 0)
                {
                    endPosition = CellGetPosition(endCellIndex);
                }
                else
                {
                    cellIndices.Clear();
                    worldPositions.Clear();
                    endPosition = CellGetVertexPosition(endCellIndex, p - 1);
                }

                int numSteps;
                if (gridTopology != GRID_TOPOLOGY.Irregular)
                {
                    // Hexagon distance
                    numSteps = CellGetHexagonDistance(startCellIndex, endCellIndex);
                }
                else
                {
                    var stepSize = 1f / lineResolution;
                    float dist = Vector3.Distance(startPosition, endPosition);
                    numSteps = (int)(dist / stepSize);
                }

                Cell lastCell = null;
                success = true;
                for (int k = 1; k <= numSteps; k++)
                {
                    Vector3 position = Vector3.Lerp(startPosition, endPosition, (float)k / numSteps);
                    Cell cell = k == numSteps ? Cells[endCellIndex] : CellGetAtPosition(position, true);
                    if (cell != null && cell != lastCell)
                    {
                        if (cell != Cells[endCellIndex])
                        {
                            if (!cell.canCross || (cell.group & cellGroupMask) == 0)
                            {
                                success = false;
                                break;
                            }
                        }

                        cellIndices.Add(CellGetIndex(cell));
                    }

                    worldPositions.Add(position);
                    lastCell = cell;
                }

                if (success)
                {
                    if (p == 0)
                        return true;
                    break;
                }
            }

            if (success && exhaustiveCheck)
            {
                CellGetLine(startCellIndex, endCellIndex, ref cellIndices, ref worldPositions, lineResolution);
                return true;
            }

            return success;
        }

        /// <summary>
        /// Returns a line composed of cells and world positions from starting cell to ending cell
        /// </summary>
        /// <returns><c>true</c>, if there's a straight path of non-blocking cells between the two positions<c>false</c> otherwise.</returns>
        /// <param name="startCellIndex">Start position.</param>
        /// <param name="endCellIndex">End position.</param>
        /// <param name="cellIndices">Cell indices.</param>
        /// <param name="lineResolution">Resolution of the line. Defaults to 1, increase to improve line accuracy.</param>
        public void CellGetLine(int startCellIndex, int endCellIndex, ref List<int> cellIndices,
            ref List<Vector3> worldPositions, float lineResolution = 1f)
        {
            if (cellIndices == null)
                cellIndices = new List<int>();
            else
                cellIndices.Clear();
            if (worldPositions == null)
                worldPositions = new List<Vector3>();
            else
                worldPositions.Clear();
            if (startCellIndex < 0 || startCellIndex >= Cells.Count || endCellIndex < 0 || endCellIndex >= Cells.Count)
                return;

            Vector3 startPosition = CellGetPosition(startCellIndex);
            Vector3 endPosition = CellGetPosition(endCellIndex);

            int numSteps;
            if (gridTopology != GRID_TOPOLOGY.Irregular)
            {
                // Hexagon distance
                numSteps = CellGetHexagonDistance(startCellIndex, endCellIndex);
            }
            else
            {
                var stepSize = 1f / lineResolution;
                float dist = Vector3.Distance(startPosition, endPosition);
                numSteps = (int)(dist / stepSize);
            }

            Cell lastCell = null;
            for (int k = 1; k <= numSteps; k++)
            {
                Vector3 position = Vector3.Lerp(startPosition, endPosition, (float)k / numSteps);
                Cell cell = CellGetAtPosition(position, true);
                if (cell != null && cell != lastCell)
                {
                    cellIndices.Add(CellGetIndex(cell));
                }

                worldPositions.Add(position);
                lastCell = cell;
            }
        }

        /// <summary>
        /// Returns the hexagon distance between two cells (number of steps to reach end cell from start cell).
        /// This method does not take into account cell masks or blocking cells. It just returns the distance.
        /// </summary>
        /// <returns>The get hexagon distance.</returns>
        /// <param name="startCellIndex">Start cell index.</param>
        /// <param name="endCellIndex">End cell index.</param>
        public int CellGetHexagonDistance(int startCellIndex, int endCellIndex)
        {
            if (Cells == null)
                return -1;
            int cellCount = Cells.Count;
            if (startCellIndex < 0 || startCellIndex >= cellCount || endCellIndex < 0 || endCellIndex >= cellCount)
                return -1;
            int r0 = Cells[startCellIndex].row;
            int c0 = Cells[startCellIndex].column;
            int r1 = Cells[endCellIndex].row;
            int c1 = Cells[endCellIndex].column;
            int offset = evenLayout ? 0 : 1;
            int y0 = r0 - Mathf.FloorToInt((c0 + offset) / 2);
            int x0 = c0;
            int y1 = r1 - Mathf.FloorToInt((c1 + offset) / 2);
            int x1 = c1;
            int dx = x1 - x0;
            int dy = y1 - y0;
            int numSteps = Mathf.Max(Mathf.Abs(dx), Mathf.Abs(dy));
            numSteps = Mathf.Max(numSteps, Mathf.Abs(dx + dy));
            return numSteps;
        }

        /// <summary>
        /// Removes any color or texture from a cell and hides it
        /// </summary>
        /// <param name="cellIndex">Cell index.</param>
        public void CellClear(int cellIndex)
        {
            List<int> cellIndices = new List<int> { cellIndex };
            CellClear(cellIndices);
        }

        /// <summary>
        /// Removes any color or texture from a list of cells and hides them
        /// </summary>
        /// <param name="cellIndices">Cell indices.</param>
        public void CellClear(List<int> cellIndices)
        {
            if (cellIndices == null)
                return;

            int count = cellIndices.Count;
            for (int k = 0; k < count; k++)
            {
                // Check if cell has a SurfaceFader animator
                int cellIndex = cellIndices[k];
                Cell cell = Cells[cellIndex];
                if (cell.region.surfaceGameObject != null)
                {
                    SurfaceFader sf = cell.region.surfaceGameObject.GetComponent<SurfaceFader>();
                    if (sf != null)
                    {
                        sf.Finish();
                    }

                    cell.region.surfaceGameObject.SetActive(false);
                }

                if (cell.region.customMaterial != null)
                {
                    cell.region.customMaterial = null;
                }
            }
        }

        /// <summary>
        /// Pregenerates and caches cell geometry for faster performance during gameplay
        /// </summary>
        public void WarmCells()
        {
            int cellCount = Cells.Count;
            Material mat = GetColoredTexturedMaterial(Color.white, null, false);
            for (int k = 0; k < cellCount; k++)
            {
                GenerateCellRegionSurface(k, mat, Misc.Vector2one, Misc.Vector2zero, 0, false);
            }
        }

        #endregion
    }
}
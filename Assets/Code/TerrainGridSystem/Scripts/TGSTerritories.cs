using UnityEngine;
using System;
using System.Collections.Generic;
using UnityEngine.Serialization;

namespace TGS
{
    /* Event definitions */
    public delegate void TerritoryEvent(int territoryIndex);

    public delegate void TerritoryHighlightEvent(int territoryIndex, ref bool cancelHighlight);

    public delegate void TerritoryClickEvent(int territoryIndex, int buttonIndex);

    public partial class TerrainGridSystem
    {
        public event TerritoryEvent OnTerritoryEnter;
        public event TerritoryEvent OnTerritoryExit;

        /// <summary>
        /// Occurs when user press the mouse button on a territory
        /// </summary>
        public event TerritoryClickEvent OnTerritoryMouseDown;

        /// <summary>
        /// Occurs when user releases the mouse button on the same territory that started clicking
        /// </summary>
        public event TerritoryClickEvent OnTerritoryClick;

        /// <summary>
        /// Occurs when user releases the mouse button on a territory
        /// </summary>
        public event TerritoryClickEvent OnTerritoryMouseUp;

        /// <summary>
        /// Occurs when a territory is about to get highlighted
        /// </summary>
        public event TerritoryHighlightEvent OnTerritoryHighlight;

        [NonSerialized] public List<Territory> Territories;

        public Texture2D territoriesTexture;
        public Color territoriesTextureNeutralColor;


        [SerializeField] int numTerritories = 3;

        /// <summary>
        /// Gets or sets the number of territories.
        /// </summary>
        public int NumTerritories
        {
            get => numTerritories;
            set
            {
                if (numTerritories != value)
                {
                    numTerritories = Mathf.Clamp(value, 1, MAX_TERRITORIES);
                    GenerateMap();
                    isDirty = true;
                }
            }
        }

        [SerializeField] bool showTerritories = false;

        /// <summary>
        /// Toggle frontiers visibility.
        /// </summary>
        public bool ShowTerritories
        {
            get => showTerritories;
            set
            {
                if (value != showTerritories)
                {
                    showTerritories = value;
                    isDirty = true;
                    if (!showTerritories && _territoryLayer != null)
                    {
                        _territoryLayer.SetActive(false);
                        ClearLastOver();
                    }
                    else
                    {
                        Redraw();
                    }
                }
            }
        }

        [SerializeField] bool colorizeTerritories = false;

        /// <summary>
        /// Toggle colorize countries.
        /// </summary>
        public bool ColorizeTerritories
        {
            get => colorizeTerritories;
            set
            {
                if (value != colorizeTerritories)
                {
                    colorizeTerritories = value;
                    isDirty = true;
                    if (!colorizeTerritories && SurfacesLayer != null)
                    {
                        DestroySurfaces();
                    }
                    else
                    {
                        Redraw();
                    }
                }
            }
        }

        [SerializeField] float colorizedTerritoriesAlpha = 0.7f;

        public float ColorizedTerritoriesAlpha
        {
            get => colorizedTerritoriesAlpha;
            set
            {
                if (colorizedTerritoriesAlpha != value)
                {
                    colorizedTerritoriesAlpha = value;
                    isDirty = true;
                    UpdateColorizedTerritoriesAlpha();
                }
            }
        }


        [SerializeField] Color territoryHighlightColor = new Color(1, 0, 0, 0.9f);

        /// <summary>
        /// Fill color to use when the mouse hovers a territory's region.
        /// </summary>
        public Color TerritoryHighlightColor
        {
            get => territoryHighlightColor;
            set
            {
                if (value != territoryHighlightColor)
                {
                    territoryHighlightColor = value;
                    isDirty = true;
                    if (_hudMatTerritoryOverlay != null && territoryHighlightColor != _hudMatTerritoryOverlay.color)
                    {
                        _hudMatTerritoryOverlay.color = territoryHighlightColor;
                    }

                    if (_hudMatTerritoryGround != null && territoryHighlightColor != _hudMatTerritoryGround.color)
                    {
                        _hudMatTerritoryGround.color = territoryHighlightColor;
                    }
                }
            }
        }


        [SerializeField] Color territoryFrontierColor = new Color(0, 1, 0, 1.0f);

        /// <summary>
        /// Territories border color
        /// </summary>
        public Color TerritoryFrontiersColor
        {
            get
            {
                if (_territoriesMat != null)
                {
                    return _territoriesMat.color;
                }
                else
                {
                    return territoryFrontierColor;
                }
            }
            set
            {
                if (value != territoryFrontierColor)
                {
                    territoryFrontierColor = value;
                    isDirty = true;
                    if (_territoriesMat != null && territoryFrontierColor != _territoriesMat.color)
                    {
                        _territoriesMat.color = territoryFrontierColor;
                    }
                }
            }
        }

        public float TerritoryFrontiersAlpha
        {
            get => territoryFrontierColor.a;
            set
            {
                if (territoryFrontierColor.a != value)
                {
                    territoryFrontierColor = new Color(territoryFrontierColor.r, territoryFrontierColor.g,
                        territoryFrontierColor.b, value);
                }

                if (territoryDisputedFrontierColor.a != value)
                {
                    territoryDisputedFrontierColor = new Color(territoryDisputedFrontierColor.r,
                        territoryDisputedFrontierColor.g, territoryDisputedFrontierColor.b, value);
                }
            }
        }


        [SerializeField] Color territoryDisputedFrontierColor;

        /// <summary>
        /// Territories disputed borders color
        /// </summary>
        public Color TerritoryDisputedFrontierColor
        {
            get
            {
                if (_territoriesDisputedMat != null)
                {
                    return _territoriesDisputedMat.color;
                }
                else
                {
                    return territoryDisputedFrontierColor;
                }
            }
            set
            {
                if (value != territoryDisputedFrontierColor)
                {
                    territoryDisputedFrontierColor = value;
                    isDirty = true;
                    if (_territoriesDisputedMat != null &&
                        territoryDisputedFrontierColor != _territoriesDisputedMat.color)
                    {
                        _territoriesDisputedMat.color = territoryDisputedFrontierColor;
                    }
                }
            }
        }


        [SerializeField] bool showTerritoriesOuterBorder = true;

        /// <summary>
        /// Shows perimetral/outer border of territories?
        /// </summary>
        /// <value><c>true</c> if show territories outer borders; otherwise, <c>false</c>.</value>
        public bool ShowTerritoriesOuterBorders
        {
            get => showTerritoriesOuterBorder;
            set
            {
                if (showTerritoriesOuterBorder != value)
                {
                    showTerritoriesOuterBorder = value;
                    isDirty = true;
                    Redraw();
                }
            }
        }


        [FormerlySerializedAs("_allowTerritoriesInsideTerritories")] [SerializeField]
        bool allowTerritoriesInsideTerritories = false;

        /// <summary>
        /// Set this property to true to allow territories to be surrounded by other territories.
        /// </summary>
        public bool AllowTerritoriesInsideTerritories
        {
            get { return allowTerritoriesInsideTerritories; }
            set
            {
                if (allowTerritoriesInsideTerritories != value)
                {
                    allowTerritoriesInsideTerritories = value;
                    isDirty = true;
                }
            }
        }

        /// <summary>
        /// Returns Territory under mouse position or null if none.
        /// </summary>
        public Territory TerritoryHighlighted => _territoryHighlighted;

        /// <summary>
        /// Returns currently highlighted territory index in the countries list.
        /// </summary>
        public int TerritoryHighlightedIndex => _territoryHighlightedIndex;

        /// <summary>
        /// Returns Territory index which has been clicked
        /// </summary>
        public int TerritoryLastClickedIndex => _territoryLastClickedIndex;


        #region Public Territories Functions

        /// <summary>
        /// Uncolorize/hide all territories.
        /// </summary>
        public void TerritoryHideRegionSurfaces()
        {
            if (Territories == null)
                return;
            int terrCount = Territories.Count;
            for (int k = 0; k < terrCount; k++)
            {
                TerritoryHideRegionSurface(k);
            }
        }


        /// <summary>
        /// Uncolorize/hide specified territory by index in the territories collection.
        /// </summary>
        public void TerritoryHideRegionSurface(int territoryIndex)
        {
            if (_territoryHighlightedIndex != territoryIndex)
            {
                int cacheIndex = GetCacheIndexForTerritoryRegion(territoryIndex);
                GameObject surf;
                if (_surfaces.TryGetValue(cacheIndex, out surf))
                {
                    if (surf == null)
                    {
                        _surfaces.Remove(cacheIndex);
                    }
                    else
                    {
                        surf.SetActive(false);
                    }
                }
            }

            Territories[territoryIndex].region.customMaterial = null;
        }

        /// <summary>
        /// Colorize specified territory by index.
        /// </summary>
        /// <param name="territoryIndex">Territory index.</param>
        /// <param name="visible">If the colored surface will be visible or not.</param>
        /// <param name="color">Color.</param>
        public GameObject TerritoryToggleRegionSurface(int territoryIndex, bool visible, Color color)
        {
            return TerritoryToggleRegionSurface(territoryIndex, visible, color, null, Misc.Vector2one, Misc.Vector2zero,
                0, false);
        }

        /// <summary>
        /// Colorize specified territory by index.
        /// </summary>
        /// <param name="territoryIndex">Territory index.</param>
        /// <param name="visible">If the colored surface will be visible or not.</param>
        /// <param name="color">Color.</param>
        /// <param name="texture">Texture, which will be tinted according to the color. Use Color.white to preserve original texture colors.</param>
        public GameObject TerritoryToggleRegionSurface(int territoryIndex, bool visible, Color color, Texture2D texture)
        {
            return TerritoryToggleRegionSurface(territoryIndex, visible, color, texture, Misc.Vector2one,
                Misc.Vector2zero, 0, false);
        }

        /// <summary>
        /// Colorize specified territory by index.
        /// </summary>
        /// <param name="territoryIndex">Territory index.</param>
        /// <param name="visible">If the colored surface will be visible or not.</param>
        /// <param name="color">Color.</param>
        /// <param name="texture">Texture, which will be tinted according to the color. Use Color.white to preserve original texture colors.</param>
        /// <param name="textureScale">Texture scale.</param>
        /// <param name="textureOffset">Texture offset.</param>
        /// <param name="textureRotation">Texture rotation.</param>
        /// <param name="rotateInLocalSpace"></param>
        public GameObject TerritoryToggleRegionSurface(int territoryIndex, bool visible, Color color, Texture2D texture,
            Vector2 textureScale, Vector2 textureOffset, float textureRotation, bool rotateInLocalSpace)
        {
            return TerritoryToggleRegionSurface(territoryIndex, visible, color, texture, textureScale, textureOffset,
                textureRotation, false, rotateInLocalSpace);
        }


        /// <summary>
        /// Colorize specified territory by index.
        /// </summary>
        /// <param name="territoryIndex">Territory index.</param>
        /// <param name="visible">If the colored surface will be visible or not.</param>
        /// <param name="color">Color.</param>
        /// <param name="texture">Texture, which will be tinted according to the color. Use Color.white to preserve original texture colors.</param>
        /// <param name="textureScale">Texture scale.</param>
        /// <param name="textureOffset">Texture offset.</param>
        /// <param name="textureRotation">Texture rotation.</param>
        /// <param name="overlay">If set to <c>true</c> the colored surface will be shown over any object.</param>
        /// <param name="rotateInLocalSpace"></param>
        public GameObject TerritoryToggleRegionSurface(int territoryIndex, bool visible, Color color, Texture2D texture,
            Vector2 textureScale, Vector2 textureOffset, float textureRotation, bool overlay, bool rotateInLocalSpace)
        {
            if (!visible)
            {
                TerritoryHideRegionSurface(territoryIndex);
                return null;
            }

            Region region = Territories[territoryIndex].region;
            int cacheIndex = GetCacheIndexForTerritoryRegion(territoryIndex);
            // Checks if current cached surface contains a material with a texture, if it exists but it has not texture, destroy it to recreate with uv mappings
            _surfaces.TryGetValue(cacheIndex, out GameObject surf);

            Material coloredMat = overlay ? _coloredMatOverlay : _coloredMatGround;
            Material texturizedMat = overlay ? _texturizedMatOverlay : _texturizedMatGround;

            // Should the surface be recreated?
            Material surfMaterial;
            if (surf != null)
            {
                if (texture != null && (region.customMaterial == null || textureScale != region.customTextureScale ||
                                        textureOffset != region.customTextureOffset ||
                                        textureRotation != region.customTextureRotation ||
                                        !region.customMaterial.name.Equals(texturizedMat.name)))
                {
                    _surfaces.Remove(cacheIndex);
                    DestroyImmediate(surf);
                    surf = null;
                }
            }

            // If it exists, activate and check proper material, if not create surface
            bool isHighlighted = TerritoryHighlightedIndex == territoryIndex;
            if (surf != null)
            {
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
                surf = GenerateTerritoryRegionSurface(territoryIndex, surfMaterial, textureScale, textureOffset,
                    textureRotation, rotateInLocalSpace);
                region.customMaterial = surfMaterial;
                region.customTextureOffset = textureOffset;
                region.customTextureRotation = textureRotation;
                region.customTextureScale = textureScale;
                region.customRotateInLocalSpace = rotateInLocalSpace;
            }

            // If it was highlighted, highlight it again
            if (region.customMaterial != null && isHighlighted)
            {
                HUDMatTerritory.mainTexture = region.customMaterial != null ? region.customMaterial.mainTexture : null;

                surf.GetComponent<Renderer>().sharedMaterial = HUDMatTerritory;
                _highlightedObj = surf;
            }

            return surf;
        }

        /// <summary>
        /// Returns a list of neighbour cells for specificed cell index.
        /// </summary>
        public List<Territory> TerritoryGetNeighbours(int territoryIndex)
        {
            List<Territory> neighbours = new List<Territory>();
            Region region = Territories[territoryIndex].region;
            int nCount = region.neighbours.Count;
            for (int k = 0; k < nCount; k++)
            {
                neighbours.Add((Territory)region.neighbours[k].entity);
            }

            return neighbours;
        }

        /// <summary>
        /// Colors a territory and fades it out during "duration" in seconds.
        /// </summary>
        public void TerritoryFadeOut(int territoryIndex, Color color, float duration)
        {
            TerritoryAnimate(FADER_STYLE.FadeOut, territoryIndex, color, duration);
        }

        /// <summary>
        /// Flashes a territory with "color" and "duration" in seconds.
        /// </summary>
        public void TerritoryFlash(int territoryIndex, Color color, float duration)
        {
            TerritoryAnimate(FADER_STYLE.Flash, territoryIndex, color, duration);
        }

        /// <summary>
        /// Blinks a territory with "color" and "duration" in seconds.
        /// </summary>
        public void TerritoryBlink(int territoryIndex, Color color, float duration)
        {
            TerritoryAnimate(FADER_STYLE.Blink, territoryIndex, color, duration);
        }

        /// <summary>
        /// Temporarily colors a territory for "duration" in seconds.
        /// </summary>
        public void TerritoryColorTemp(int territoryIndex, Color color, float duration)
        {
            TerritoryAnimate(FADER_STYLE.ColorTemp, territoryIndex, color, duration);
        }

        /// <summary>
        /// Specifies if a given territory is visible.
        /// </summary>
        public void TerritorySetVisible(int territoryIndex, bool visible)
        {
            if (territoryIndex < 0 || territoryIndex >= Territories.Count)
                return;
            Territories[territoryIndex].visible = visible;
            if (territoryIndex == _territoryLastOverIndex)
            {
                ClearLastOver();
            }
        }

        /// <summary>
        /// Returns true if territory is visible
        /// </summary>
        public bool TerritoryIsVisible(int territoryIndex)
        {
            if (territoryIndex < 0 || territoryIndex >= Territories.Count)
                return false;
            return Territories[territoryIndex].visible;
        }

        /// <summary>
        /// Specifies if a given territory is neutral.
        /// </summary>
        public void TerritorySetNeutral(int territoryIndex, bool neutral)
        {
            if (territoryIndex < 0 || territoryIndex >= Territories.Count)
                return;
            Territories[territoryIndex].neutral = neutral;
            _needUpdateTerritories = true;
            _shouldRedraw = true;
        }

        /// <summary>
        /// Returns true if territory is neutral
        /// </summary>
        public bool TerritoryIsNeutral(int territoryIndex)
        {
            if (territoryIndex < 0 || territoryIndex >= Territories.Count)
                return false;
            return Territories[territoryIndex].neutral;
        }


        /// <summary>
        /// Specifies the color of the territory borders.
        /// </summary>
        public void TerritorySetFrontierColor(int territoryIndex, Color color)
        {
            if (territoryIndex < 0 || territoryIndex >= Territories.Count)
                return;
            Territory terr = Territories[territoryIndex];
            if (terr.frontierColor != color)
            {
                terr.frontierColor = color;
                DrawTerritoryBorders();
            }
        }


        /// <summary>
        /// Returns the territory object under position in local coordinates
        /// </summary>
        public Territory TerritoryGetAtPosition(Vector2 localPosition)
        {
            return GetTerritoryAtPoint(localPosition, false);
        }

        /// <summary>
        /// Returns the territory object under position in local or worldSpace coordinates
        /// </summary>
        public Territory TerritoryGetAtPosition(Vector3 position, bool worldSpace)
        {
            return GetTerritoryAtPoint(position, worldSpace);
        }

        /// <summary>
        /// Gets the territory's center position in world space.
        /// </summary>
        public Vector3 TerritoryGetPosition(int territoryIndex)
        {
            if (Territories == null || territoryIndex < 0 || territoryIndex >= Territories.Count)
                return Misc.Vector3zero;
            Vector2 territoryGridCenter = Territories[territoryIndex].scaledCenter;
            return GetWorldSpacePosition(territoryGridCenter);
        }


        /// <summary>
        /// Returns the rect enclosing the territory in world space
        /// </summary>
        public Bounds TerritoryGetRectWorldSpace(int territoryIndex)
        {
            if (Territories == null || territoryIndex < 0 || territoryIndex >= Territories.Count)
                return new Bounds(Misc.Vector3zero, Misc.Vector3zero);
            Rect rect = Territories[territoryIndex].region.rect2D;
            Vector3 min = GetWorldSpacePosition(rect.min);
            Vector3 max = GetWorldSpacePosition(rect.max);
            Bounds bounds = new Bounds((min + max) * 0.5f, max - min);
            return bounds;
        }


        /// <summary>
        /// Returns the number of vertices of the territory
        /// </summary>
        public int TerritoryGetVertexCount(int territoryIndex)
        {
            if (Territories == null || territoryIndex < 0 || territoryIndex >= Territories.Count) return 0;
            return Territories[territoryIndex].region.points.Count;
        }


        /// <summary>
        /// Returns the world space position of the vertex of a territory
        /// </summary>
        public Vector3 TerritoryGetVertexPosition(int territoryIndex, int vertexIndex)
        {
            if (Territories == null || territoryIndex < 0 || territoryIndex >= Territories.Count)
                return Misc.Vector3zero;
            Vector2 localPosition = Territories[territoryIndex].region.points[vertexIndex];
            return GetWorldSpacePosition(localPosition);
        }


        /// <summary>
        /// Automatically generates territories based on the different colors included in the texture.
        /// </summary>
        /// <param name="neutral">This color won't generate any texture.</param>
        public void CreateTerritories(Texture2D texture, Color neutral)
        {
            if (texture == null || Cells == null)
                return;

            List<Color> dsColors = new List<Color>();
            int cellCount = Cells.Count;
            Color[] colors = texture.GetPixels();
            for (int k = 0; k < cellCount; k++)
            {
                if (!Cells[k].visible)
                    continue;
                Vector2 uv = Cells[k].center;
                uv.x += 0.5f;
                uv.y += 0.5f;

                int x = (int)(uv.x * texture.width);
                int y = (int)(uv.y * texture.height);
                int pos = y * texture.width + x;
                if (pos < 0 || pos > colors.Length)
                    continue;
                Color pixelColor = colors[pos];

                int territoryIndex = dsColors.IndexOf(pixelColor);
                if (territoryIndex < 0)
                {
                    dsColors.Add(pixelColor);
                    territoryIndex = dsColors.Count - 1;
                }

                CellSetTerritory(k, territoryIndex);
                if (territoryIndex >= MAX_TERRITORIES - 1)
                    break;
            }

            if (dsColors.Count > 0)
            {
                numTerritories = dsColors.Count;
                showTerritories = true;

                if (Territories == null)
                {
                    Territories = new List<Territory>(numTerritories);
                }
                else
                {
                    Territories.Clear();
                }

                for (int c = 0; c < numTerritories; c++)
                {
                    Territory territory = new Territory(c.ToString());
                    Color territoryColor = dsColors[c];
                    if (territoryColor.r != neutral.r || territoryColor.g != neutral.g || territoryColor.b != neutral.b)
                    {
                        territory.fillColor = territoryColor;
                    }
                    else
                    {
                        territory.fillColor = new Color(0, 0, 0, 0);
                        territory.visible = false;
                    }

                    Territories.Add(territory);
                }

                isDirty = true;
                Redraw();
            }
        }

        #endregion
    }
}
using UnityEngine;
using UnityEditor;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using TGS;
using TGS.PathFinding;

namespace TGS_Editor
{
    [CustomEditor(typeof(TerrainGridSystem))]
    public class TGSInspector : Editor
    {
        TerrainGridSystem tgs;
        Texture2D _headerTexture, _blackTexture;
        string[] selectionModeOptions, topologyOptions, overlayModeOptions;
        int[] topologyOptionsValues;
        GUIStyle titleLabelStyle, infoLabelStyle;
        int cellHighlightedIndex = -1, cellTerritoryIndex, cellTextureIndex;
        List<int> cellSelectedIndices;

        Color colorSelection, cellColor;
        int textureMode, cellTag;
        static GUIStyle toggleButtonStyleNormal = null;
        static GUIStyle toggleButtonStyleToggled = null;
        SerializedProperty isDirty;
        StringBuilder sb;

        void OnEnable()
        {
            _headerTexture = Resources.Load<Texture2D>("EditorHeader");

            selectionModeOptions = new string[]
            {
                "None",
                "Territories",
                "Cells"
            };
            overlayModeOptions = new string[] { "Overlay", "Ground" };
            topologyOptions = new string[] { "Irregular", "Box", "Hexagonal" };
            topologyOptionsValues = new int[]
            {
                (int)GRID_TOPOLOGY.Irregular,
                (int)GRID_TOPOLOGY.Box,
                (int)GRID_TOPOLOGY.Hexagonal
            };

            tgs = (TerrainGridSystem)target;
            if (tgs.territories == null)
            {
                tgs.Init();
            }

            sb = new StringBuilder();
            cellSelectedIndices = new List<int>();
            colorSelection = new Color(1, 1, 0.5f, 0.85f);
            cellColor = Color.white;
            isDirty = serializedObject.FindProperty("isDirty");

            HideEditorMesh();
        }

        public override void OnInspectorGUI()
        {
            EditorGUILayout.Separator();
            GUI.skin.label.alignment = TextAnchor.MiddleCenter;
            GUILayout.Label(_headerTexture, GUILayout.ExpandWidth(true));
            GUI.skin.label.alignment = TextAnchor.MiddleLeft;


            EditorGUILayout.BeginVertical();

            EditorGUILayout.BeginHorizontal();
            DrawTitleLabel("Grid Configuration");
            GUILayout.FlexibleSpace();
            if (GUILayout.Button("Help"))
            {
                EditorUtility.DisplayDialog("Terrain Grid System",
                    "TGS is an advanced grid generator for Unity terrain. It can also work as a standalone 2D grid.\n\nFor a complete description of the options, please refer to the documentation guide (PDF) included in the asset.\nWe also invite you to visit and sign up on our support forum on kronnect.com where you can post your questions/requests.\n\nThanks for purchasing! Please rate Terrain Grid System on the Asset Store! Thanks.",
                    "Close");
            }

            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Topology", GUILayout.Width(120));
            tgs.GridTopology =
                (GRID_TOPOLOGY)EditorGUILayout.IntPopup((int)tgs.GridTopology, topologyOptions, topologyOptionsValues);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Territories", GUILayout.Width(120));
            tgs.numTerritories = EditorGUILayout.IntSlider(tgs.numTerritories, 1,
                Mathf.Min(tgs.NumCells, TerrainGridSystem.MAX_TERRITORIES));
            EditorGUILayout.EndHorizontal();

            if (tgs.GridTopology == GRID_TOPOLOGY.Irregular)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Cells (aprox.)", GUILayout.Width(120));
                tgs.NumCells = EditorGUILayout.IntField(tgs.NumCells, GUILayout.Width(60));
                EditorGUILayout.EndHorizontal();
            }
            else
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Columns", GUILayout.Width(120));
                tgs.ColumnCount = EditorGUILayout.IntField(tgs.ColumnCount, GUILayout.Width(60));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Rows", GUILayout.Width(120));
                tgs.RowCount = EditorGUILayout.IntField(tgs.RowCount, GUILayout.Width(60));
                EditorGUILayout.EndHorizontal();
            }

            if (tgs.GridTopology == GRID_TOPOLOGY.Hexagonal)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Regular Hexes", GUILayout.Width(120));
                tgs.RegularHexagons = EditorGUILayout.Toggle(tgs.RegularHexagons);
                EditorGUILayout.EndHorizontal();
                if (tgs.RegularHexagons)
                {
                    EditorGUILayout.BeginHorizontal();
                    GUILayout.Label("   Hex Scale", GUILayout.Width(120));
                    tgs.HexSize = EditorGUILayout.Slider(tgs.HexSize, 0.0001f, 0.6f);
                    EditorGUILayout.EndHorizontal();
                }

                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Even Layout", GUILayout.Width(120));
                tgs.EvenLayout = EditorGUILayout.Toggle(tgs.EvenLayout);
                EditorGUILayout.EndHorizontal();
            }

            if (tgs.GridTopology == GRID_TOPOLOGY.Irregular)
            {
                if (tgs.NumCells > 10000)
                {
                    EditorGUILayout.HelpBox("Total cell count exceeds recommended maximum of 10.000!",
                        MessageType.Warning);
                }
            }
            else if (tgs.NumCells > 50000)
            {
                EditorGUILayout.HelpBox("Total cell count exceeds recommended maximum of 50.000!", MessageType.Warning);
            }

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Curvature", GUILayout.Width(120));
            if (tgs.NumCells > TerrainGridSystem.MAX_CELLS_FOR_CURVATURE)
            {
                DrawInfoLabel("not available with >" + TerrainGridSystem.MAX_CELLS_FOR_CURVATURE + " cells");
            }
            else
            {
                tgs.GridCurvature = EditorGUILayout.Slider(tgs.GridCurvature, 0, 0.1f);
            }

            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Relaxation", GUILayout.Width(120));
            if (tgs.GridTopology != GRID_TOPOLOGY.Irregular)
            {
                DrawInfoLabel("only available with irregular topology");
            }
            else if (tgs.NumCells > TerrainGridSystem.MAX_CELLS_FOR_RELAXATION)
            {
                DrawInfoLabel("not available with >" + TerrainGridSystem.MAX_CELLS_FOR_RELAXATION + " cells");
            }
            else
            {
                tgs.GridRelaxation = EditorGUILayout.IntSlider(tgs.GridRelaxation, 1, 32);
            }

            EditorGUILayout.EndHorizontal();

            if (tgs.Terrain != null)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Roughness", GUILayout.Width(120));
                tgs.GridRoughness = EditorGUILayout.Slider(tgs.GridRoughness, 0.001f, 0.2f);
                EditorGUILayout.EndHorizontal();
            }

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Seed", GUILayout.Width(120));
            tgs.Seed = EditorGUILayout.IntSlider(tgs.Seed, 1, 10000);
            if (GUILayout.Button("Redraw"))
            {
                tgs.Redraw();
            }

            EditorGUILayout.EndHorizontal();

            if (tgs.Terrain != null)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Max Slope", GUILayout.Width(120));
                tgs.CellsMaxSlope = EditorGUILayout.Slider(tgs.CellsMaxSlope, 0, 1f);
                EditorGUILayout.EndHorizontal();

                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Minimum Altitude", GUILayout.Width(120));
                tgs.CellsMinimumAltitude = EditorGUILayout.FloatField(tgs.CellsMinimumAltitude, GUILayout.Width(120));
                if (tgs.CellsMinimumAltitude == 0)
                    DrawInfoLabel("(0 = not used)");
                EditorGUILayout.EndHorizontal();
            }

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label(
                new GUIContent("Mask", "Alpha channel is used to determine cell visibility (0 = cell is not visible)"),
                GUILayout.Width(120));
            tgs.GridMask = (Texture2D)EditorGUILayout.ObjectField(tgs.GridMask, typeof(Texture2D), true);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label(
                new GUIContent("Territories Texture",
                    "Quickly create territories assigning a color texture in which each territory corresponds to a color."),
                GUILayout.Width(120));
            tgs.territoriesTexture =
                (Texture2D)EditorGUILayout.ObjectField(tgs.territoriesTexture, typeof(Texture2D), true);
            if (tgs.territoriesTexture != null)
            {
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label(new GUIContent("  Neutral Color", "Color to be ignored."), GUILayout.Width(120));
#if UNITY_2018_1_OR_NEWER
                tgs.territoriesTextureNeutralColor = EditorGUILayout.ColorField(new GUIContent(""),
                    tgs.territoriesTextureNeutralColor, false, false, false, GUILayout.Width(50));
#else
				tgs.territoriesTextureNeutralColor =
 EditorGUILayout.ColorField (new GUIContent (""), tgs.territoriesTextureNeutralColor, false, false, false, null, GUILayout.Width (50));
#endif
                EditorGUILayout.Space();
                if (GUILayout.Button("Generate Territories", GUILayout.Width(120)))
                {
                    tgs.CreateTerritories(tgs.territoriesTexture, tgs.territoriesTextureNeutralColor);
                }
            }

            EditorGUILayout.EndHorizontal();

            int cellsCreated = tgs.Cells == null ? 0 : tgs.Cells.Count;
            int territoriesCreated = tgs.territories == null ? 0 : tgs.territories.Count;

            EditorGUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            DrawInfoLabel("Cells Created: " + cellsCreated + " / Territories Created: " + territoriesCreated +
                          " / Vertex Count: " + tgs.lastVertexCount);
            GUILayout.FlexibleSpace();
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.EndVertical();
            EditorGUILayout.Separator();
            EditorGUILayout.BeginVertical();

            DrawTitleLabel("Grid Positioning");

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Hide Objects", GUILayout.Width(120));
            if (tgs.Terrain != null && GUILayout.Button("Toggle Terrain"))
            {
                tgs.Terrain.enabled = !tgs.Terrain.enabled;
            }

            if (GUILayout.Button("Toggle Grid"))
            {
                tgs.gameObject.SetActive(!tgs.gameObject.activeSelf);
            }

            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Center", GUILayout.Width(120));
            tgs.GridCenter = EditorGUILayout.Vector2Field("", tgs.GridCenter);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Scale", GUILayout.Width(120));
            if (tgs.RegularHexagons)
            {
                GUI.enabled = false;
            }

            tgs.GridScale = EditorGUILayout.Vector2Field("", tgs.GridScale);
            EditorGUILayout.EndHorizontal();
            GUI.enabled = true;

            if (tgs.RegularHexagons)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("", GUILayout.Width(120));
                EditorGUILayout.HelpBox("Scale is driven by regular hexagons option.", MessageType.Info);
                EditorGUILayout.EndHorizontal();
            }

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Mesh Depth Offset", GUILayout.Width(120));
            tgs.GridMeshDepthOffset = EditorGUILayout.IntSlider(tgs.GridMeshDepthOffset, -100, 0);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Colored Depth Offset", GUILayout.Width(120));
            tgs.GridSurfaceDepthOffset = EditorGUILayout.IntSlider(tgs.GridSurfaceDepthOffset, -100, 0);
            EditorGUILayout.EndHorizontal();

            if (tgs.Terrain != null)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Elevation", GUILayout.Width(120));
                tgs.GridElevation = EditorGUILayout.Slider(tgs.GridElevation, 0f, 5f);
                EditorGUILayout.EndHorizontal();

                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Elevation Base", GUILayout.Width(120));
                tgs.GridElevationBase = EditorGUILayout.FloatField(tgs.GridElevationBase, GUILayout.Width(60));
                EditorGUILayout.EndHorizontal();

                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Camera Offset", GUILayout.Width(120));
                tgs.GridCameraOffset = EditorGUILayout.Slider(tgs.GridCameraOffset, 0, 0.1f);
                EditorGUILayout.EndHorizontal();

                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Normal Offset", GUILayout.Width(120));
                tgs.GridNormalOffset = EditorGUILayout.Slider(tgs.GridNormalOffset, 0.00f, 5f);
                EditorGUILayout.EndHorizontal();
            }

            EditorGUILayout.EndVertical();
            EditorGUILayout.Separator();
            EditorGUILayout.BeginVertical();

            DrawTitleLabel("Grid Appearance");

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Show Territories", GUILayout.Width(120));
            tgs.showTerritories = EditorGUILayout.Toggle(tgs.showTerritories);
            GUILayout.Label("Frontier Color");
            tgs.territoryFrontiersColor = EditorGUILayout.ColorField(tgs.territoryFrontiersColor, GUILayout.Width(50));
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("  Highlight Color", GUILayout.Width(120));
            tgs.territoryHighlightColor = EditorGUILayout.ColorField(tgs.territoryHighlightColor, GUILayout.Width(50));
            GUILayout.FlexibleSpace();
            GUILayout.Label(new GUIContent("Disputed Frontier", "Color for common frontiers between two territories."));
            tgs.territoryDisputedFrontierColor =
                EditorGUILayout.ColorField(tgs.territoryDisputedFrontierColor, GUILayout.Width(50));
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("  Colorize Territories", GUILayout.Width(120));
            tgs.colorizeTerritories = EditorGUILayout.Toggle(tgs.colorizeTerritories);
            GUILayout.Label("Alpha");
            tgs.colorizedTerritoriesAlpha = EditorGUILayout.Slider(tgs.colorizedTerritoriesAlpha, 0.0f, 1.0f);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("  Outer Borders", GUILayout.Width(120));
            tgs.showTerritoriesOuterBorders = EditorGUILayout.Toggle(tgs.showTerritoriesOuterBorders);
            GUILayout.Label(new GUIContent("Internal Territories",
                "Allows territories to be contained by other territories."));
            tgs.allowTerritoriesInsideTerritories = EditorGUILayout.Toggle(tgs.allowTerritoriesInsideTerritories);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Show Cells", GUILayout.Width(120));
            tgs.ShowCells = EditorGUILayout.Toggle(tgs.ShowCells);
            if (tgs.ShowCells)
            {
                GUILayout.Label("Border Color", GUILayout.Width(120));
                tgs.CellBorderColor = EditorGUILayout.ColorField(tgs.CellBorderColor, GUILayout.Width(50));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("  Thickness", GUILayout.Width(120));
                tgs.CellBorderThickness = EditorGUILayout.Slider(tgs.CellBorderThickness, 1f, 5f);
                if (tgs.CellBorderThickness > 1f)
                {
                    EditorGUILayout.EndHorizontal();
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.HelpBox(
                        "Setting thickness value greater than 1 uses geometry shader (shader model 4.0 required, might not work on some mobile devices)",
                        MessageType.Info);
                }
            }

            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("  Highlight Color", GUILayout.Width(120));
            tgs.CellHighlightColor = EditorGUILayout.ColorField(tgs.CellHighlightColor, GUILayout.Width(50));
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Highlight Fade", GUILayout.Width(120));
            float highlightFadeMin = tgs.HighlightFadeMin;
            float highlightFadeAmount = tgs.HighlightFadeAmount;
            EditorGUILayout.MinMaxSlider(ref highlightFadeMin, ref highlightFadeAmount, 0.0f, 1.0f);
            tgs.HighlightFadeMin = highlightFadeMin;
            tgs.HighlightFadeAmount = highlightFadeAmount;
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Highlight Speed", GUILayout.Width(120));
            tgs.HighlightFadeSpeed = EditorGUILayout.Slider(tgs.HighlightFadeSpeed, 0.1f, 5.0f);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Highlight Effect", GUILayout.Width(120));
            tgs.HighlightEffect = (HIGHLIGHT_EFFECT)EditorGUILayout.EnumPopup(tgs.HighlightEffect);
            EditorGUILayout.EndHorizontal();

            if (tgs.HighlightEffect == HIGHLIGHT_EFFECT.TextureScale)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("   Scale Range", GUILayout.Width(120));
                float highlightScaleMin = tgs.HighlightScaleMin;
                float highlightScaleMax = tgs.HighlightScaleMax;
                EditorGUILayout.MinMaxSlider(ref highlightScaleMin, ref highlightScaleMax, 0.0f, 2.0f);
                if (GUILayout.Button("Default", GUILayout.Width(60)))
                {
                    highlightScaleMin = 0.75f;
                    highlightScaleMax = 1.1f;
                }

                tgs.HighlightScaleMin = highlightScaleMin;
                tgs.HighlightScaleMax = highlightScaleMax;
                EditorGUILayout.EndHorizontal();
            }

            if (tgs.Terrain != null)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label(
                    new GUIContent("Near Clip Fade", "Fades out the cell and territories lines near to the camera."),
                    GUILayout.Width(120));
                tgs.NearClipFadeEnabled = EditorGUILayout.Toggle(tgs.NearClipFadeEnabled);
                EditorGUILayout.EndHorizontal();

                if (tgs.NearClipFadeEnabled)
                {
                    EditorGUILayout.BeginHorizontal();
                    GUILayout.Label("  Distance", GUILayout.Width(120));
                    tgs.NearClipFade = EditorGUILayout.Slider(tgs.NearClipFade, 0.0f, 100.0f);
                    EditorGUILayout.EndHorizontal();

                    EditorGUILayout.BeginHorizontal();
                    GUILayout.Label("  FallOff", GUILayout.Width(120));
                    tgs.NearClipFadeFallOff = EditorGUILayout.Slider(tgs.NearClipFadeFallOff, 0.001f, 100.0f);
                    EditorGUILayout.EndHorizontal();
                }
            }

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Canvas Texture", GUILayout.Width(120));
            tgs.canvasTexture = (Texture2D)EditorGUILayout.ObjectField(tgs.canvasTexture, typeof(Texture2D), true);
            EditorGUILayout.EndHorizontal();

            if (tgs.Terrain == null)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Transparent Background", GUILayout.Width(120));
                tgs.TransparentBackground = EditorGUILayout.Toggle(tgs.TransparentBackground);
                EditorGUILayout.EndHorizontal();
            }

            EditorGUILayout.EndVertical();
            EditorGUILayout.Separator();
            EditorGUILayout.BeginVertical();

            DrawTitleLabel("Grid Behaviour");

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Terrain", GUILayout.Width(120));
            Terrain prevTerrain = tgs.Terrain;
            tgs.Terrain = (Terrain)EditorGUILayout.ObjectField(tgs.Terrain, typeof(Terrain), true);
            if (tgs.Terrain != prevTerrain)
            {
                GUIUtility.ExitGUI();
                return;
            }

            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Selection Mode", GUILayout.Width(120));
            tgs.HighlightMode = (HIGHLIGHT_MODE)EditorGUILayout.Popup((int)tgs.HighlightMode, selectionModeOptions);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("  Include Invisible Cells", GUILayout.Width(120));
            tgs.CellHighlightNonVisible = EditorGUILayout.Toggle(tgs.CellHighlightNonVisible, GUILayout.Width(40));
            GUILayout.Label(
                new GUIContent("Minimum Distance",
                    "Minimum distance of cell/territory to camera to be selectable. Useful in first person view to prevent selecting cells already under character."),
                GUILayout.Width(120));
            tgs.HighlightMinimumTerrainDistance =
                EditorGUILayout.FloatField(tgs.HighlightMinimumTerrainDistance, GUILayout.Width(60));
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Overlay Mode", GUILayout.Width(120));
            tgs.OverlayMode = (OVERLAY_MODE)EditorGUILayout.Popup((int)tgs.OverlayMode, overlayModeOptions);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Respect Other UI", GUILayout.Width(120));
            tgs.RespectOtherUI = EditorGUILayout.Toggle(tgs.RespectOtherUI);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.EndVertical();
            EditorGUILayout.Separator();
            EditorGUILayout.BeginVertical();

            DrawTitleLabel("Path Finding");

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Algorithm", GUILayout.Width(120));
            tgs.PathFindingHeuristicFormula =
                (TGS.PathFinding.HeuristicFormula)EditorGUILayout.EnumPopup(tgs.PathFindingHeuristicFormula);
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Max Search Cost", GUILayout.Width(120));
            tgs.PathFindingMaxCost = EditorGUILayout.IntField(tgs.PathFindingMaxCost, GUILayout.Width(100));
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("Max Steps", GUILayout.Width(120));
            tgs.PathFindingMaxSteps = EditorGUILayout.IntField(tgs.PathFindingMaxSteps, GUILayout.Width(100));
            EditorGUILayout.EndHorizontal();

            if (tgs.GridTopology == GRID_TOPOLOGY.Box)
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Use Diagonals", GUILayout.Width(120));
                tgs.PathFindingUseDiagonals = EditorGUILayout.Toggle(tgs.PathFindingUseDiagonals, GUILayout.Width(40));
                GUILayout.Label("Heavy Diagonals", GUILayout.Width(120));
                tgs.PathFindingHeavyDiagonals =
                    EditorGUILayout.Toggle(tgs.PathFindingHeavyDiagonals, GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
            }

            EditorGUILayout.EndVertical();
            EditorGUILayout.Separator();

            if (!Application.isPlaying)
            {
                EditorGUILayout.BeginVertical();
                EditorGUILayout.BeginHorizontal();
                DrawTitleLabel("Grid Editor");
                GUILayout.FlexibleSpace();
                if (GUILayout.Button("Export Settings"))
                {
                    if (EditorUtility.DisplayDialog("Export Grid Settings",
                            "This option will add a TGS Config component to this game object with current cell settings. You can restore this configuration just enabling this new component.",
                            "Ok", "Cancel"))
                    {
                        CreatePlaceholder();
                    }
                }

                if (GUILayout.Button("Reset"))
                {
                    if (EditorUtility.DisplayDialog("Reset Grid", "Reset cells to their default values?", "Ok",
                            "Cancel"))
                    {
                        ResetCells();
                        GUIUtility.ExitGUI();
                        return;
                    }
                }

                EditorGUILayout.EndHorizontal();

                EditorGUILayout.BeginHorizontal();
                GUILayout.Label(new GUIContent("Enable Editor", "Enables grid editing options in Scene View"),
                    GUILayout.Width(120));
                tgs.EnableGridEditor = EditorGUILayout.Toggle(tgs.EnableGridEditor);
                EditorGUILayout.EndHorizontal();

                if (tgs.EnableGridEditor)
                {
                    int selectedCount = cellSelectedIndices.Count;
                    if (selectedCount == 0)
                    {
                        GUILayout.Label(
                            "Click on a cell in Scene View to edit its properties\n(use Control or Shift to select multiple cells)");
                    }
                    else
                    {
                        // Check that all selected cells are within range
                        for (int k = 0; k < selectedCount; k++)
                        {
                            if (cellSelectedIndices[k] < 0 || cellSelectedIndices[k] >= tgs.CellCount)
                            {
                                cellSelectedIndices.Clear();
                                EditorGUIUtility.ExitGUI();
                                return;
                            }
                        }

                        int cellSelectedIndex = cellSelectedIndices[0];
                        EditorGUILayout.BeginHorizontal();
                        if (selectedCount == 1)
                        {
                            GUILayout.Label("Selected Cell", GUILayout.Width(120));
                            GUILayout.Label(cellSelectedIndex.ToString(), GUILayout.Width(120));
                        }
                        else
                        {
                            GUILayout.Label("Selected Cells", GUILayout.Width(120));
                            sb.Length = 0;
                            for (int k = 0; k < selectedCount; k++)
                            {
                                if (k > 0)
                                {
                                    sb.Append(", ");
                                }

                                sb.Append(cellSelectedIndices[k].ToString());
                            }

                            if (selectedCount > 5)
                            {
                                GUILayout.TextArea(sb.ToString(), GUILayout.ExpandHeight(true));
                            }
                            else
                            {
                                GUILayout.Label(sb.ToString());
                            }
                        }

                        EditorGUILayout.EndHorizontal();

                        bool needsRedraw = false;

                        EditorGUILayout.BeginHorizontal();
                        GUILayout.Label("  Visible", GUILayout.Width(120));
                        Cell selectedCell = tgs.Cells[cellSelectedIndex];
                        bool cellVisible = selectedCell.visible;
                        selectedCell.visible = EditorGUILayout.Toggle(cellVisible);
                        if (selectedCell.visible != cellVisible)
                        {
                            for (int k = 0; k < selectedCount; k++)
                            {
                                tgs.Cells[cellSelectedIndices[k]].visible = selectedCell.visible;
                            }

                            needsRedraw = true;
                        }

                        EditorGUILayout.EndHorizontal();

                        if (selectedCount == 1)
                        {
                            EditorGUILayout.BeginHorizontal();
                            GUILayout.Label("  Tag", GUILayout.Width(120));
                            cellTag = EditorGUILayout.IntField(cellTag, GUILayout.Width(60));
                            if (cellTag == selectedCell.tag)
                                GUI.enabled = false;
                            if (GUILayout.Button("Set Tag", GUILayout.Width(60)))
                            {
                                tgs.CellSetTag(cellSelectedIndex, cellTag);
                            }

                            EditorGUILayout.EndHorizontal();
                        }

                        GUI.enabled = true;
                        EditorGUILayout.BeginHorizontal();
                        GUILayout.Label("  Territory Index", GUILayout.Width(120));
                        cellTerritoryIndex = EditorGUILayout.IntField(cellTerritoryIndex, GUILayout.Width(40));
                        if (cellTerritoryIndex == selectedCell.territoryIndex)
                            GUI.enabled = false;
                        if (GUILayout.Button("Set Territory", GUILayout.Width(100)))
                        {
                            for (int k = 0; k < selectedCount; k++)
                            {
                                tgs.CellSetTerritory(cellSelectedIndices[k], cellTerritoryIndex);
                            }

                            needsRedraw = true;
                        }

                        GUI.enabled = true;
                        EditorGUILayout.EndHorizontal();

                        EditorGUILayout.BeginHorizontal();
                        GUILayout.Label("  Color", GUILayout.Width(120));
                        cellColor = EditorGUILayout.ColorField(cellColor, GUILayout.Width(40));
                        GUILayout.Label("  Texture", GUILayout.Width(60));
                        cellTextureIndex = EditorGUILayout.IntField(cellTextureIndex, GUILayout.Width(40));
                        if (tgs.CellGetColor(cellSelectedIndex) == cellColor &&
                            tgs.CellGetTextureIndex(cellSelectedIndex) == cellTextureIndex)
                            GUI.enabled = false;
                        if (GUILayout.Button("Set", GUILayout.Width(40)))
                        {
                            for (int k = 0; k < selectedCount; k++)
                            {
                                tgs.CellToggleRegionSurface(cellSelectedIndices[k], true, cellColor, false,
                                    cellTextureIndex);
                            }

                            needsRedraw = true;
                        }

                        GUI.enabled = true;
                        if (GUILayout.Button("Clear", GUILayout.Width(40)))
                        {
                            for (int k = 0; k < selectedCount; k++)
                            {
                                tgs.CellHideRegionSurface(cellSelectedIndices[k]);
                            }

                            needsRedraw = true;
                        }

                        EditorGUILayout.EndHorizontal();

                        if (needsRedraw)
                        {
                            RefreshGrid();
                            GUIUtility.ExitGUI();
                            return;
                        }
                    }

                    EditorGUILayout.BeginHorizontal();
                    GUILayout.Label("Textures", GUILayout.Width(120));
                    EditorGUILayout.EndHorizontal();

                    if (toggleButtonStyleNormal == null)
                    {
                        toggleButtonStyleNormal = "Button";
                        toggleButtonStyleToggled = new GUIStyle(toggleButtonStyleNormal);
                        toggleButtonStyleToggled.normal.background = toggleButtonStyleToggled.active.background;
                    }

                    int textureMax = tgs.textures.Length - 1;
                    while (textureMax >= 1 && tgs.textures[textureMax] == null)
                    {
                        textureMax--;
                    }

                    textureMax++;
                    if (textureMax >= tgs.textures.Length)
                        textureMax = tgs.textures.Length - 1;

                    for (int k = 1; k <= textureMax; k++)
                    {
                        EditorGUILayout.BeginHorizontal();
                        GUILayout.Label("  " + k.ToString(), GUILayout.Width(40));
                        tgs.textures[k] =
                            (Texture2D)EditorGUILayout.ObjectField(tgs.textures[k], typeof(Texture2D), false);
                        if (tgs.textures[k] != null)
                        {
                            if (GUILayout.Button(
                                    new GUIContent("T",
                                        "Texture mode - if enabled, you can paint several cells just clicking over them."),
                                    textureMode == k ? toggleButtonStyleToggled : toggleButtonStyleNormal,
                                    GUILayout.Width(20)))
                            {
                                textureMode = textureMode == k ? 0 : k;
                            }

                            if (GUILayout.Button(new GUIContent("X", "Remove texture"), GUILayout.Width(20)))
                            {
                                if (EditorUtility.DisplayDialog("Remove texture",
                                        "Are you sure you want to remove this texture?", "Yes", "No"))
                                {
                                    tgs.textures[k] = null;
                                    GUIUtility.ExitGUI();
                                    return;
                                }
                            }
                        }

                        EditorGUILayout.EndHorizontal();
                    }
                }

                EditorGUILayout.EndVertical();
            }

            EditorGUILayout.Separator();

            if (tgs.isDirty)
            {
#if UNITY_5_6_OR_NEWER
                serializedObject.UpdateIfRequiredOrScript();
#else
				serializedObject.UpdateIfDirtyOrScript ();
#endif
                isDirty.boolValue = false;
                serializedObject.ApplyModifiedProperties();
                EditorUtility.SetDirty(target);

                // Hide mesh in Editor
                HideEditorMesh();

                SceneView.RepaintAll();
            }
        }

        void OnSceneGUI()
        {
            if (tgs == null || Application.isPlaying || !tgs.EnableGridEditor)
                return;
            if (tgs.Terrain != null)
            {
                // prevents terrain from being selected
                HandleUtility.AddDefaultControl(GUIUtility.GetControlID(FocusType.Passive));
            }

            Event e = Event.current;
            bool gridHit = tgs.CheckRay(HandleUtility.GUIPointToWorldRay(e.mousePosition));
            if (cellHighlightedIndex != tgs.CellHighlightedIndex)
            {
                cellHighlightedIndex = tgs.CellHighlightedIndex;
                SceneView.RepaintAll();
            }

            int controlID = GUIUtility.GetControlID(FocusType.Passive);
            EventType eventType = e.GetTypeForControl(controlID);
            if (eventType == EventType.MouseDown || (eventType == EventType.MouseMove && e.shift))
            {
                if (gridHit)
                {
                    e.Use();
                }

                if (cellHighlightedIndex < 0)
                {
                    return;
                }

                if (!e.shift && cellSelectedIndices.Contains(cellHighlightedIndex))
                {
                    cellSelectedIndices.Remove(cellHighlightedIndex);
                }
                else
                {
                    if (!e.shift || (e.shift && !cellSelectedIndices.Contains(cellHighlightedIndex)))
                    {
                        if (!e.shift && !e.control)
                        {
                            cellSelectedIndices.Clear();
                        }

                        cellSelectedIndices.Add(cellHighlightedIndex);
                        if (textureMode > 0)
                        {
                            tgs.CellToggleRegionSurface(cellHighlightedIndex, true, Color.white, false, textureMode);
                            SceneView.RepaintAll();
                        }

                        if (cellHighlightedIndex >= 0)
                        {
                            cellTerritoryIndex = tgs.CellGetTerritoryIndex(cellHighlightedIndex);
                            cellColor = tgs.CellGetColor(cellHighlightedIndex);
                            if (cellColor.a == 0)
                                cellColor = Color.white;
                            cellTextureIndex = tgs.CellGetTextureIndex(cellHighlightedIndex);
                            cellTag = tgs.CellGetTag(cellHighlightedIndex);
                        }
                    }
                }

                EditorUtility.SetDirty(target);
            }

            int count = cellSelectedIndices.Count;
            for (int k = 0; k < count; k++)
            {
                int index = cellSelectedIndices[k];
                Vector3 pos = tgs.CellGetPosition(index);
                Handles.color = colorSelection;
                // Handle size
                Rect rect = tgs.CellGetRect(index);
                Vector3 min = tgs.transform.TransformPoint(rect.min);
                Vector3 max = tgs.transform.TransformPoint(rect.max);
                float dia = Vector3.Distance(min, max);
                float handleSize = dia * 0.05f;
                Handles.DrawSolidDisc(pos, tgs.transform.forward, handleSize);
            }
        }

        #region Utility functions

        void HideEditorMesh()
        {
            Renderer[] rr = tgs.GetComponentsInChildren<Renderer>(true);
            for (int k = 0; k < rr.Length; k++)
            {
#if UNITY_5_5_OR_NEWER
                EditorUtility.SetSelectedRenderState(rr[k], EditorSelectedRenderState.Hidden);
#else
				EditorUtility.SetSelectedWireframeHidden (rr [k], true);
#endif
            }
        }


        void DrawTitleLabel(string s)
        {
            if (titleLabelStyle == null)
                titleLabelStyle = new GUIStyle(GUI.skin.label);
            titleLabelStyle.normal.textColor = EditorGUIUtility.isProSkin
                ? new Color(0.52f, 0.66f, 0.9f)
                : new Color(0.22f, 0.36f, 0.6f);
            titleLabelStyle.fontStyle = FontStyle.Bold;
            GUILayout.Label(s, titleLabelStyle);
        }

        void DrawInfoLabel(string s)
        {
            if (infoLabelStyle == null)
                infoLabelStyle = new GUIStyle(GUI.skin.label);
            infoLabelStyle.normal.textColor = new Color(0.76f, 0.52f, 0.52f);
            GUILayout.Label(s, infoLabelStyle);
        }

        void ResetCells()
        {
            cellSelectedIndices.Clear();
            cellColor = Color.white;
            tgs.GenerateMap();
            RefreshGrid();
        }

        void RefreshGrid()
        {
            tgs.Redraw();
            HideEditorMesh();
            EditorUtility.SetDirty(target);
            SceneView.RepaintAll();
        }

        void CreatePlaceholder()
        {
            TGSConfig configComponent = tgs.gameObject.AddComponent<TGSConfig>();
            configComponent.textures = tgs.textures;
            configComponent.config = tgs.CellGetConfigurationData();
            configComponent.enabled = false;
        }

        #endregion
    }
}
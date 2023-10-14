using UnityEditor;
using UnityEngine;
using UnityEngine.EventSystems;
using System.IO;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    /// <summary>
    /// Handles the editing of hex cells in the mp
    /// </summary>
    public class HexMapEditor : MonoBehaviour
    {
        public Color[] colors;
        public HexGrid hexGrid;
        public Material terrainMaterial;

        int _activeElevation;
        int _activeWaterLevel;
        bool _applyElevation = true;
        bool _applyWaterLevel = true;

        int _brushSize;

        int activeUrbanLevel, activeFarmLevel, activePlantLevel, activeSpecialIndex;
        bool applyUrbanLevel, applyFarmLevel, applyPlantLevel, applySpecialIndex;

        int activeTerrainTypeIndex;

        #region UI Variables

        [Header("UI")] [SerializeField] Slider elevationSlider;
        [SerializeField] Toggle elevationToggle;
        [Space] [SerializeField] Slider brushSizeSlider;
        [Space] [SerializeField] Slider waterLevelSlider;
        [SerializeField] Toggle waterToggle;
        [Space] [SerializeField] Slider urbanLevelSlider;
        [SerializeField] Toggle urbanToggle;
        [Space] [SerializeField] Toggle plantToggle;
        [SerializeField] Slider plantLevelSlider;
        [Space] [SerializeField] Toggle farmToggle;
        [SerializeField] Slider farmLevelSlider;
        [Space] [SerializeField] Toggle specialToggle;
        [SerializeField] Slider specialIndexSlider;
        [Space] [SerializeField] Toggle gridToggle;
        [Space] [SerializeField] Toggle editModeToggle;

        #endregion

        enum OptionalToggle
        {
            Ignore, Yes, No
        }

        OptionalToggle _riverMode, _roadMode, _walledMode;
        bool _isDrag;
        HexDirection _dragDirection;
        HexCell _previousCell;

        void Update()
        {
            if (!EventSystem.current.IsPointerOverGameObject())
            {
                if (Input.GetMouseButton(0))
                {
                    HandleInput();
                    return;
                }

                if (Input.GetKeyDown(KeyCode.U))
                {
                    if (Input.GetKey(KeyCode.LeftShift))
                    {
                        DestroyUnit();
                    }
                    else
                    {
                        CreateUnit();
                    }

                    return;
                }
            }

            _previousCell = null;
        }

        void Awake()
        {
            terrainMaterial.DisableKeyword("GRID_ON");
        }

        public void SetTerrainTypeIndex(int index)
        {
            activeTerrainTypeIndex = index;
        }

        void HandleInput()
        {
            HexCell currentCell = GetCellUnderCursor();
            if (currentCell)
            {
                if (_previousCell && _previousCell != currentCell)
                {
                    ValidateDrag(currentCell);
                }
                else
                {
                    _isDrag = false;
                }

                EditCells(currentCell);

                _previousCell = currentCell;
            }
            else
            {
                _previousCell = null;
            }
        }

        void CreateUnit()
        {
            HexCell cell = GetCellUnderCursor();
            if (cell && !cell.Unit)
            {
                hexGrid.AddUnit(Instantiate(HexUnit.unitPrefab), cell, Random.Range(0f, 360f));
            }
        }

        void DestroyUnit()
        {
            HexCell cell = GetCellUnderCursor();
            if (cell && cell.Unit)
            {
                hexGrid.RemoveUnit(cell.Unit);
            }
        }

        HexCell GetCellUnderCursor()
        {
            return hexGrid.GetCell(Camera.main.ScreenPointToRay(Input.mousePosition));
        }

        void ValidateDrag(HexCell currentCell)
        {
            for (
                _dragDirection = HexDirection.NE;
                _dragDirection <= HexDirection.NW;
                _dragDirection++)
            {
                if (_previousCell.GetNeighbor(_dragDirection) == currentCell)
                {
                    _isDrag = true;
                    return;
                }
            }

            _isDrag = false;
        }

        void EditCells(HexCell center)
        {
            int centerX = center.coordinates.X;
            int centerZ = center.coordinates.Z;

            for (int r = 0, z = centerZ - _brushSize; z <= centerZ; z++, r++)
            {
                for (int x = centerX - r; x <= centerX + _brushSize; x++)
                {
                    EditCell(hexGrid.GetCell(new HexCoordinates(x, z)));
                }
            }

            for (int r = 0, z = centerZ + _brushSize; z > centerZ; z--, r++)
            {
                for (int x = centerX - _brushSize; x <= centerX + r; x++)
                {
                    EditCell(hexGrid.GetCell(new HexCoordinates(x, z)));
                }
            }
        }

        void EditCell(HexCell cell)
        {
            if (cell)
            {
                if (activeTerrainTypeIndex >= 0)
                {
                    cell.TerrainTypeIndex = activeTerrainTypeIndex;
                }

                if (_applyElevation)
                {
                    cell.Elevation = _activeElevation;
                }

                if (_applyWaterLevel)
                {
                    cell.WaterLevel = _activeWaterLevel;
                }

                if (applySpecialIndex)
                {
                    cell.SpecialIndex = activeSpecialIndex;
                }

                if (applyUrbanLevel)
                {
                    cell.UrbanLevel = activeUrbanLevel;
                }

                if (applyFarmLevel)
                {
                    cell.FarmLevel = activeFarmLevel;
                }

                if (applyPlantLevel)
                {
                    cell.PlantLevel = activePlantLevel;
                }

                if (_riverMode == OptionalToggle.No)
                {
                    cell.RemoveRiver();
                }

                if (_roadMode == OptionalToggle.No)
                {
                    cell.RemoveRoads();
                }

                if (_walledMode != OptionalToggle.Ignore)
                {
                    cell.Walled = _walledMode == OptionalToggle.Yes;
                }

                if (_isDrag)
                {
                    HexCell otherCell = cell.GetNeighbor(_dragDirection.Opposite());
                    if (otherCell)
                    {
                        if (_riverMode == OptionalToggle.Yes)
                        {
                            otherCell.SetOutgoingRiver(_dragDirection);
                        }

                        if (_roadMode == OptionalToggle.Yes)
                        {
                            otherCell.AddRoad(_dragDirection);
                        }
                    }
                }
            }
        }

        #region Set Apply Methods

        public void SetEditMode()
        {
            enabled = editModeToggle.isOn ? true : false;
        }

        public void SetApplyElevation()
        {
            _applyElevation = elevationToggle.isOn ? true : false;
        }

        public void SetApplyWaterLevel()
        {
            _applyWaterLevel = waterToggle.isOn ? true : false;
        }

        public void SetApplyUrbanLevel()
        {
            applyUrbanLevel = urbanToggle.isOn ? true : false;
        }

        public void SetApplyFarmLevel()
        {
            applyFarmLevel = farmToggle.isOn ? true : false;
        }

        public void SetApplyPlantLevel()
        {
            applyPlantLevel = plantToggle.isOn ? true : false;
        }

        public void SetApplySpecialIndex()
        {
            applySpecialIndex = specialToggle.isOn ? true : false;
        }

        #endregion

        #region Set Level Methods

        public void SetElevation()
        {
            _activeElevation = (int)elevationSlider.value;
        }

        public void SetRiverMode(int mode)
        {
            _riverMode = (OptionalToggle)mode;
        }

        public void SetRoadMode(int mode)
        {
            _roadMode = (OptionalToggle)mode;
        }

        public void SetWalledMode(int mode)
        {
            _walledMode = (OptionalToggle)mode;
        }

        public void SetBrushSize()
        {
            _brushSize = (int)brushSizeSlider.value;
        }

        public void SetWaterLevel()
        {
            _activeWaterLevel = (int)waterLevelSlider.value;
        }

        public void SetUrbanLevel()
        {
            activeUrbanLevel = (int)urbanLevelSlider.value;
        }

        public void SetFarmLevel()
        {
            activeFarmLevel = (int)farmLevelSlider.value;
        }

        public void SetPlantLevel()
        {
            activePlantLevel = (int)plantLevelSlider.value;
        }

        public void SetSpecialIndex()
        {
            activeSpecialIndex = (int)specialIndexSlider.value;
        }

        #endregion

        public void ShowGrid()
        {
            if (gridToggle.isOn)
            {
                terrainMaterial.EnableKeyword("GRID_ON");
            }
            else
            {
                terrainMaterial.DisableKeyword("GRID_ON");
            }
        }
    }
}

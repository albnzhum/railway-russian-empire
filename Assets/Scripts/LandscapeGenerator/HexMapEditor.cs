using UnityEditor;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    /// <summary>
    /// Handles the editing of hex cells in the mp
    /// </summary>
    public class HexMapEditor : MonoBehaviour
    {
        public Color[] colors;
        [FormerlySerializedAs("HexGrid")] public HexGrid hexGrid;
        private Color _activeColor;

        private int _activeElevation;
        private int _activeWaterLevel;

        private bool _applyColor;
        private bool _applyElevation = true;
        private bool _applyWaterLevel = true;

        private int _brushSize;

        private int activeUrbanLevel, activeFarmLevel, activePlantLevel;
        private bool applyUrbanLevel, applyFarmLevel, applyPlantLevel;

        #region UI Variables

        [Header("UI")]
        [SerializeField] private Slider elevationSlider;
        [SerializeField] private Toggle elevationToggle;
        [Space]
        [SerializeField] private Slider brushSizeSlider;
        [Space]
        [SerializeField] private Slider waterLevelSlider;
        [SerializeField] private Toggle waterToggle;
        [Space]
        [SerializeField] private Slider urbanLevelSlider;
        [SerializeField] private Toggle urbanToggle;
        [Space]
        [SerializeField] private Toggle labelsVisibility; 
        [Space] 
        [SerializeField] private Toggle plantToggle;
        [SerializeField] private Slider plantLevelSlider;
        [Space] 
        [SerializeField] private Toggle farmToggle;
        [SerializeField] private Slider farmLevelSlider;

        #endregion

        enum OptionalToggle
        {
            Ignore, Yes, No
        }

        private OptionalToggle _riverMode, _roadMode;
        private bool _isDrag;
        private HexDirection _dragDirection;
        private HexCell _previousCell;

        private void Awake()
        {
            SelectColor(0);
        }

        private void Update()
        {
            if (Input.GetMouseButton(0) && !EventSystem.current.IsPointerOverGameObject())
            {
                HandleInput();
            }
            else
            {
                _previousCell = null;
            }
        }

        private void HandleInput()
        {
            if (Camera.main != null)
            {
                Ray inputRay = Camera.main.ScreenPointToRay(Input.mousePosition);
                RaycastHit hit;
                if (Physics.Raycast(inputRay, out hit))
                {
                    HexCell currentCell = hexGrid.GetCell(hit.point);
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
                    _isDrag = true;
                }
            }
        }

        private void ValidateDrag(HexCell currentCell)
        {
            for (
                _dragDirection = HexDirection.Ne;
                _dragDirection <= HexDirection.Nw;
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

        private void EditCells(HexCell center)
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

        private void EditCell(HexCell cell)
        {
            if (cell) {
                if (_applyColor) {
                    cell.Color = _activeColor;
                }
                if (_applyElevation) {
                    cell.Elevation = _activeElevation;
                }
                if (_applyWaterLevel) {
                    cell.WaterLevel = _activeWaterLevel;
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
                if (_riverMode == OptionalToggle.No) {
                    cell.RemoveRiver();
                }
                if (_roadMode == OptionalToggle.No) {
                    cell.RemoveRoads();
                }
                if (_isDrag) {
                    HexCell otherCell = cell.GetNeighbor(_dragDirection.Opposite());
                    if (otherCell) {
                        if (_riverMode == OptionalToggle.Yes) {
                            otherCell.SetOutgoingRiver(_dragDirection);
                        }
                        if (_roadMode == OptionalToggle.Yes) {
                            otherCell.AddRoad(_dragDirection);
                        }
                    }
                }
            }
        }

        #region Set Apply Methods

        public void SetApplyElevation()
        {
            if (elevationToggle.isOn) {
                _applyElevation = true;
            } else {
                _applyElevation = false;
            }
        }
        
        public void SetApplyWaterLevel () {
            if (waterToggle.isOn) {
                _applyWaterLevel = true;
            } else {
                _applyWaterLevel = false;
            }
        }
        
        public void SetApplyUrbanLevel () {
            if (urbanToggle.isOn) {
                applyUrbanLevel = true;
            } else {
                applyUrbanLevel = false;
            }
        }

        public void SetApplyFarmLevel()
        {
            if (farmToggle.isOn) applyFarmLevel = true;
            else applyFarmLevel = false;
        }

        public void SetApplyPlantLevel()
        {
            if (plantToggle.isOn) applyPlantLevel = true;
            else applyPlantLevel = false;
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
        
        public void SetBrushSize()
        {
            _brushSize = (int)brushSizeSlider.value;
        }
        
        public void SetWaterLevel () {
            _activeWaterLevel = (int)waterLevelSlider.value;
        }

        public void SetUrbanLevel () {
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

        #endregion

        public void SelectColor(int index)
        {
            _applyColor = index >= 0;
            if (_applyColor)
            {
                _activeColor = colors[index];
            }
        }

        public void ShowUI()
        {
            if (labelsVisibility.isOn)
            {
                hexGrid.ShowUI(true);
            }
            else
            {
                hexGrid.ShowUI(false);
            }
        }
        
        
    }
}

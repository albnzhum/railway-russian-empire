using UnityEditor;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    /// <summary>
    /// Handles the editing of hex cells in the mp
    /// </summary>
    public class HexMapEditor : MonoBehaviour
    {
        public Color[] colors;
        public HexGrid HexGrid;
        private Color activeColor;

        private int activeElevation;

        private bool applyColor;
        private bool applyElevation = true;

        private int brushSize;

        [Header("UI")]
        [SerializeField] private Slider elevationSlider;
        [SerializeField] private Slider brushSizeSlider;
        [SerializeField] private Toggle elevationToggle;
        [SerializeField] private Toggle labelsVisibility;

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
        }

        private void HandleInput()
        {
            Ray inputRay = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(inputRay, out hit))
            {
                EditCells(HexGrid.GetCell(hit.point));
            }
        }

        void EditCells(HexCell center)
        {
            int centerX = center.coordinates.X;
            int centerZ = center.coordinates.Z;

            for (int r = 0, z = centerZ - brushSize; z <= centerZ; z++, r++)
            {
                for (int x = centerX - r; x <= centerX + brushSize; x++)
                {
                    EditCell(HexGrid.GetCell(new HexCoordinates(x, z)));
                }
            }
            for (int r = 0, z = centerZ + brushSize; z > centerZ; z--, r++)
            {
                for (int x = centerX - brushSize; x <= centerX + r; x++)
                {
                    EditCell(HexGrid.GetCell(new HexCoordinates(x, z)));
                }
            }
        }

        void EditCell(HexCell cell)
        {
            if (cell)
            {
                if (applyColor)
                {
                    cell.Color = activeColor;
                }

                if (applyElevation)
                {
                    cell.Elevation = activeElevation;
                }
            }
        }

        public void SetApplyElevation()
        {
            if (elevationToggle.isOn)
            {
                applyElevation = true;
            }
            else
            {
                applyElevation = false;
            }
        }

        public void SetElevation()
        {
            activeElevation = (int)elevationSlider.value;
        }

        public void SelectColor(int index)
        {
            applyColor = index >= 0;
            if (applyColor)
            {
                activeColor = colors[index];
            }
        }

        public void SetBrushSize()
        {
            brushSize = (int)brushSizeSlider.value;
        }

        public void ShowUI()
        {
            if (labelsVisibility.isOn)
            {
                HexGrid.ShowUI(true);
            }
            else
            {
                HexGrid.ShowUI(false);
            }
        }
    }
}

using UnityEditor;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    public class HexMapEditor : MonoBehaviour
    {
        public Color[] colors;
        public HexGrid HexGrid;
        private Color activeColor;

        private int activeElevation;

        [SerializeField] private Slider elevationSlider;

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
                EditCell(HexGrid.GetCell(hit.point));
            }
        }

        void EditCell(HexCell cell)
        {
            cell.color = activeColor;
            cell.Elevation = activeElevation;
            HexGrid.Refresh();
        }

        public void SetElevation()
        {
            activeElevation = (int)elevationSlider.value;
        }

        public void SelectColor(int index)
        {
            activeColor = colors[index];
        }
    }
}

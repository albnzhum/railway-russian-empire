using Components;
using TGS;
using UnityEngine;

public class TestInput : MonoBehaviour
{
    private TerrainGridSystem _tgs;
    private Cell cell;

    private void Awake()
    {
        _tgs = TerrainGridSystem.Instance;
    }

    public void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit))
            {
                cell = DetermineCell(hit.point);

                if (cell != null)
                {
                   // CellComponent.Instance.Cell = cell;
                }
            }
        }
    }
    
    private Cell DetermineCell(Vector3 position)
    {
        return _tgs.CellGetAtPosition(position, true);
    }
}

using System.Collections;
using System.Collections.Generic;
using TGS;
using UnityEngine;

public class MouseInputSystem : MonoBehaviour
{
    private TerrainGridSystem _tgs;
    // Start is called before the first frame update
    void Start()
    {
        _tgs = TerrainGridSystem.Instance;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit))
            {
                Cell _cell = DetermineCell(hit.point);
                if (_cell != null)
                {
                   GameObject go =  GameObject.CreatePrimitive(PrimitiveType.Cube);
                   go.transform.position = _tgs.CellGetPosition(_cell);
                   go.transform.localScale = new Vector3(15, 15, 15);
                }
            }
        }
    }
    
    private Cell DetermineCell(Vector3 position)
    {
        return _tgs.CellGetAtPosition(position, true);
    }
}

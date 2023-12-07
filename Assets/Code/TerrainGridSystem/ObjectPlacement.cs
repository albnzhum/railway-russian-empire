using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TGS;
using UnityEditor;
using UnityEngine;


public class ObjectPlacement : MonoBehaviour
{
    public List<Transform> NonInteractable;
    private TerrainGridSystem TerrainGridSystem;
    
    [ContextMenu("ChangePosition")]
    private void ChangePosition()
    {
        TerrainGridSystem = TerrainGridSystem.Instance;
        
        foreach (var go in NonInteractable)
        {
            RaycastHit hit;
            if (Physics.Raycast(go.position, Vector3.down, out hit, Mathf.Infinity))
            {
                //Debug.Log(hit.point);
                if (hit.collider == TerrainGridSystem.Terrain.GetComponent<TerrainCollider>())
                {
                    Cell cell = TerrainGridSystem.CellGetAtPosition(hit.point, true);
                    go.position = TerrainGridSystem.CellGetPosition(cell);
                    Debug.Log(TerrainGridSystem.CellGetIndex(cell));
                }
            }
        }
    }

}
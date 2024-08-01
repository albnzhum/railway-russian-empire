using System.Collections.Generic;
using System.Linq;
using TGS;
using UnityEngine;

public enum CellBuildingType
{
    NON_INTERACTABLE = 1,
    RAILS = 2,
    WORKERS = 3,
    ENGINE = 4,
    BUILD = 5
}

public class ObjectPlacement : MonoBehaviour
{
    private List<NonInteractableObject> _objectsToPlace;
    private TerrainGridSystem _tgs;

    private void OnEnable()
    {
        _objectsToPlace = GetComponentsInChildren<NonInteractableObject>().ToList();
    }

    private void Start()
    {
        foreach (var obj in _objectsToPlace)
        {
            Cell cell = _tgs.CellGetAtPosition(obj.Object.transform.position, true);

            if (cell != null)
            {
                obj.Object.transform.position = _tgs.CellGetPosition(cell);
                obj.CellIndex = _tgs.CellGetIndex(cell);
                _tgs.CellSetTag(cell, (int)CellBuildingType.NON_INTERACTABLE);
                _tgs.CellSetCanCross(obj.CellIndex, false);
            }
            else
            {
                Debug.LogWarning("Object is not over a valid TGS cell");
            }
        }

        _tgs.CellSetCanCross(_objectsToPlace[0].CellIndex, true);
        _tgs.CellSetCanCross(_objectsToPlace[^1].CellIndex, true);
    }
}
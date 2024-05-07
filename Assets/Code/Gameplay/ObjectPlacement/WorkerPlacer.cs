using System;
using TGS;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Gameplay
{
    public class WorkerPlacer : MonoBehaviour, IPlaceable
    {
        public UnityAction OnCancelEvent;
        public GameObject Prefab { get; set; }
        public TerrainGridSystem TGS { get; set; }
        public void Place(Cell cell)
        {
            if (cell.tag != (int)CellBuildingType.BUILD)
            {
                Debug.LogError("Workers can't be placing here");
                OnCancelEvent.Invoke();
            }

            TGS.CellSetTag(cell, (int)CellBuildingType.WORKERS);
            TGS.CellSetCanCross(TGS.CellGetIndex(cell), false);

            var cellPosition = TGS.CellGetPosition(cell);
            Instantiate(Prefab, cellPosition, Quaternion.identity);
        }
    }
}
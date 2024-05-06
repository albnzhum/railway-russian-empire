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
        private TerrainGridSystem _tgs;

        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;
        }

        public void Place(Cell cell)
        {
            if (cell.tag != (int)CellBuildingType.BUILD)
            {
                Debug.LogError("Workers can't be placing here");
                OnCancelEvent.Invoke();
            }
            
            _tgs.CellSetTag(cell, (int)CellBuildingType.WORKERS);
            _tgs.CellSetCanCross(_tgs.CellGetIndex(cell), false);
            
            var cellPosition = _tgs.CellGetPosition(cell);
            Instantiate(Prefab, cellPosition, Quaternion.identity);
        }
    }
}
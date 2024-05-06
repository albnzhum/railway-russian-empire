using System;
using Dreamteck.Splines;
using TGS;
using UnityEngine;

namespace Railway.Gameplay
{
    public class CarriagePlacer : MonoBehaviour, IPlaceable
    {
        public GameObject Prefab { get; set; }
        private TerrainGridSystem _tgs;

        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;
        }

        public void Place(Cell cell)
        {
            if (cell.tag != (int)CellBuildingType.ENGINE)
            {
                Debug.LogError("Carriage can't be placing here!");
            }
            
            var cellPosition = _tgs.CellGetPosition(cell);
            var currentWagon = Instantiate(Prefab, cellPosition, Quaternion.identity);
            currentWagon.GetComponentInChildren<SplinePositioner>().spline = RailBuilder.Instance.spline;
        }
    }
}
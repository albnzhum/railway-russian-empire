using System;
using Dreamteck.Splines;
using TGS;
using UnityEngine;

namespace Railway.Gameplay
{
    public class EnginePlacer : MonoBehaviour, IPlaceable
    {
        public GameObject Prefab { get; set; }
        private TerrainGridSystem _tgs;

        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;
        }

        public void Place(Cell cell)
        {
            if (cell.tag != (int)CellBuildingType.RAILS)
            {
                Debug.LogError("Engine can't be placing here!");
            }

            var cellPosition = _tgs.CellGetPosition(cell);
            
            var locomotive = Instantiate(Prefab, cellPosition, Quaternion.identity);
            locomotive.GetComponentInChildren<SplineFollower>().spline = RailBuilder.Instance.spline;

        }
    }
}
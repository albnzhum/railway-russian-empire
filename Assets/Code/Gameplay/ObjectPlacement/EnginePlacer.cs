using System;
using Dreamteck.Splines;
using TGS;
using UnityEngine;
using UnityEngine.Serialization;

namespace Railway.Gameplay
{
    public class EnginePlacer : MonoBehaviour, IPlaceable
    {
        public GameObject Prefab { get; set; }
        public TerrainGridSystem TGS { get; set; }

        public void Place(Cell cell)
        {
            if (cell.tag != (int)CellBuildingType.RAILS)
            {
                Debug.LogError("Engine can't be placing here!");
            }

            var cellPosition = TGS.CellGetPosition(cell);

            var locomotive = Instantiate(Prefab, cellPosition, Quaternion.identity);
            locomotive.GetComponentInChildren<SplineFollower>().spline = RailBuilder.Instance.spline;
        }
    }
}
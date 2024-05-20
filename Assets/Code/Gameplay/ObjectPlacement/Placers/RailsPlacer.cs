using System;
using TGS;
using UnityEngine;
using UnityEngine.Serialization;

namespace Railway.Gameplay
{
    public class RailsPlacer : MonoBehaviour, IPlaceable
    {
        public GameObject Prefab { get; set; }
        public TerrainGridSystem TGS { get; set; }

        public void Place(Cell cell)
        {
            TGS.CellSetTag(cell, (int)CellBuildingType.RAILS);

            TGS.CellSetCanCross(TGS.CellGetIndex(cell), false);
        }
    }
}
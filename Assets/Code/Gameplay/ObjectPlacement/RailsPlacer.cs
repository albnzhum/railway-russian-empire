using System;
using TGS;
using UnityEngine;

namespace Railway.Gameplay
{
    public class RailsPlacer : MonoBehaviour, IPlaceable
    {
        public GameObject Prefab { get; set; }
        private TerrainGridSystem _tgs;

        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;
        }

        public void Place(Cell cell)
        {
            _tgs.CellSetTag(cell, (int)CellBuildingType.RAILS);
            
            _tgs.CellSetCanCross(_tgs.CellGetIndex(cell), false);
        }
    }
}
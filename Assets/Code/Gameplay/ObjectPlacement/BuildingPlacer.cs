using TGS;
using UnityEngine;

namespace Railway.Gameplay
{
    public class BuildingPlacer: MonoBehaviour, IPlaceable
    {
        public GameObject Prefab { get; set; }
        public TerrainGridSystem TGS { get; set; }

        public void Place(Cell cell)
        {
            TGS.CellSetTag(cell, (int)CellBuildingType.BUILD);
            
            TGS.CellSetCanCross(TGS.CellGetIndex(cell), false);

            var cellPosition = TGS.CellGetPosition(cell);

            Instantiate(Prefab, cellPosition, Quaternion.identity);
        }
    }
}
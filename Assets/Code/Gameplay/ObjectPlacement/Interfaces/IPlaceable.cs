using TGS;
using UnityEngine;

namespace Railway.Gameplay
{
    public interface IPlaceable
    {
        public GameObject Prefab { get; set; }
        public TerrainGridSystem TGS { get; set; }
        public void Place(Cell cell);
    }
}
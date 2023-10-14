using UnityEngine;

namespace LandscapeGenerator
{
    /// <summary>
    /// Store a collection of prefabs used in a hex grid
    /// </summary>
    [System.Serializable]
    public struct HexFeatureCollection
    {
        public Transform[] prefabs;

        public Transform Pick(float choice)
        {
            return prefabs[(int)(choice * prefabs.Length)];
        }
    }
}

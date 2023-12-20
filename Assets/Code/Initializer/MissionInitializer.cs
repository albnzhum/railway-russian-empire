using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Railway.Components
{
    [CreateAssetMenu(fileName = "New Mission Initializer", menuName = "Initializer/Mission Initializer")]
    public class MissionInitializer : ScriptableObject
    {
        public List<CityInitializer> Cities;
        public Resources resources;
        public Resources originalResources;
        public bool isOriginalResourcesSaved;

        [System.Serializable]
        public struct Resources
        {
            public float Gold;
            public float Workers;
            public float Church;
            public float SpeedBuilding;
        }
    }
}
using System.Collections.Generic;
using UnityEngine;

namespace Railway.Components
{
    [CreateAssetMenu(fileName = "New Mission Initializer", menuName = "Initializer/Mission Initializer")]
    public class MissionInitializer : ScriptableObject
    {
        [SerializeField] private List<CityInitializer> _cities;
        [SerializeField] private Resources _resources;
        
        public List<CityInitializer> Cities => _cities;
        public Resources resources
        {
            get => _resources;
            set => _resources = value;
        }
        public Resources OriginalResources { get; set; }
        public bool IsOriginalResourcesSaved { get; set; }

        [System.Serializable]
        public class Resources
        {
            public float Gold;
            public float Workers;
            public float Church;
            public float SpeedBuilding;
        }
    }
}
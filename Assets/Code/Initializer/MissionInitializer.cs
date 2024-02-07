using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Railway.Components
{
    [CreateAssetMenu(fileName = "New Mission Initializer", menuName = "Initializer/Mission Initializer")]
    public class MissionInitializer : ScriptableObject
    {
        [SerializeField] private List<CityInitializer> _cities;
        [SerializeField] private Resources _resources;
        [HideInInspector] private Resources _originalResources;
        [SerializeField] private bool _isOriginalResourcesSaved;
        
        public List<CityInitializer> Cities => _cities;
        public Resources resources
        {
            get => _resources;
            set => _resources = value;
        }
        public Resources originalResources { get; set; }
        public bool isOriginalResourcesSaved { get; set; }

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
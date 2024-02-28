using System;
using System.Collections.Generic;
using UnityEngine;
using R3;
using Railway.Gameplay.UI;

namespace Railway.Components
{
    [CreateAssetMenu(fileName = "New Mission Initializer", menuName = "Initializer/Mission Initializer")]
    public class MissionInitializer : ScriptableObject
    {
        [SerializeField] private string _name;
        [SerializeField] private List<CityInitializer> _cities;
        [SerializeField] private Resources _originalResources;
        public string Name => _name;
        public List<CityInitializer> Cities => _cities;

        public Resources OriginalResources => _originalResources;
        
        private Resources _currentResources = null;
        public Resources CurrentResources
        {
            get => _currentResources ?? (_currentResources = new Resources(OriginalResources));
            set => _currentResources = value;
        }
        
        public SerializableReactiveProperty<float> GetReactiveProperty(ResourceType resourceType)
        {
            switch (resourceType)
            {
                case ResourceType.Gold:
                    return CurrentResources.Gold;
                case ResourceType.Workers:
                    return CurrentResources.Workers;
                case ResourceType.Church:
                    return CurrentResources.Church;
                case ResourceType.Fuel:
                    return CurrentResources.Fuel;
                case ResourceType.TechProgress:
                    return CurrentResources.TechProgress;
                case ResourceType.SpeedBuilding:
                    return CurrentResources.SpeedBuilding;
                
                default:
                    throw new ArgumentOutOfRangeException(nameof(resourceType), resourceType, null);
            }
        }
        
        [System.Serializable]
        public class Resources
        {
            public SerializableReactiveProperty<float> Gold;
            public SerializableReactiveProperty<float> Workers;
            public SerializableReactiveProperty<float> Church;
            public SerializableReactiveProperty<float> Fuel;
            public SerializableReactiveProperty<float> TechProgress;
            public SerializableReactiveProperty<float> SpeedBuilding;
            
            public Resources(Resources original)
            {
                Gold = new SerializableReactiveProperty<float>(original.Gold.Value);
                Workers = new SerializableReactiveProperty<float>(original.Workers.Value);
                Church = new SerializableReactiveProperty<float>(original.Church.Value);
                SpeedBuilding = new SerializableReactiveProperty<float>(original.SpeedBuilding.Value);
                Fuel = new SerializableReactiveProperty<float>(original.Fuel.Value);
                TechProgress = new SerializableReactiveProperty<float>(original.TechProgress.Value);
            }
        }
    }
}
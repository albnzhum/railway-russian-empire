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
            get => _currentResources ??= new Resources(OriginalResources);
            set => _currentResources = value;
        }

        public SerializableReactiveProperty<float> GetCurrentReactiveProperty(ResourceType resourceType)
        {
            switch (resourceType)
            {
                case ResourceType.Gold:
                    return CurrentResources.Gold.CurrentValue;
                case ResourceType.Workers:
                    return CurrentResources.Workers.CurrentValue;
                case ResourceType.Church:
                    return CurrentResources.Church.CurrentValue;
                case ResourceType.Fuel:
                    return CurrentResources.Fuel.CurrentValue;
                case ResourceType.TechProgress:
                    return CurrentResources.TechProgress.CurrentValue;
                case ResourceType.SpeedBuilding:
                    return CurrentResources.SpeedBuilding.CurrentValue;

                default:
                    throw new ArgumentOutOfRangeException(nameof(resourceType), resourceType, null);
            }
        }

        public SerializableReactiveProperty<float> GetAddedReactiveProperty(ResourceType resourceType)
        {
            switch (resourceType)
            {
                case ResourceType.Gold:
                    return CurrentResources.Gold.AddedValue;
                case ResourceType.Workers:
                    return CurrentResources.Workers.AddedValue;
                case ResourceType.Church:
                    return CurrentResources.Church.AddedValue;
                case ResourceType.Fuel:
                    return CurrentResources.Fuel.AddedValue;
                case ResourceType.TechProgress:
                    return CurrentResources.TechProgress.AddedValue;
                case ResourceType.SpeedBuilding:
                    return CurrentResources.SpeedBuilding.AddedValue;

                default:
                    throw new ArgumentOutOfRangeException(nameof(resourceType), resourceType, null);
            }
        }

        [System.Serializable]
        public class Resources
        {
            public ResourceStat Gold;
            public ResourceStat Workers;
            public ResourceStat Church;
            public ResourceStat Fuel;
            public ResourceStat TechProgress;
            public ResourceStat SpeedBuilding;

            public Resources(Resources original)
            {
                Gold = new ResourceStat(original.Gold.CurrentValue);
                Workers = new ResourceStat(original.Workers.CurrentValue);
                Church = new ResourceStat(original.Church.CurrentValue);
                SpeedBuilding = new ResourceStat(original.SpeedBuilding.CurrentValue);
                Fuel = new ResourceStat(original.Fuel.CurrentValue);
                TechProgress = new ResourceStat(original.TechProgress.CurrentValue);
            }
        }

        [System.Serializable]
        public class ResourceStat
        {
            public SerializableReactiveProperty<float> CurrentValue;
            public SerializableReactiveProperty<float> AddedValue;

            public ResourceStat(SerializableReactiveProperty<float> currentValue,
                SerializableReactiveProperty<float> addedValue = null)
            {
                this.CurrentValue = currentValue;
                this.AddedValue = addedValue ?? new SerializableReactiveProperty<float>(0f);
                ;
            }
        }
    }
}
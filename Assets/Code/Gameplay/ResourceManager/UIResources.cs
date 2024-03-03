using System;
using System.Globalization;
using Railway.Components;
using Railway.Idents.UI;
using UnityEngine;
using UnityEngine.UI;
using R3;
using TMPro;
using UnityEngine.Serialization;

namespace Railway.Gameplay.UI
{
    public enum ResourceType { Gold, Workers, Church, SpeedBuilding, Fuel, TechProgress }
    
    public class UIResources : MonoBehaviour
    {
        [Header("UI Text")]
        [SerializeField] private TMP_Text[] _currentResourceTexts = new TMP_Text[Enum.GetValues(typeof(ResourceType)).Length];
        [SerializeField] private TMP_Text[] _addedResourceTexts = new TMP_Text[Enum.GetValues(typeof(ResourceType)).Length];

        [SerializeField] private MissionInitializer mission;

        private CompositeDisposable _disposable = new CompositeDisposable();
        
        private void OnEnable()
        {
            for (int i = 0; i < _currentResourceTexts.Length; i++)
            {
                ResourceType currentResourceType = (ResourceType)i;

                SerializableReactiveProperty<float> currentReactiveProperty = mission.GetCurrentReactiveProperty(currentResourceType);

                currentReactiveProperty
                    .Subscribe(value => _currentResourceTexts[i].text = value.ToString())
                    .AddTo(_disposable);
            }
            
            for (int i = 0; i < _addedResourceTexts.Length; i++)
            {
                ResourceType currentResourceType = (ResourceType)i;

                SerializableReactiveProperty<float> addedReactiveProperty = mission.GetAddedReactiveProperty(currentResourceType);

                addedReactiveProperty
                    .Subscribe(value => _addedResourceTexts[i].text = value.ToString())
                    .AddTo(_disposable);
            }
        }

        private void OnDisable()
        {
            _disposable.Dispose();
        }

        private void BindTextToResource(ResourceType resourceType, string format)
        {
            mission.GetCurrentReactiveProperty(resourceType)
                .Subscribe(value => _currentResourceTexts[(int)resourceType].text =  value.ToString())
                .AddTo(_disposable);
        }

        private string FormatText(string format, float value)
        {
            return format + " " + value;
        }
    }
}
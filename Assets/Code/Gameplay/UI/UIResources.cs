using System;
using Railway.Components;
using Railway.Idents.UI;
using UnityEngine;
using UnityEngine.UI;
using R3;

namespace Railway.Gameplay.UI
{
    public enum ResourceType { Gold, Workers, Church, SpeedBuilding, Fuel, TechProgress }
    
    public class UIResources : MonoBehaviour
    {
        [Header("UI Text")]
        [SerializeField] private Text[] _resourceTexts = new Text[Enum.GetValues(typeof(ResourceType)).Length];

        [SerializeField] private MissionInitializer mission;

        private CompositeDisposable _disposable = new CompositeDisposable();
        
        private void OnEnable()
        {
            BindTextToResource(ResourceType.Gold, UITextFormat.Resources.Gold);
            BindTextToResource(ResourceType.Workers, UITextFormat.Resources.Workers);
            BindTextToResource(ResourceType.Church, UITextFormat.Resources.Church);
            BindTextToResource(ResourceType.SpeedBuilding, UITextFormat.Resources.SpeedBuilding);
            BindTextToResource(ResourceType.Fuel, UITextFormat.Resources.Fuel);
            BindTextToResource(ResourceType.TechProgress, UITextFormat.Resources.TechProgress);
        }

        private void OnDisable()
        {
            _disposable.Dispose();
        }

        private void BindTextToResource(ResourceType resourceType, string format)
        {
            mission.GetReactiveProperty(resourceType)
                .Subscribe(value => _resourceTexts[(int)resourceType].text = FormatText(format, value))
                .AddTo(_disposable);
        }

        private string FormatText(string format, float value)
        {
            return format + " " + value;
        }
    }
}
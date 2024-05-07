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
    public enum ResourceType
    {
        Gold,
        Workers,
        Church,
        SpeedBuilding,
        Fuel,
        TechProgress
    }

    public class UIResources : MonoBehaviour
    {
        [Header("UI Text")] [SerializeField]
        private TMP_Text[] _currentResourceTexts = new TMP_Text[Enum.GetValues(typeof(ResourceType)).Length];

        [SerializeField]
        private TMP_Text[] _addedResourceTexts = new TMP_Text[Enum.GetValues(typeof(ResourceType)).Length];

        [SerializeField] private MissionInitializer mission;

        private CompositeDisposable _disposable = new CompositeDisposable();

        private void OnEnable()
        {
            BindTextToCurrentResource(ResourceType.Gold, UITextFormat.Resources.Gold);
            BindTextToCurrentResource(ResourceType.Workers, UITextFormat.Resources.Workers);
            BindTextToCurrentResource(ResourceType.Church, UITextFormat.Resources.Church);
            BindTextToCurrentResource(ResourceType.SpeedBuilding, UITextFormat.Resources.SpeedBuilding);
            BindTextToCurrentResource(ResourceType.Fuel, UITextFormat.Resources.Fuel);
            BindTextToCurrentResource(ResourceType.TechProgress, UITextFormat.Resources.TechProgress);
        }

        private void OnDisable()
        {
            _disposable.Dispose();
        }

        private void BindTextToCurrentResource(ResourceType resourceType, string format)
        {
            mission.GetCurrentReactiveProperty(resourceType)
                .Subscribe(value => _currentResourceTexts[(int)resourceType].text = value.ToString())
                .AddTo(_disposable);

            mission.GetAddedReactiveProperty(resourceType)
                .Subscribe(value => _addedResourceTexts[(int)resourceType].text = value.ToString())
                .AddTo(_disposable);
        }

        private string FormatText(string format, float value)
        {
            return format + " " + value;
        }
    }
}
using System;
using Railway.Components;
using Railway.Events;
using Railway.Idents.UI;
using UnityEngine;
using UnityEngine.UI;
using R3;
using UnityEngine.Serialization;

namespace Railway.Gameplay.UI
{
    public class UIResources : MonoBehaviour
    {
        [Header("UI Canvas")] 
        [SerializeField] private GameObject Resources;
        
        [Header("UI Text")] 
        [SerializeField] private Text _goldText;
        [SerializeField] private Text _workersText;
        [SerializeField] private Text _churchText;
        [SerializeField] private Text _speedBuildingText;
        [SerializeField] private Text _fuelText;
        [SerializeField] private Text _techprogressText;

        [SerializeField] private MissionInitializer mission;
        
        private void OnEnable()
        {
            mission.CurrentResources.Gold.Subscribe(value => _goldText.text = FormatText(UITextFormat.Resources.Gold, value));
            mission.CurrentResources.Workers.Subscribe(value => _workersText.text = FormatText(UITextFormat.Resources.Workers, value));
            mission.CurrentResources.Church.Subscribe(value => _churchText.text = FormatText(UITextFormat.Resources.Church, value));
            mission.CurrentResources.SpeedBuilding.Subscribe(value => _speedBuildingText.text = FormatText(UITextFormat.Resources.SpeedBuilding, value));
            mission.CurrentResources.Fuel.Subscribe(value => _fuelText.text = FormatText(UITextFormat.Resources.Fuel, value));
            mission.CurrentResources.TechProgress.Subscribe(value => _techprogressText.text = FormatText(UITextFormat.Resources.TechProgress, value));
        }

        private string FormatText(string format, float value)
        {
            return format + " " + value;
        }
    }
}
using System;
using Railway.Events;
using Railway.Idents.II;
using UnityEngine;
using UnityEngine.UI;
using Resources = Railway.Components.MissionInitializer.Resources;

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

        [Header("Listening to")] [SerializeField]
        private ResourcesUpdateEventSO _onResourcesUpdated;

        private void OnEnable()
        {
            _onResourcesUpdated.OnResourcesUpdated += ShowResources;
        }

        private void OnDisable()
        {
            _onResourcesUpdated.OnResourcesUpdated -= ShowResources;
        }

        private void ShowResources(Resources resources)
        {
            Resources.SetActive(true);
            
            _goldText.text = FormatText(UITextFormat.Resources.Gold, resources.Gold);
            _workersText.text = FormatText(UITextFormat.Resources.Workers, resources.Workers);
            _churchText.text = FormatText(UITextFormat.Resources.Church, resources.Church);
            _speedBuildingText.text = FormatText(UITextFormat.Resources.SpeedBuilding, resources.SpeedBuilding);
        }

        private string FormatText(string format, float value)
        {
            return format + " " + value;
        }
    }
}
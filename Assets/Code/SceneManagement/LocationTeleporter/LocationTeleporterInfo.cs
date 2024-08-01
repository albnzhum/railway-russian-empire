using System;
using R3;
using Railway.Components;
using Railway.Events;
using Railway.Gameplay.UI;
using Railway.Idents.UI;
using Railway.Input;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using Resources = Railway.Components.MissionInitializer.Resources;

namespace Railway.SceneManagement
{
    /// <summary>
    /// Show initial stats and updating it
    /// </summary>
    public class LocationTeleporterInfo : MonoBehaviour
    {
        [SerializeField] private GameObject Canvas;

        [Header("UI Mission")] 
        [SerializeField] private TMP_Text _missionName;

        [SerializeField] private TMP_Text _resourceInstantiate;
        [SerializeField] private TMP_Text _cityInstantiate;

        [Header("UI Parents")] 
        [SerializeField] private Transform _resourceParent;

        [SerializeField] private Transform _cityParent;

        [HideInInspector] public MissionInitializer mission;
        private bool isActive = false;

        CompositeDisposable disposables = new CompositeDisposable();

        private void OnDisable()
        {
            disposables.Dispose();
        }

        public void ShowMissionInfo(MissionInitializer mission, bool setActive = true)
        {
            if (!isActive)
            {
                isActive = true;
                Canvas.SetActive(setActive);

                _missionName.text = mission.Name;
            }

            foreach (var city in mission.Cities)
            {
                ShowCityInfo(city);
            }

            ShowResourceInfo(mission.CurrentResources);
        }

        private void ShowCityInfo(CityInitializer city)
        {
            TMP_Text cityName = Instantiate(_cityInstantiate, _cityParent);
            cityName.text = city.Name;
        }

        private void ShowResourceInfo(Resources resources)
        {
            TMP_Text[] _resourceTexts = new TMP_Text[Enum.GetValues(typeof(ResourceType)).Length];

            for (int i = 0; i < _resourceTexts.Length; i++)
            {
                ResourceType currentResourceType = (ResourceType)i;
                _resourceTexts[i] = Instantiate(_resourceInstantiate, _resourceParent);

                SerializableReactiveProperty<float> currentReactiveProperty =
                    mission.GetCurrentReactiveProperty(currentResourceType);

                currentReactiveProperty
                    .Subscribe(value => _resourceTexts[i].text = value.ToString())
                    .AddTo(disposables);
            }
        }
    }
}
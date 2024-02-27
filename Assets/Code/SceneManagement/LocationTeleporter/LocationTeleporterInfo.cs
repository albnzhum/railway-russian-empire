using R3;
using Railway.Components;
using Railway.Events;
using Railway.Idents.UI;
using Railway.Input;
using UnityEngine;
using UnityEngine.UI;
using Resources = Railway.Components.MissionInitializer.Resources;

namespace Railway.SceneManagement
{
    public class LocationTeleporterInfo : MonoBehaviour
    {
        [SerializeField] private GameObject Canvas;

        [Header("UI Mission")]
        [SerializeField] private Text _missionName;
        [SerializeField] private Text _resourceInstantiate;
        [SerializeField] private Text _cityInstantiate;

        [Header("UI Parents")] 
        [SerializeField] private Transform _resourceParent;
        [SerializeField] private Transform _cityParent;

        [SerializeField] private VoidEventChannelSO _onChangeLevelDifficulty;

        [HideInInspector] public MissionInitializer mission;
        private bool isActive = false;

       /* private void Start()
        {
            _onChangeLevelDifficulty.OnEventRaised += RefreshResources;
        }

        private void OnDisable()
        {
            _onChangeLevelDifficulty.OnEventRaised -= RefreshResources;
        }*/

        /*private void Update()
        {
            
            if (!isActive)
            {
                DeleteChildren();
            }
        }

        private void DeleteChildren()
        {
            for (int i = _resourceParent.childCount - 1; i >= 0; i--)
            {
                Destroy(_resourceParent.GetChild(i).gameObject);
            }
                
            for (int i = _cityParent.childCount - 1; i >= 0; i--)
            {
                Destroy(_cityParent.GetChild(i).gameObject);
            }
        }

        public void RefreshResources()
        {
            if (!isActive)
                return;

            DeleteChildren();
            ShowMissionInfo(mission);
        }*/
        
        public void RefreshResources()
        {
            ShowMissionInfo(mission);
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
            Text cityName = Instantiate(_cityInstantiate, _cityParent);
            cityName.text = city.Name;
        }

        private void ShowResourceInfo(Resources resources)
        {
            Text gold = Instantiate(_resourceInstantiate, _resourceParent);
            Text workers = Instantiate(_resourceInstantiate, _resourceParent);
            Text church = Instantiate(_resourceInstantiate, _resourceParent);
            Text speedBuilding = Instantiate(_resourceInstantiate, _resourceParent);
            Text techProgress = Instantiate(_resourceInstantiate, _resourceParent);
            Text fuel = Instantiate(_resourceInstantiate, _resourceParent);
            
            resources.Gold.Subscribe(value => gold.text = FormatText(UITextFormat.Resources.Gold, value));
            resources.Workers.Subscribe(value => workers.text = FormatText(UITextFormat.Resources.Workers, value));
            resources.Church.Subscribe(value => church.text = FormatText(UITextFormat.Resources.Church, value));
            resources.SpeedBuilding.Subscribe(value => speedBuilding.text = FormatText(UITextFormat.Resources.SpeedBuilding, value));
            resources.TechProgress.Subscribe(value => techProgress.text = FormatText(UITextFormat.Resources.TechProgress, value));
            resources.Fuel.Subscribe(value => fuel.text = FormatText(UITextFormat.Resources.Fuel, value));
            
            /*gold.text = resources.Gold.ToString();
            workers.text = resources.Workers.ToString();
            church.text = resources.Church.ToString();
            speedBuilding.text = resources.SpeedBuilding.ToString();
            techProgress.text = resources.TechProgress.ToString();
            fuel.text = resources.Fuel.ToString();*/
        }
        
        private string FormatText(string format, float value)
        {
            return format + " " + value;
        }

    }
}

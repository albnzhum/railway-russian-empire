using Railway.Components;
using Railway.Events;
using Railway.Input;
using UnityEngine;
using UnityEngine.UI;
using Resources = Railway.Components.MissionInitializer.Resources;

namespace Railway.SceneManagement
{
    public class LocationTeleporterInfo : MonoBehaviour
    {
        [SerializeField] private GameObject Canvas;
        [SerializeField] private InputReader _inputReader;

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

        private void Start()
        {
            _onChangeLevelDifficulty.OnEventRaised += RefreshResources;
        }

        private void OnEnable()
        {
            
        }

        private void OnDisable()
        {
            _onChangeLevelDifficulty.OnEventRaised -= RefreshResources;
        }

        private void Update()
        {
            /*if (Input.GetKeyDown(KeyCode.C))
            {
                gameObject.SetActive(false);
                isActive = false;
            }*/

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
        }
        
        public void ShowMissionInfo(MissionInitializer mission, bool setActive = true)
        {
            if (!isActive)
            {
                isActive = true;
                Canvas.SetActive(setActive);
            }

            foreach (var city in mission.Cities)
            {
                ShowCityInfo(city);
            }
            
            ShowResourceInfo(mission.resources);
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
            
            gold.text = resources.Gold.ToString();
            workers.text = resources.Workers.ToString();
            church.text = resources.Church.ToString();
            speedBuilding.text = resources.SpeedBuilding.ToString();
        }

    }
}

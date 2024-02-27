using System;
using Railway.Components;
using Railway.Events;
using Railway.Input;
using Railway.SceneManagement;
using Railway.UI;
using Railway.Gameplay;
using Railway.Gameplay.UI;
using UnityEngine;
using UnityEngine.Serialization;

namespace Railway.Shop.UI
{
    public class UIManager : MonoBehaviour
    {
        [Header("Scene UI")] 
        [SerializeField] private UIPopup _popupPanel;
        [SerializeField] private UIShop _shopPanel;
        [SerializeField] private UISettingsController _settingsScreen;
        [SerializeField] private UIHud _hud;
        [SerializeField] private UIResources _uiResources;

        [Header("Gameplay")] 
        [SerializeField] private GameStateSO _gameStateManager;
        [SerializeField] private MenuSceneSO _mainMenu;
        [SerializeField] private InputReader _inputReader;

        [Header("Listening on")] 
        [SerializeField] private BoolEventChannelSO _onLocationLoadedEvent;
        [SerializeField] private ResourcesUpdateEventSO _onResourcesUpdated;

        [Header("Broadcasting on")] 
        [SerializeField] private LoadEventChannelSO _loadMenuEvent = default;
        [SerializeField] private VoidEventChannelSO _openShopScreen;
        [SerializeField] private ItemEventChannel _useItemEvent = default;
        
        [SerializeField] private MissionInitializer _missionInitializer;

        private void OnEnable()
        {
            _inputReader.OpenShopEvent += SetShopScreen;
            _shopPanel.Closed += CloseShopScreen;

            _onLocationLoadedEvent.OnEventRaised += ShowUI;

            _hud.OpenShopEvent += SetShopScreen;
        }

        private void OnDisable()
        {
            _shopPanel.Closed -= CloseShopScreen;
            _hud.OpenShopEvent -= SetShopScreen;
            
            _onLocationLoadedEvent.OnEventRaised -= ShowUI;
            _inputReader.OpenShopEvent -= SetShopScreen;
        }

        private void ShowUI(bool isLoading)
        {
            _uiResources.gameObject.SetActive(isLoading);
            _hud.gameObject.SetActive(isLoading);
        }

        private void SetShopScreen()
        {
            if (_gameStateManager.CurrentGameState == GameState.Gameplay)
            {
                OpenShopScreen();
            }
        }

        private void OpenShopScreen()
        {
            _shopPanel.FillInventory();
            
            _inputReader.CloseShopEvent += CloseShopScreen;
            
            _shopPanel.gameObject.SetActive(true);
            _inputReader.EnableMenuInput();
            
            _gameStateManager.UpdateGameState(GameState.Shop);
        }

        private void CloseShopScreen()
        {
            _inputReader.CloseShopEvent -= CloseShopScreen;
            _shopPanel.gameObject.SetActive(false);

            if (_shopPanel.IsItemBuying)
            {
                _gameStateManager.UpdateGameState(GameState.Edit);
                _useItemEvent.RaiseEvent(_shopPanel.CurrentItem);
                _inputReader.EnableEditInput();
            }
            else
            {
                _gameStateManager.ResetToPreviousGameState();
            }

            if (_gameStateManager.CurrentGameState == GameState.Gameplay )
                _inputReader.EnableGameplayInput();
        }
    }
}

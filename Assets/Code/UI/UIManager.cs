using System;
using Railway.Events;
using Railway.Input;
using Railway.SceneManagement;
using Railway.UI;
using Railway.Gameplay;
using UnityEngine;

namespace Railway.Shop.UI
{
    public class UIManager : MonoBehaviour
    {
        [Header("Scene UI")] 
        [SerializeField] private UIPopup _popupPanel;
        [SerializeField] private UIShop _shopPanel;
        [SerializeField] private UISettingsController _settingsScreen;

        [Header("Gameplay")] 
        [SerializeField] private GameStateSO _gameStateManager;
        [SerializeField] private MenuSceneSO _mainMenu;
        [SerializeField] private InputReader _inputReader;

        [Header("Listening on")] 
        [SerializeField] private VoidEventChannelSO _onSceneReady;

        [Header("Broadcasting on")] 
        [SerializeField] private LoadEventChannelSO _loadMenuEvent = default;
        [SerializeField] private VoidEventChannelSO _openShopScreen;

        private void OnEnable()
        {
            _inputReader.OpenShopEvent += SetShopScreen;
            _shopPanel.Closed += CloseShopScreen;
        }

        private void OnDisable()
        {
            _shopPanel.Closed -= CloseShopScreen;
            _inputReader.OpenShopEvent -= SetShopScreen;
        }

        private void SetShopScreen()
        {
            if (_gameStateManager.CurrentGameState == GameState.Gameplay)
            {
                OpenShopScreen();
                Debug.Log("shop opened");
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
            _gameStateManager.ResetToPreviousGameState();
            
            if (_gameStateManager.CurrentGameState == GameState.Gameplay )
                _inputReader.EnableGameplayInput();
        }
    }
}

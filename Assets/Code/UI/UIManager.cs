using System;
using Railway.Events;
using Railway.Gameplay.Shop.UI;
using Railway.Input;
using Railway.SceneManagement;
using Railway.UI;
using UnityEngine;

namespace Railway.Gameplay.UI
{
    public class UIManager : MonoBehaviour
    {
        [Header("Scene UI")] 
        [SerializeField] private UIPopup _popupPanel;
        [SerializeField] private UIShop _shopPanel;
        //[SerializeField] private UIPause _pauseScreen;
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

        /*private void Update()
        {
            if (UnityEngine.Input.GetKeyDown(KeyCode.X))
            {
                SetShopScreen();
            }
        }*/

        private void SetShopScreen()
        {
            OpenShopScreen();
            if (_gameStateManager.CurrentGameState == GameState.Gameplay)
            {
                OpenShopScreen();
            }
        }

        private void OpenShopScreen()
        {
            _shopPanel.FillInventory();
            _shopPanel.gameObject.SetActive(true);
            _inputReader.EnableMenuInput();
            Debug.Log("shop opened");
            
            _gameStateManager.UpdateGameState(GameState.Shop);
        }

        private void CloseShopScreen()
        {
            _shopPanel.gameObject.SetActive(false);
            
            _gameStateManager.ResetToPreviousGameState();
        }
        
    }
}

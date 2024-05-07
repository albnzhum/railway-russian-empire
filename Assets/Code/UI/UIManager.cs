using System;
using Railway.Components;
using Railway.Events;
using Railway.Input;
using Railway.SceneManagement;
using Railway.Gameplay;
using Railway.Gameplay.UI;
using Railway.Shop.UI;
using UnityEngine;

namespace Railway.UI
{
    public class UIManager : MonoBehaviour
    {
        [Header("Scene UI")] [SerializeField] private UIPopup popupPanel;
        [SerializeField] private UIShop shopPanel;
        [SerializeField] private UISettingsController settingsScreen;
        [SerializeField] private UIHud _hud;
        [SerializeField] private UIPause pauseScreen;
        [SerializeField] private UIResources _uiResources;

        [Header("Gameplay")] [SerializeField] private GameStateSO _gameStateManager;
        [SerializeField] private MenuSceneSO _mainMenu;
        [SerializeField] private InputReader _inputReader;

        [Header("Listening on")] [SerializeField]
        private BoolEventChannelSO _onLocationLoadedEvent;

        [Header("Broadcasting on")] [SerializeField]
        private LoadEventChannelSO _loadMenuEvent = default;

        [SerializeField] private ItemEventChannel _useItemEvent = default;

        private void OnEnable()
        {
            _inputReader.OpenShopEvent += SetShopScreen;
            _inputReader.MenuPauseEvent += OpenUIPause;
            shopPanel.Closed += CloseShopScreen;

            _onLocationLoadedEvent.OnEventRaised += ShowUI;

            _hud.OpenShopEvent += SetShopScreen;
            _hud.OpenSettingsEvent += OpenUIPause;
        }

        private void OnDisable()
        {
            shopPanel.Closed -= CloseShopScreen;
            _hud.OpenShopEvent -= SetShopScreen;

            _onLocationLoadedEvent.OnEventRaised -= ShowUI;
            _inputReader.OpenShopEvent -= SetShopScreen;
            _inputReader.MenuPauseEvent -= OpenUIPause;
        }

        private void ShowUI(bool isLoading)
        {
            _uiResources.gameObject.SetActive(isLoading);
        }

        private void OpenUIPause()
        {
            Time.timeScale = 0;

            _inputReader.MenuPauseEvent -= OpenUIPause;

            pauseScreen.SettingsScreenOpened += OpenSettingsScreen;
            pauseScreen.BackToMainRequested += ShowBackToMainMenuConfirmationPopup;
            pauseScreen.Resumed += CloseUIPause;

            pauseScreen.gameObject.SetActive(true);

            _inputReader.EnableMenuInput();
            _gameStateManager.UpdateGameState(GameState.Pause);
        }

        private void CloseUIPause()
        {
            Time.timeScale = 1;

            _inputReader.MenuPauseEvent += OpenUIPause;

            pauseScreen.SettingsScreenOpened -= OpenSettingsScreen;
            pauseScreen.BackToMainRequested -= ShowBackToMainMenuConfirmationPopup;
            pauseScreen.Resumed -= CloseUIPause;

            pauseScreen.gameObject.SetActive(false);

            _gameStateManager.ResetToPreviousGameState();

            if (_gameStateManager.CurrentGameState == GameState.Gameplay)
            {
                _inputReader.EnableGameplayInput();
            }
        }

        private void OpenSettingsScreen()
        {
            settingsScreen.Closed += CloseSettingsScreen;

            pauseScreen.gameObject.SetActive(false);

            settingsScreen.gameObject.SetActive(true);
        }

        private void CloseSettingsScreen()
        {
            settingsScreen.Closed -= CloseSettingsScreen;

            pauseScreen.gameObject.SetActive(true);
            settingsScreen.gameObject.SetActive(false);
        }

        private void ShowBackToMainMenuConfirmationPopup()
        {
            pauseScreen.gameObject.SetActive(false);

            popupPanel.ClosePopupAction += HideBackToMainMenuConfirmationPopup;
            popupPanel.ConfirmationResponseAction += BackToMainMenu;

            _inputReader.EnableMenuInput();
            popupPanel.gameObject.SetActive(true);
            popupPanel.SetPopup(PopupType.BackToMenu);
        }

        private void HideBackToMainMenuConfirmationPopup()
        {
            popupPanel.ClosePopupAction -= HideBackToMainMenuConfirmationPopup;
            popupPanel.ConfirmationResponseAction -= BackToMainMenu;

            popupPanel.gameObject.SetActive(false);
            pauseScreen.gameObject.SetActive(true);
        }

        void BackToMainMenu(bool confirm)
        {
            HideBackToMainMenuConfirmationPopup();

            if (confirm)
            {
                CloseUIPause();
                _loadMenuEvent.RaiseEvent(_mainMenu, false);
            }
        }

        #region SHOP

        private void SetShopScreen()
        {
            if (_gameStateManager.CurrentGameState == GameState.Gameplay)
            {
                OpenShopScreen();
            }
        }

        private void OpenShopScreen()
        {
            _inputReader.MenuPauseEvent -= OpenUIPause;
            _inputReader.MenuUnpauseEvent -= CloseUIPause;

            _inputReader.MenuCloseEvent += CloseShopScreen;

            shopPanel.FillInventory();

            _inputReader.CloseShopEvent += CloseShopScreen;

            shopPanel.gameObject.SetActive(true);
            _inputReader.EnableMenuInput();

            _gameStateManager.UpdateGameState(GameState.Shop);
        }

        private void CloseShopScreen()
        {
            _inputReader.MenuPauseEvent += OpenUIPause;
            _inputReader.MenuCloseEvent -= CloseShopScreen;

            _inputReader.CloseShopEvent -= CloseShopScreen;
            shopPanel.gameObject.SetActive(false);

            if (shopPanel.IsItemBuying)
            {
                _gameStateManager.UpdateGameState(GameState.Edit);
                _useItemEvent.RaiseEvent(shopPanel.CurrentItem);
                _inputReader.EnableEditInput();
            }
            else
            {
                _gameStateManager.ResetToPreviousGameState();
            }

            if (_gameStateManager.CurrentGameState == GameState.Gameplay)
                _inputReader.EnableGameplayInput();
        }

        #endregion
    }
}
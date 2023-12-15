using System;
using System.Collections;
using Railway.Events;
using UnityEngine;

namespace Railway.UI
{
    public class UIMenuManager : MonoBehaviour
    {
        [SerializeField] private UIMainMenu _mainMenu = default;
        [SerializeField] private UIPopup _popupPanel = default;
        [SerializeField] private UISettingsController _settingsPanel;

        [Header("Broadcasting on")] [SerializeField]
        private VoidEventChannelSO _startNewGameEvent;

        [SerializeField] private VoidEventChannelSO _continueGameEvent;

        private bool _hasSaveData;

        private IEnumerator Start()
        {
            yield return new WaitForSeconds(0.4f);
            SetMenuScreen();
        }

        private void SetMenuScreen()
        {
            //_hasSaveData = _saveSystem.LoadSaveDataFromDisk();
            _mainMenu.SetMenuScreen(_hasSaveData);
            _mainMenu.ContinueButtonAction += _continueGameEvent.RaiseEvent;
            _mainMenu.NewGameButtonAction += ButtonStartNewGameClicked;
            _mainMenu.SettingsButtonAction += OpenSettingsScreen;
            _mainMenu.ExitButtonAction += ShowExitConfirmationPopup;
        }

        private void ButtonStartNewGameClicked()
        {
            if (!_hasSaveData)
            {
                ConfirmStartNewGame();
            }
            else
            {
                ShowStartNewGameConfirmationPopup();
            }
        }

        private void ConfirmStartNewGame()
        {
            _startNewGameEvent.RaiseEvent();
            Debug.Log("New Game Event");
        }

        private void ShowStartNewGameConfirmationPopup()
        {
            _popupPanel.ConfirmationResponseAction += StartNewGamePopupResponse;
            _popupPanel.ClosePopupAction += HidePopup;
            Debug.Log("PopupShowed");

            _popupPanel.gameObject.SetActive(true);
            _popupPanel.SetPopup(PopupType.NewGame);
        }

        private void StartNewGamePopupResponse(bool startNewGameConfirmed)
        {
            _popupPanel.ConfirmationResponseAction -= StartNewGamePopupResponse;
            _popupPanel.ClosePopupAction -= HidePopup;

            _popupPanel.gameObject.SetActive(false);

            if (startNewGameConfirmed)
            {
                ConfirmStartNewGame();
            }
            else
            {
                _continueGameEvent.RaiseEvent();
            }

            _mainMenu.SetMenuScreen(_hasSaveData);
        }

        private void HidePopup()
        {
            _popupPanel.ClosePopupAction -= HidePopup;
            _popupPanel.gameObject.SetActive(false);
            _mainMenu.SetMenuScreen(_hasSaveData);
        }

        public void OpenSettingsScreen()
        {
            _settingsPanel.gameObject.SetActive(true);
            _settingsPanel.Closed += CloseSettingsScreen;
        }

        public void CloseSettingsScreen()
        {
            _settingsPanel.Closed -= CloseSettingsScreen;
            _settingsPanel.gameObject.SetActive(false);
            _mainMenu.SetMenuScreen(_hasSaveData);
        }

        public void ShowExitConfirmationPopup()
        {
            _popupPanel.ConfirmationResponseAction += HideExitConfirmationPopup;
            _popupPanel.gameObject.SetActive(true);
            _popupPanel.SetPopup(PopupType.Quit);
        }
        
        void HideExitConfirmationPopup(bool quitConfirmed)
        {
            _popupPanel.ConfirmationResponseAction -= HideExitConfirmationPopup;
            _popupPanel.gameObject.SetActive(false);
            
            if (quitConfirmed)
            {
                Application.Quit();
            }
            
            _mainMenu.SetMenuScreen(_hasSaveData);
        }

        private void OnDestroy()
        {
            _popupPanel.ConfirmationResponseAction -= HideExitConfirmationPopup;
            _popupPanel.ConfirmationResponseAction -= StartNewGamePopupResponse;
        }
    }
}

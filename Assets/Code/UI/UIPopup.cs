using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Railway.UI
{
    public enum PopupButtonType
    {
        Confirm,
        Cancel,
        Close,
        DoNothing
    }

    public enum PopupType
    {
        Quit,
        NewGame,
        BackToMenu
    }

    public class UIPopup : MonoBehaviour
    {
        [SerializeField] private Button _buttonClose = default;
        [SerializeField] private Button _popupButton1 = default;
        [SerializeField] private Button _popupButton2 = default;

        private PopupType _actualType;

        public event UnityAction<bool> ConfirmationResponseAction;
        public event UnityAction ClosePopupAction;

        private void OnDisable()
        {
            _popupButton2.onClick.RemoveListener(CancelButtonClicked);
            _popupButton1.onClick.RemoveListener(ConfirmButtonClicked);
        }

        public void SetPopup(PopupType popupType)
        {
            _actualType = popupType;
            bool isConfirmation = false;
            bool hasExitButton = false;

            switch (_actualType)
            {
                case PopupType.NewGame:
                case PopupType.BackToMenu:
                    isConfirmation = true;
                    hasExitButton = true;
                    break;
                case PopupType.Quit:
                    isConfirmation = true;
                    hasExitButton = false;
                    break;
                default:
                    isConfirmation = false;
                    hasExitButton = false;
                    break;
            }

            if (isConfirmation) // needs two button : Is a decision 
            {
                _popupButton1.gameObject.SetActive(true);
                _popupButton2.gameObject.SetActive(true);

                _popupButton2.onClick.AddListener(CancelButtonClicked);
                _popupButton1.onClick.AddListener(ConfirmButtonClicked);
            }
            else // needs only one button : Is an information 
            {
                _popupButton1.gameObject.SetActive(true);
                _popupButton2.gameObject.SetActive(false);

                _popupButton1.onClick.AddListener(ConfirmButtonClicked);
            }

            _buttonClose.gameObject.SetActive(hasExitButton);
        }

        public void ClosePopupButtonClicked()
        {
            ClosePopupAction.Invoke();
        }

        private void ConfirmButtonClicked()
        {
            ConfirmationResponseAction.Invoke(true);
        }

        private void CancelButtonClicked()
        {
            ConfirmationResponseAction.Invoke(false);
        }
    }
}
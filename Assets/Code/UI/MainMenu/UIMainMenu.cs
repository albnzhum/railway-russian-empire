using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Railway.UI
{
    public class UIMainMenu : MonoBehaviour
    {
        [SerializeField] private Button _newGameButton;

        public UnityAction NewGameButtonAction;
        public UnityAction ContinueButtonAction;
        public UnityAction SettingsButtonAction;
        public UnityAction ExitButtonAction;

        public void SetMenuScreen(bool hasSaveData)
        {

                _newGameButton.Select();
            
        }

        public void NewGameButton()
        {
            NewGameButtonAction.Invoke();
        }

        public void ContinueButton()
        {
            ContinueButtonAction.Invoke();
        }

        public void SettingsButton()
        {
            SettingsButtonAction.Invoke();
        }

        public void ExitButton()
        {
            ExitButtonAction.Invoke();
        }
    }
}

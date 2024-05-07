using System;
using Railway.Events;
using Railway.Input;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Railway.UI
{
    public class UIPause : MonoBehaviour
    {
        [SerializeField] private InputReader inputReader;
        [SerializeField] private Button resumeButton;
        [SerializeField] private Button settingsButton;
        [SerializeField] private Button backToMenuButton;

        [Header("Listening to")] [SerializeField]
        private BoolEventChannelSO onPauseOpened;

        public event UnityAction Resumed;
        public event UnityAction SettingsScreenOpened;
        public event UnityAction BackToMainRequested;

        private void OnEnable()
        {
            onPauseOpened.RaiseEvent(true);

            // inputReader.MenuCloseEvent += Resume;
            resumeButton.onClick.AddListener(Resume);
            settingsButton.onClick.AddListener(OpenSettingsScreen);
            backToMenuButton.onClick.AddListener(BackToMainMenu);
        }

        private void OnDisable()
        {
            onPauseOpened.RaiseEvent(false);

            // inputReader.MenuCloseEvent -= Resume;
            resumeButton.onClick.RemoveListener(Resume);
            settingsButton.onClick.RemoveListener(OpenSettingsScreen);
            backToMenuButton.onClick.RemoveListener(BackToMainMenu);
        }

        private void Resume()
        {
            Resumed.Invoke();
        }

        private void OpenSettingsScreen()
        {
            SettingsScreenOpened.Invoke();
        }

        private void BackToMainMenu()
        {
            BackToMainRequested.Invoke();
        }

        public void CloseScreen()
        {
            Resumed.Invoke();
        }
    }
}
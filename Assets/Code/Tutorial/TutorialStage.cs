using System;
using UnityEngine;
using UnityEngine.UI;

namespace Railway.Tutorials
{
    public class TutorialStage : MonoBehaviour
    {
        [Header("UI elements")] 
        [SerializeField] private GameObject _tutorialWindow;

        [SerializeField] private Button _closeButton;

        private bool isCompleted;

        public bool IsCompleted => isCompleted;

        public event Action OnStageCompleted;

        public void Show()
        {
            _tutorialWindow.SetActive(true);
            _closeButton.onClick.AddListener(CompleteStage);
        }

        public void Close()
        {
            _tutorialWindow.SetActive(false);
            isCompleted = true;
        }

        private void CompleteStage()
        {
            _closeButton.onClick.RemoveListener(CompleteStage);
            OnStageCompleted?.Invoke();
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Railway.Events;
using Railway.Gameplay;
using Railway.Input;
using UnityEngine;
using UnityEngine.UI;

namespace Railway.Tutorials
{
    public class TutorialSystem : MonoBehaviour
    {
        [SerializeField] private List<TutorialStage> _tutorialStages;

        [SerializeField] private GameObject _tutorial;

        [Header("Gameplay")] 
        [SerializeField] private GameStateSO _gameState;
        [SerializeField] private BoolEventChannelSO _onLocationLoadedEvent;

        [SerializeField] private InputReader _inputReader;

        private int currentStageIndex = 0;
        private bool isCompleted;
        
        private void OnEnable()
        {
            _onLocationLoadedEvent.OnEventRaised += StartTutorial;
        }

        private void OnDisable()
        {
            _onLocationLoadedEvent.OnEventRaised -= StartTutorial;
        }

        public void SkipTutorial()
        {
            isCompleted = true;
            EndTutorial();
        }

        private void StartTutorial(bool show)
        {
            _tutorial.SetActive(show);

            _inputReader.EnableTutorialInput();
            _gameState.UpdateGameState(GameState.Tutorial);
            ShowCurrentStage();
        }

        private void EndTutorial()
        {
            _tutorial.SetActive(false);

            _inputReader.EnableGameplayInput();
            _gameState.UpdateGameState(GameState.Gameplay);
        }

        private void ShowCurrentStage()
        {
            if (currentStageIndex < _tutorialStages.Count)
            {
                _tutorialStages[currentStageIndex].Show();
                _tutorialStages[currentStageIndex].OnStageCompleted += OnCurrentStageCompleted;

                if (currentStageIndex > 0)
                {
                    _inputReader.IsGameplayInputEnabled = true;
                }
            }
            else
            {
                EndTutorial();
            }
        }

        private void OnCurrentStageCompleted()
        {
            _tutorialStages[currentStageIndex].OnStageCompleted -= OnCurrentStageCompleted;
            _tutorialStages[currentStageIndex].Close();
            currentStageIndex++;

            // Show the next stage
            ShowCurrentStage();
        }
    }
}
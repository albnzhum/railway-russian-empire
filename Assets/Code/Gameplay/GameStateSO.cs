using System;
using System.Collections.Generic;
using Railway.Events;
using Unity.Collections;
using UnityEngine;

namespace Railway.Gameplay
{
    [Serializable]
    public enum GameState
    {
        Gameplay,
        Pause,
        Edit,
        Tutorial,
        Shop,
        LocationTransition
    }

    [CreateAssetMenu(fileName = "GameState", menuName = "Gameplay/GameState")]
    public class GameStateSO : ScriptableObject
    {
        public GameState CurrentGameState => _currentGameState;

        [Header("Game states")] [SerializeField] [ReadOnly]
        private GameState _currentGameState;

        [SerializeField] [ReadOnly] private GameState _previousGameState;

        public void UpdateGameState(GameState newGameState)
        {
            if (newGameState == CurrentGameState) return;

            _previousGameState = _currentGameState;
            _currentGameState = newGameState;
        }

        public void ResetToPreviousGameState()
        {
            if (_previousGameState == _currentGameState) return;

            (_previousGameState, _currentGameState) = (_currentGameState, _previousGameState);
        }
    }
}
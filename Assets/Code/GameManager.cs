using System;
using Railway.Events;
using Railway.Gameplay;
using Railway.Input;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    [SerializeField] private GameSetupEventSO _gameSetupEventSo;
    [SerializeField] private GameStateSO _gameState;

    public InputReader _InputReader;

    private void OnEnable()
    {
        //_gameState.UpdateGameState(GameState.Gameplay);
    }
}

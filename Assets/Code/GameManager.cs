using System;
using Railway.Events;
using Railway.Input;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    [SerializeField] private GameSetupEventSO _gameSetupEventSo;

    public InputReader _InputReader;

    private void OnEnable()
    {
        
    }
}

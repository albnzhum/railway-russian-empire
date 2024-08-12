using Railway.Components;
using Railway.Gameplay;
using Railway.Input;
using UnityEngine;

namespace Railway.Morpeh
{
    public class GameInstaller 
    {
        [SerializeField] private MissionInitializer _missionInitializer;
        [SerializeField] private InputReader _inputReader;
        [SerializeField] private GameStateSO _gameState;
    }
}
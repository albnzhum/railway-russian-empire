using System;
using Railway.Components;
using Railway.Events;
using UnityEngine;
using UnityEngine.Serialization;

namespace Railway.Gameplay
{

    public class GameInitializer : MonoBehaviour
    {
        [Header("Game Setup")]
        [SerializeField] private MissionInitializer _mission;
        [SerializeField] private LevelDifficultySO _levelDifficulty;
        
        [Header("Listening To")]
        [SerializeField] private GameSetupEventSO _gameSetupEvent;
        [SerializeField] private ResourcesUpdateEventSO _resourcesUpdateEvent;
        [SerializeField] private VoidEventChannelSO _onSceneReady;

        private void OnEnable()
        {
            _gameSetupEvent.OnGameSetup += Setup;
            _onSceneReady.OnEventRaised += ShowUI;
        }

        private void OnDisable()
        {
            _gameSetupEvent.OnGameSetup -= Setup;
            _onSceneReady.OnEventRaised -= ShowUI;
        }

        private void ShowUI()
        {
            _resourcesUpdateEvent.RaiseEvent(_mission.resources);
        }

        private void Setup(MissionInitializer mission, LevelDifficulty levelDifficulty)
        {
            _mission = mission;
            _levelDifficulty._LevelDifficulty = levelDifficulty;
        }
    }

}
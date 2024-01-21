using System;
using Railway.Events;
using Railway.Gameplay;
using UnityEngine;

namespace Railway.GlobalData
{
    public class TimeSystem : MonoBehaviour
    {
        [SerializeField] private LevelDifficultySO _levelDifficulty;
        [SerializeField] private VoidEventChannelSO _onSceneReady;

        private void OnEnable()
        {
            _onSceneReady.OnEventRaised += SetTimeConfiguration;
        }

        private void OnDisable()
        {
            _onSceneReady.OnEventRaised -= SetTimeConfiguration; 
        }

        private void SetTimeConfiguration()
        {
            
        }
    }
}

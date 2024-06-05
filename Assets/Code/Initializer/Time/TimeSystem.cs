using System;
using Railway.Events;
using Railway.Gameplay;
using UnityEngine;
using Zenject;

namespace Railway.GlobalData
{
    public class TimeSystem : MonoBehaviour
    {
        [Inject] private GameStateSO _gameState;

        [SerializeField] private TimeComponent _time;

        private void Update()
        {
            if (_gameState.CurrentGameState == GameState.Gameplay)
            {
                _time.RealTimeElapsed += Time.deltaTime;
                if (_time.RealTimeElapsed >= _time.TimeToUpdate)
                {
                    _time.GameTime += 1;
                    _time.RealTimeElapsed = 0f;
                    Debug.Log(_time.GameTime);
                }
            }
        }
    }
}
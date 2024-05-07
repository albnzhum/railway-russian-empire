using System;
using UnityEngine;

namespace Railway.GlobalData
{
    [CreateAssetMenu(fileName = "New Time Component", menuName = "Global Data/Time Component")]
    public class TimeComponent : ScriptableObject
    {
        [SerializeField] private int _baseGameTime;
        [SerializeField] private float _realTimeElapsed;
        [SerializeField] private float _timeToUpdate;

        private int _gameTime;

        public int GameTime
        {
            get => _gameTime;
            set => _gameTime = value;
        }

        public float RealTimeElapsed
        {
            get => _realTimeElapsed;
            set => _realTimeElapsed = value;
        }

        public float TimeToUpdate => _timeToUpdate;

        private void OnEnable()
        {
            _gameTime = _baseGameTime;
        }
    }
}
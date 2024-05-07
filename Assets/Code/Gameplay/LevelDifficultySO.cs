using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

namespace Railway.Gameplay
{
    public enum LevelDifficulty
    {
        Easy,
        Medium,
        Hard
    }

    [CreateAssetMenu(fileName = "Level Difficulty", menuName = "Global Data/Level Difficulty")]
    public class LevelDifficultySO : ScriptableObject
    {
        [SerializeField] private LevelDifficulty _levelDifficulty;

        public LevelDifficulty LevelDifficulty
        {
            set => _levelDifficulty = value;
        }
    }
}
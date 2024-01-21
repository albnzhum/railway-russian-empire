using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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
        public LevelDifficulty _LevelDifficulty;
    }
}

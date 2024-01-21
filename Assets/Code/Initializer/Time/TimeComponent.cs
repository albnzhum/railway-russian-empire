
using UnityEngine;

namespace Railway.GlobalData
{
    [CreateAssetMenu(fileName = "New Time Component", menuName = "Global Data/Time Component")]
    public class TimeComponent : ScriptableObject
    {
        public int GameTime;
        public float RealTimeElapsed;
        public float TimeToUpdate;
    }
}
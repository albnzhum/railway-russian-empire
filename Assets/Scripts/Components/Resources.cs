using UnityEngine;

namespace Components
{
    [CreateAssetMenu(fileName = "Resources", menuName = "GameData/Resources")]
    public class Resources : ScriptableObject
    {
        public int Workers;
        public int Money;
        public float Food;
        public int Church;
        public int SpeedBuilding;
    }
}

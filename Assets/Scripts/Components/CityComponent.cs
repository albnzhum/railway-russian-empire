using UnityEngine;

namespace Components
{
    [CreateAssetMenu(fileName = "City", menuName = "GameData/City")]

    public class CityComponent : ScriptableObject
    {
        public string Name;
        public int Population;
        public Resources Resources;
    }
}

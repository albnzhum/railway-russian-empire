using System;
using UnityEngine;
using Zenject;

namespace Components
{
    [CreateAssetMenu(fileName = "CityComponent", menuName = "Components/CityComponent")]
    public class CityComponent : ScriptableObject
    {
        public string Name;
        public int Population;
        public Resources Resources;
    }
}

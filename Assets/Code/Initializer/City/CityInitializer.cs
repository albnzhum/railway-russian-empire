using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Railway.Components
{
    [CreateAssetMenu(fileName = "New City Initializer", menuName = "Initializer/City Initializer")]
    public class CityInitializer : ScriptableObject
    {
        public string Name;
        public int Population;
    }
}

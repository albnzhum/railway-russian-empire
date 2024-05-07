using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Railway.Components
{
    [CreateAssetMenu(fileName = "New City Initializer", menuName = "Initializer/City Initializer")]
    public class CityInitializer : ScriptableObject
    {
        [SerializeField] private string _name;
        [SerializeField] private int _population;

        public string Name => _name;

        public int Population
        {
            get => _population;
            set => _population = value;
        }
    }
}
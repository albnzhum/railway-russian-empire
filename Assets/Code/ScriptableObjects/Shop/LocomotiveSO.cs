using System;
using UnityEngine;

namespace Railway.Shop.Data
{
    [Serializable]
    public enum Country
    {
        Russia,
        England,
        France
    }

    [Serializable]
    public enum Factory
    {
        SomeFactory1,
        SomeFactory2
    }

    [Serializable]
    public enum TechnicalState
    {
        New,
        Excellent,
        Good,
        Medium,
        Used,
        Old,
        Critical,
        Faulty
    }
    
    [CreateAssetMenu(fileName = "New Locomotive Item", menuName = "Shop Data/Locomotive")]
    public class LocomotiveSO : ShopItem
    {
        [Header("Metrics")]
        public Country Country;
        public Factory Factory;
        public int LifeSpan;
        public int Power;
        public TechnicalState TechnicalState;

        [Header("General")] 
        public int MonthsBeforeMaintenance;

    }
}

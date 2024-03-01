using UnityEngine;

namespace Railway.Shop.Data
{
    [CreateAssetMenu(fileName = "New Locomotive Item", menuName = "Shop Data/Locomotive")]
    public class LocomotiveSO : ShopItem
    {
        [Header("Metrics")]
        private Country _country;
        private Factory _factory;
        private int _lifeSpan;
        private int _power;
        private TechnicalState _technicalState;

        [Header("General")] 
        private int _monthsBeforeMaintenance;
        
        public Country Country => _country;
        public Factory _Factory => _factory;
        public int LifeSpan => _lifeSpan;
        public int Power => _power;
        public TechnicalState TechnicalState => _technicalState;

        public int MonthsBeforeMaintenance => _monthsBeforeMaintenance;

    }
}

using UnityEngine;

namespace Railway.Shop.Data
{
    [CreateAssetMenu(fileName = "New Locomotive Item", menuName = "Shop Data/Locomotive")]
    public class LocomotiveSO : ShopItem
    {
        [Header("Metrics")] [SerializeField] private Country _country;
        [SerializeField] private Factory _factory;
        [SerializeField] private int _lifeSpan;
        [SerializeField] private int _power;
        [SerializeField] private TechnicalState _technicalState;

        [Header("General")] [SerializeField] private int _monthsBeforeMaintenance;

        public Country Country => _country;
        public Factory _Factory => _factory;
        public int LifeSpan => _lifeSpan;
        public int Power => _power;
        public TechnicalState TechnicalState => _technicalState;

        public int MonthsBeforeMaintenance => _monthsBeforeMaintenance;
    }
}
using System;
using UnityEngine;

namespace Railway.Shop.Data
{
    [Serializable]
    public enum WorkerType
    {
        Land,
        Water,
        Complex
    }
    
    [CreateAssetMenu(fileName = "New Worker Item", menuName = "Shop Data/Worker")]
    public class WorkerSO : ShopItem
    {
        public int Count;
        public float Salary;
        public float Provision;
        public float Satisfication;
        public float SpeedBuilding;
        public WorkerType WorkerType;
    }
}

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
        [SerializeField] private int _count;
        [SerializeField] private float _salary;
        [SerializeField] private float _provision;
        [SerializeField] private float _satisfication;
        [SerializeField] private float _speedBuilding;
        [SerializeField] private WorkerType _workerType;

        public int Count => _count;
        public float Salary => _salary;
        public float Provision => _provision;
        public float Satisfication => _satisfication;
        public float SpeedBuilding => _speedBuilding;
        public WorkerType WorkerType => _workerType;
    }
}

using System;
using R3;
using UnityEngine;
using UnityEngine.Serialization;

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
        [SerializeField] private SerializableReactiveProperty<int> _count;
        [SerializeField] private SerializableReactiveProperty<float> _salary;
        [SerializeField] private SerializableReactiveProperty<float> _provision;
        [SerializeField] private SerializableReactiveProperty<float> _satisfaction;
        [SerializeField] private SerializableReactiveProperty<float> _speedBuilding;
        [SerializeField] private WorkerType _workerType;

        public SerializableReactiveProperty<int> Count => _count;
        public SerializableReactiveProperty<float> Salary => _salary;
        public SerializableReactiveProperty<float> Provision => _provision;
        public SerializableReactiveProperty<float> Satisfaction => _satisfaction;
        public SerializableReactiveProperty<float> SpeedBuilding => _speedBuilding;
        public WorkerType WorkerType => _workerType;
    }
}
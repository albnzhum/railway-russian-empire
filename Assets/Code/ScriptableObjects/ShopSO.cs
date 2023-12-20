using System.Collections;
using System.Collections.Generic;
using Railway.Shop.Data;
using UnityEngine;

namespace Railway.Shop
{
    [CreateAssetMenu(fileName = "New Shop", menuName = "Shop Data/Shop")]
    public class ShopSO : ScriptableObject
    {
        [SerializeField] private List<WorkerSO> Workers;
        [SerializeField] private List<LocomotiveSO> Locomotives;
        [SerializeField] private List<RailsSO> Rails;
        [SerializeField] private List<CarriageSO> Carriages;
    }
}

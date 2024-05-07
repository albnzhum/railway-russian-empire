using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Railway.Shop.Data
{
    public enum ShopTabType
    {
        Construction,
        Railway,
        Workers
    }

    [CreateAssetMenu(fileName = "Shop Tab Type", menuName = "Shop Data/Shop Tab Type")]
    public class ShopTabSO : ScriptableObject
    {
        [SerializeField] private ShopTabType _tabType = default;

        public ShopTabType TabType => _tabType;
    }
}
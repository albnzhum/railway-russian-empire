using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Railway.Shop.Data
{
    [CreateAssetMenu(fileName = "Shop Tab Type", menuName = "Shop Data/Shop Tab Type")]
    public class ShopTabSO : ScriptableObject
    {
        [SerializeField] private ItemType _tabType = default;

        public ItemType TabType => _tabType;
    }
}

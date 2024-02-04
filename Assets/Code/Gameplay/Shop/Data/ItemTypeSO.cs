using System;
using UnityEngine;

namespace Railway.Shop.Data
{
    [Serializable]
    public enum ItemType
    {
        Workers,
        Rails,
        Locomotive,
        Carriage
    }
    
    [CreateAssetMenu(fileName = "ItemType", menuName = "Shop Data/Item Type")]
    public class ItemTypeSO : ScriptableObject
    {
        [SerializeField] private ShopTabSO _tabType;

        public ShopTabSO TabType => _tabType;
    }

}
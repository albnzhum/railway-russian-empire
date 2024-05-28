using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace Railway.Shop.Data
{
    [Serializable]
    public enum ItemType
    {
        Workers,
        Rails,
        Locomotive,
        Carriage,
        Building
    }

    [CreateAssetMenu(fileName = "ItemType", menuName = "Shop Data/Item Type")]
    public class ItemTypeSO : ScriptableObject
    {
        [SerializeField] private ShopTabSO _tabType;
        [SerializeField] private ItemType type;

        public ShopTabSO TabType => _tabType;
        public ItemType Type => type;
    }
}
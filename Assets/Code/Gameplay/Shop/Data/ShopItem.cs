using System;
using System.Collections;
using System.Collections.Generic;
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
    
    public class ShopItem : ScriptableObject
    {
        public string Name;
        public float Price;
        public GameObject Prefab;
        [SerializeField] private ItemType _itemType;
        
        public ItemType ItemType => _itemType;
    }
}

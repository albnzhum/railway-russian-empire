using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Railway.Shop.Data
{
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
        public ItemType ItemType;
    }
}

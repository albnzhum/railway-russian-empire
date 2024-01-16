using System.Collections;
using System.Collections.Generic;
using Railway.Gameplay.Shop;
using Railway.Shop.Data;
using UnityEngine;

namespace Railway.Shop.Data
{
    [CreateAssetMenu(fileName = "New Shop", menuName = "Shop Data/Shop")]
    public class ShopSO : ScriptableObject
    {
        [SerializeField] private List<ShopItemStack> _items = new List<ShopItemStack>();
        [SerializeField] private List<ShopItemStack> _defaultItems = new List<ShopItemStack>();
        
        public List<ShopItemStack> Items => _items;
        
        public void Init()
        {
            if (_items == null)
            {
                _items = new List<ShopItemStack>();
            }
            _items.Clear();
            foreach (ShopItemStack item in _defaultItems)
            {
                _items.Add(new ShopItemStack(item));
            }
        }
        

        public bool Contains(ShopItem item)
        {
            for (int i = 0; i < _items.Count; i++)
            {
                if (item == _items[i].Item)
                {
                    return true;
                }
            }

            return false;
        }
        
    }
}

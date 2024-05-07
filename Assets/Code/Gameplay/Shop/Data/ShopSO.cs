using System.Collections.Generic;
using UnityEngine;

namespace Railway.Shop.Data
{
    /// <summary>
    /// Contains list of items
    /// </summary>
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

        public void Add(ShopItem item, int count = 1)
        {
            if (count <= 0) return;

            _items.Add(new ShopItemStack(item));
        }

        public void Remove(ShopItem item, int count = 1)
        {
            if (count <= 0) return;

            for (int i = 0; i < _items.Count; i++)
            {
                ShopItemStack currentItemStack = _items[i];

                if (currentItemStack.Item == item)
                {
                    _items.Remove(currentItemStack);

                    return;
                }
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
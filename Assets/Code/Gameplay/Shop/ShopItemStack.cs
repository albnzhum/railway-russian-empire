using System;
using Railway.Shop.Data;
using UnityEngine;

namespace Railway.Gameplay.Shop
{
    [Serializable]
    public class ShopItemStack
    {
        [SerializeField] private ShopItem _item;

        public ShopItem Item => _item;

        public ShopItemStack()
        {
            _item = null;
        }

        public ShopItemStack(ShopItemStack itemStack)
        {
            _item = itemStack.Item;
        }

        public ShopItemStack(ShopItem item)
        {
            _item = item;
        }

    }
}

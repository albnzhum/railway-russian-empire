using System;
using System.Collections;
using System.Collections.Generic;
using Railway.Events;
using Railway.Shop;
using UnityEngine;

namespace Railway.Gameplay.Shop.UI
{
    public class UIShop : MonoBehaviour
    {
        [SerializeField] private ShopSO _shop;
        [SerializeField] private UIShopItem _itemPrefab;
        [SerializeField] private GameObject _contentParent;

        [Header("Listening to")] 
        [SerializeField] private VoidEventChannelSO _onInteractionEndedEvent;

        private void OnEnable()
        {
            
        }
    }
}

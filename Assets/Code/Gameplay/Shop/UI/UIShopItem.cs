using System;
using Railway.Shop.Data;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Railway.Shop.UI
{
    public class UIShopItem : MonoBehaviour
    {
        [SerializeField] private Text _itemName = default;
        [SerializeField] private Text _itemPrice = default;
        [SerializeField] private Image _bgImage = default;
        [SerializeField] private Button _itemButton = default;

        public UnityAction<ShopItem> ItemSelected;

        [HideInInspector] public ShopItemStack currentItem;

        private bool _isSelected = false;
        
        private void OnEnable()
        {
            if (_isSelected)
            {
                SelectItem();
            }
        }

        public void SetItem(ShopItemStack itemStack, bool isSelected)
        {
            _isSelected = isSelected;
            
            SetItemVisibility(true);

            currentItem = itemStack;

            _itemName.text = itemStack.Item.Name;
            _itemPrice.text = itemStack.Item.Price.ToString();
        }

        public void SetInactiveItem()
        {
            currentItem = null;

            SetItemVisibility(false);
        }

        private void SetItemVisibility(bool active)
        {
            _itemName.gameObject.SetActive(active);
            _itemPrice.gameObject.SetActive(active);
            _bgImage.gameObject.SetActive(active);
            _itemButton.gameObject.SetActive(active);
        }

        private void SelectItem()
        {
            _isSelected = true;

            if (ItemSelected != null && currentItem != null && currentItem.Item)
            {
                ItemSelected.Invoke(currentItem.Item);
            }
        }

        public void UnselectItem()
        {
            _isSelected = false;
        }
    }
}
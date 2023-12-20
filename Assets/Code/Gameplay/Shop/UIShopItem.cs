using System;
using Railway.Shop.Data;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Railway.Gameplay.Shop.UI
{
    public class UIShopItem : MonoBehaviour
    {
        [SerializeField] private Text _itemName = default;
        [SerializeField] private Text _itemPrice = default;
        [SerializeField] private Image _bgImage = default;
        [SerializeField] private Image _bgInactiveImage = default;
        [SerializeField] private Button _itemButton = default;
        
        public UnityAction<ShopItem> ItemSelected;

        [HideInInspector] private ShopItemStack currentItem;

        private bool _isSelected = false;

        public void SetItem(ShopItemStack itemStack, bool isSelected)
        {
            _isSelected = isSelected;
            _bgImage.gameObject.SetActive(true);
            _itemButton.gameObject.SetActive(true);
            _bgInactiveImage.gameObject.SetActive(false);

            currentItem = itemStack;

            _itemName.text = itemStack.Item.Name;
            _itemPrice.text = itemStack.Item.Price.ToString();
        }

        public void SetInactiveItem()
        {
            currentItem = null;
            _bgImage.gameObject.SetActive(false);
            _itemButton.gameObject.SetActive(false);
            _bgInactiveImage.gameObject.SetActive(true);
        }

        private void OnEnable()
        {
            if (_isSelected)
            {
                SelectItem();
            }
        }

        public void SelectItem()
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
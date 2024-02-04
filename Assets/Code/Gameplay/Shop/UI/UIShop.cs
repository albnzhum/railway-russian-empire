using System;
using System.Collections.Generic;
using Railway.Events;
using Railway.Input;
using Railway.Shop.Data;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Shop.UI
{
    public class UIShop : MonoBehaviour
    {
        public UnityAction Closed;

        [SerializeField] private ShopSO _shop;
        [SerializeField] private UIShopItem _itemPrefab;
        [SerializeField] private GameObject _contentParent;
        [SerializeField] private List<ShopTabSO> _tabTypesList = new List<ShopTabSO>();
        [SerializeField] private List<UIShopItem> _availableItemSlots = default;

        [Header("Gameplay")] 
        [SerializeField] private InputReader _inputReader;

        [Header("Listening to")] 
        [SerializeField] private UIShopTabs _tabsPanel = default;

        [SerializeField] private VoidEventChannelSO _onInteractionEndedEvent = default;

        [Header("Broadcasting on")] 
        [SerializeField] private ItemEventChannel _useItemEvent = default;

        private ShopTabSO _selectedTab = default;
        private int selectedItemId = -1;

        private void OnEnable()
        {
            _tabsPanel.TabChanged += OnChangeTab;

            for (int i = 0; i < _availableItemSlots.Count; i++)
            {
                _availableItemSlots[i].ItemSelected += InspectItem;
            }

            _inputReader.TabSwitched += OnSwitchTab;
        }

        private void OnDisable()
        {
            _tabsPanel.TabChanged -= OnChangeTab;

            for (int i = 0; i < _availableItemSlots.Count; i++)
            {
                _availableItemSlots[i].ItemSelected -= InspectItem;
            }
            
            _inputReader.TabSwitched -= OnSwitchTab;
        }

        private void OnSwitchTab(float orientation)
        {
            if (orientation != 0)
            {
                bool isLeft = orientation < 0;
                int initialIndex = _tabTypesList.FindIndex(o => o == _selectedTab);
                if (initialIndex != -1)
                {
                    if (isLeft)
                    {
                        initialIndex--;
                    }
                    else
                    {
                        initialIndex++;
                    }

                    initialIndex = Mathf.Clamp(initialIndex, 0, _tabTypesList.Count - 1);
                }

                OnChangeTab(_tabTypesList[initialIndex]);
            }
        }

        public void FillInventory(ItemType _selectedType = ItemType.Workers)
        {
            _selectedTab = _tabTypesList.Find(o => o.TabType == _selectedType) ?? _tabTypesList[0];

            if (_selectedTab != null)
            {
                SetTabs(_tabTypesList, _selectedTab);
                List<ShopItemStack> listItemsToShow = new List<ShopItemStack>();
                listItemsToShow = _shop.Items.FindAll(o => o.Item.ItemType.TabType == _selectedTab);

                FillShopItems(listItemsToShow);
            }
            else
            {
                Debug.LogError("There's no selected tab");
            }
        }

        private void SetTabs(List<ShopTabSO> typesList, ShopTabSO selectedType)
        {
            _tabsPanel.SetTabs(typesList, selectedType);
        }

        private void FillShopItems(List<ShopItemStack> listItemsToShow)
        {
            if (_availableItemSlots == null)
                _availableItemSlots = new List<UIShopItem>();

            int maxCount = Mathf.Max(listItemsToShow.Count, _availableItemSlots.Count);

            for (int i = 0; i < maxCount; i++)
            {
                if (i < listItemsToShow.Count)
                {
                    bool isSelected = selectedItemId == i;
                    _availableItemSlots[i].SetItem(listItemsToShow[i], isSelected);
                }
                else if (i < _availableItemSlots.Count)
                {
                    _availableItemSlots[i].SetInactiveItem();
                }
            }

            if (selectedItemId >= 0)
            {
                selectedItemId = -1;
            }
        }

        private void UpdateItemInInventory(ShopItemStack itemToUpdate, bool removeItem)
        {
            if (_availableItemSlots == null)
            {
                _availableItemSlots = new List<UIShopItem>();
            }

            if (removeItem)
            {
                if (_availableItemSlots.Exists(o => o.currentItem == itemToUpdate))
                {
                    int index = _availableItemSlots.FindIndex(o => o.currentItem == itemToUpdate);
                    _availableItemSlots[index].SetInactiveItem();
                }
            }
            else
            {
                int index = 0;
                if (_availableItemSlots.Exists(o => o.currentItem == itemToUpdate))
                {
                    index = _availableItemSlots.FindIndex(o => o.currentItem == itemToUpdate);
                }
                else
                {
                    if (_shop.Items.Count > _availableItemSlots.Count)
                    {
                        UIShopItem instantiatedPrefab =
                            Instantiate(_itemPrefab, _contentParent.transform) as UIShopItem;
                        _availableItemSlots.Add(instantiatedPrefab);
                    }

                    //find the last instantiated game object not used
                    index = _shop.Items.Count;
                }

                bool isSelected = selectedItemId == index;
                _availableItemSlots[index].SetItem(itemToUpdate, isSelected);
            }
        }

        public void InspectItem(ShopItem itemToInspect)
        {
            if (_availableItemSlots.Exists(o => o.currentItem.Item == itemToInspect))
            {
                int itemIndex = _availableItemSlots.FindIndex(o => o.currentItem.Item == itemToInspect);

                if (selectedItemId >= 0 && selectedItemId != itemIndex)
                    selectedItemId = itemIndex;

                bool isInteractable = true;
            }
        }

        void UpdateInventory()
        {
            FillInventory(_selectedTab.TabType);
        }

        void OnChangeTab(ShopTabSO tabType)
        {
            FillInventory(tabType.TabType);
        }

        public void CloseInventory()
        {
            Closed.Invoke();
        }
    }
}
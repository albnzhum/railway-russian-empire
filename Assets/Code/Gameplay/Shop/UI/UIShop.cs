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
        [SerializeField] private List<ShopTabSO> tabTypesList = new List<ShopTabSO>();
        [SerializeField] private List<UIShopItem> availableItemSlots = default;

        [SerializeField] private InputReader _inputReader;

        [Header("Listening to")] [SerializeField]
        private UIShopTabs _tabsPanel = default;

        private ShopTabSO _selectedTab = default;
        private int selectedItemId = -1;

        private bool isItemBuying = false;

        public bool IsItemBuying
        {
            get => isItemBuying;
            private set => isItemBuying = value;
        }

        private ShopItem _currentItem = default;
        public ShopItem CurrentItem => _currentItem;

        private void OnEnable()
        {
            _tabsPanel.TabChanged += OnChangeTab;

            for (int i = 0; i < availableItemSlots.Count; i++)
            {
                availableItemSlots[i].ItemSelected += InspectItem;
            }

            _inputReader.TabSwitched += OnSwitchTab;
        }

        private void OnDisable()
        {
            _tabsPanel.TabChanged -= OnChangeTab;

            for (int i = 0; i < availableItemSlots.Count; i++)
            {
                availableItemSlots[i].ItemSelected -= InspectItem;
            }

            _inputReader.TabSwitched -= OnSwitchTab;
        }

        private void OnSwitchTab(float orientation)
        {
            if (orientation != 0)
            {
                bool isLeft = orientation < 0;
                int initialIndex = tabTypesList.FindIndex(o => o == _selectedTab);
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

                    initialIndex = Mathf.Clamp(initialIndex, 0, tabTypesList.Count - 1);
                }

                OnChangeTab(tabTypesList[initialIndex]);
            }
        }

        public void FillInventory(ShopTabType _selectedType = ShopTabType.Workers)
        {
            _selectedTab = tabTypesList.Find(o => o.TabType == _selectedType) ?? tabTypesList[0];

            if (_selectedTab != null)
            {
                SetTabs(tabTypesList, _selectedTab);
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
            if (availableItemSlots == null)
                availableItemSlots = new List<UIShopItem>();

            int maxCount = Mathf.Max(listItemsToShow.Count, availableItemSlots.Count);

            for (int i = 0; i < maxCount; i++)
            {
                if (i < listItemsToShow.Count)
                {
                    bool isSelected = selectedItemId == i;
                    availableItemSlots[i].SetItem(listItemsToShow[i], isSelected);
                }
                else if (i < availableItemSlots.Count)
                {
                    availableItemSlots[i].SetInactiveItem();
                }
            }

            if (selectedItemId >= 0)
            {
                selectedItemId = -1;
            }
        }

        private void InspectItem(ShopItem itemToInspect)
        {
            if (availableItemSlots.Exists(o => o.currentItem.Item == itemToInspect))
            {
                int itemIndex = availableItemSlots.FindIndex(o => o.currentItem.Item == itemToInspect);

                if (selectedItemId >= 0 && selectedItemId != itemIndex)
                    UnselectItem(selectedItemId);
                selectedItemId = itemIndex;

                BuyItem(itemToInspect);
            }
        }

        private void BuyItem(ShopItem itemToBuy)
        {
            if (itemToBuy != null)
            {
                isItemBuying = true;
                _currentItem = itemToBuy;

                CloseInventory();
            }
            else
            {
                Debug.LogError("Item to buy is null!");
            }
        }

        private void UnselectItem(int itemIndex)
        {
            if (availableItemSlots.Count > itemIndex)
            {
                availableItemSlots[itemIndex].UnselectItem();
            }
        }

        void OnChangeTab(ShopTabSO tabType)
        {
            FillInventory(tabType.TabType);
        }

        public void CloseInventory()
        {
            Closed.Invoke();

            _currentItem = null;
            isItemBuying = false;
        }
    }
}
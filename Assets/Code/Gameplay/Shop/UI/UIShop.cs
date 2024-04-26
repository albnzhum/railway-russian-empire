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

        private ShopTabSO _selectedTab = default;
        private int selectedItemId = -1;

        private bool isItemBuying = false;
        public bool IsItemBuying { get => isItemBuying; private set => isItemBuying = value; }

        private ShopItem _currentItem = default;
        public ShopItem CurrentItem => _currentItem;
        
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

        public void FillInventory(ShopTabType _selectedType = ShopTabType.Workers)
        {
            _selectedTab = _tabTypesList.Find(o => o.TabType == _selectedType) ?? _tabTypesList[0];

            if (_selectedTab != null)
            {
                SetTabs(_tabTypesList, _selectedTab);
                List<ShopItemStack> listItemsToShow = new List<ShopItemStack>();
                listItemsToShow = _shop.Items.FindAll(o => o.Item.TabType.TabType == _selectedTab);

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

                    index = _shop.Items.Count;
                }

                bool isSelected = selectedItemId == index;
                _availableItemSlots[index].SetItem(itemToUpdate, isSelected);
            }
        }

        private void InspectItem(ShopItem itemToInspect)
        {
            if (_availableItemSlots.Exists(o => o.currentItem.Item == itemToInspect))
            {
                int itemIndex = _availableItemSlots.FindIndex(o => o.currentItem.Item == itemToInspect);

                if (selectedItemId >= 0 && selectedItemId != itemIndex)
                    UnselectItem(selectedItemId);
                selectedItemId = itemIndex;

                BuyItem(itemToInspect);
                
                Debug.Log(selectedItemId);
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
            if (_availableItemSlots.Count > itemIndex)
            {
                _availableItemSlots[itemIndex].UnselectItem();
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
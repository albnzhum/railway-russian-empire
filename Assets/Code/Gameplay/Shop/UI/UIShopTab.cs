using Railway.Shop.Data;
using Unity.Collections;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Railway.Shop.UI
{
    public class UIShopTab : MonoBehaviour
    {
        public UnityAction<ShopTabSO> TabClicked;

        [SerializeField] private Button _actionButton;

        [ReadOnly] public ShopTabSO _currentTabType = default;

        public void SetTab(ShopTabSO tabType, bool isSelected)
        {
            _currentTabType = tabType;
            UpdateState(isSelected);
        }

        public void UpdateState(bool isSelected)
        {
            _actionButton.interactable = !isSelected;
        }

        public void ClickButton()
        {
            TabClicked.Invoke(_currentTabType);
        }
    }
}
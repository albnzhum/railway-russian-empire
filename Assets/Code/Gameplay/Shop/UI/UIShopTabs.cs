using System;
using System.Collections;
using System.Collections.Generic;
using Railway.Shop.Data;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Railway.Shop.UI
{
    public class UIShopTabs : MonoBehaviour
    {
        [SerializeField] private List<UIShopTab> _instantiatedGO;
        public event UnityAction<ShopTabSO> TabChanged;

        private void OnDisable()
        {
            foreach (UIShopTab t in _instantiatedGO)
            {
                t.TabClicked -= ChangeTab;
            }
        }

        public void SetTabs(List<ShopTabSO> typesList, ShopTabSO selectedType)
        {
            if (_instantiatedGO == null)
                _instantiatedGO = new List<UIShopTab>();

            int maxCount = Mathf.Max(typesList.Count, _instantiatedGO.Count);

            for (int i = 0; i < maxCount; i++)
            {
                if (i < typesList.Count)
                {
                    if (i >= _instantiatedGO.Count)
                    {
                        Debug.LogError("Maximum tabs reached");
                    }

                    bool isSelected = typesList[i] == selectedType;

                    _instantiatedGO[i].SetTab(typesList[i], isSelected);
                    _instantiatedGO[i].gameObject.SetActive(true);
                    _instantiatedGO[i].TabClicked += ChangeTab;
                }
                else if (i < _instantiatedGO.Count)
                {
                    _instantiatedGO[i].gameObject.SetActive(false);
                }
            }
        }

        private void ChangeTab(ShopTabSO newTabType)
        {
            TabChanged.Invoke(newTabType);
        }
    }
}
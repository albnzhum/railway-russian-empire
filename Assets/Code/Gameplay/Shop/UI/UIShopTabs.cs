using System;
using System.Collections;
using System.Collections.Generic;
using Railway.Shop.Data;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Railway.Gameplay.Shop.UI
{
    public class UIShopTabs : MonoBehaviour
    {
        [SerializeField] private List<UIShopTab> _instantiatedGO;

        public event UnityAction<ShopTabSO> TabChanged;

        private bool _canDisableLayout = false;

        private void OnEnable()
        {
            if ((gameObject.GetComponent<VerticalLayoutGroup>() != null) && _canDisableLayout)
            {
                gameObject.GetComponent<VerticalLayoutGroup>().enabled = false;
                _canDisableLayout = false;
            }
        }

        private void OnDisable()
        {
            for (int i = 0; i < _instantiatedGO.Count; i++)
            {
                _instantiatedGO[i].TabClicked -= ChangeTab;
            }
        }

        public void SetTabs(List<ShopTabSO> typesList, ShopTabSO selectedType)
        {
            if (_instantiatedGO == null)
                _instantiatedGO = new List<UIShopTab>();

            if (gameObject.GetComponent<VerticalLayoutGroup>() != null)
                gameObject.GetComponent<VerticalLayoutGroup>().enabled = true;

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

            if (isActiveAndEnabled)
            {
                StartCoroutine(WaitBeforeDesactiveLayout());
            }
            else
            {
                _canDisableLayout = true;
            }
        }

        IEnumerator WaitBeforeDesactiveLayout()
        {
            yield return new WaitForSeconds(1);

            if (gameObject.GetComponent<VerticalLayoutGroup>() != null)
            {
                gameObject.GetComponent<VerticalLayoutGroup>().enabled = false;
                _canDisableLayout = false;
            }
        }

        public void ChangeTabSelection(ShopTabSO selectedType)
        {
            
        }

        private void ChangeTab(ShopTabSO newTabType)
        {
            Debug.Log("Tab clicked");
            TabChanged.Invoke(newTabType);
            
        }
    }
}

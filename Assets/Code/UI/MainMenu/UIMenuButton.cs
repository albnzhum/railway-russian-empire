using System;
using UnityEngine;
using UnityEngine.EventSystems;
using DG.Tweening;
using R3;
using TMPro;
using UnityEngine.UI;

namespace Railway.UI.Menu
{
    public class UIMenuButton : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler
    {
        [SerializeField] private GameObject _imageGO;

        private Color defaultColor;
        private Image _image;

        private void OnEnable()
        {
            defaultColor = GetComponentInChildren<TMP_Text>().color;
            _image = _imageGO.GetComponent<Image>();
        }

        public void OnPointerEnter(PointerEventData eventData)
        {
            _imageGO.SetActive(true);
            GetComponentInChildren<TMP_Text>().DOColor(Color.white, .5f);
        }

        public void OnPointerExit(PointerEventData eventData)
        {
            _imageGO.SetActive(false);
            GetComponentInChildren<TMP_Text>().DOColor(defaultColor, .5f);
        }
    }
}
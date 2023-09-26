using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

namespace UI
{
    /// <summary>
    /// Class for changing main menu text state while hovering
    /// </summary>
    public class MainMenuTextState : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler
    {
        [SerializeField] private GameObject image;
        private TMP_Text _text;
        private bool isHovering;

        private void Awake()
        {
            _text = GetComponent<TMP_Text>();
        }
        
        public void OnPointerExit(PointerEventData eventData)
        {
            isHovering = false;
            //_text.color = new Color(192, 192, 192, 255);
            image.SetActive(false);
        }

        public void OnPointerEnter(PointerEventData eventData)
        {
            isHovering = true;
            _text.color = Color.black;
            image.SetActive(true);
        }

        private void Update()
        {
            if (!isHovering)
            {
                _text.color = new Color(192, 192, 192, 255);
            }
        }
    }
}

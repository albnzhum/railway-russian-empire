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
        private Animator textHover;
        private bool isHovering;
        private static readonly int IsHovering = Animator.StringToHash("IsHovering");

        private void Awake()
        {
            _text = GetComponentInChildren<TMP_Text>();
            textHover = GetComponentInChildren<Animator>();
        }
        
        public void OnPointerExit(PointerEventData eventData)
        {
            isHovering = false;
            textHover.SetBool(IsHovering, isHovering);
            image.SetActive(false);
        }

        public void OnPointerEnter(PointerEventData eventData)
        {
            isHovering = true;
            textHover.SetBool(IsHovering, isHovering);
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

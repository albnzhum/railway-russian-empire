using System;
using Observers;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace UI
{
    /// <summary>
    /// Class for changing main menu text state while hovering
    /// </summary>
    public class HoverTextVisual : MonoBehaviour
    {
        [SerializeField] private PointerObserver pointerObserver;
        private Animator _textHover;
        private bool _isHovering;
        private static readonly int IsHovering = Animator.StringToHash("IsHovering");

        private void Awake()
        {
            _textHover = GetComponentInChildren<Animator>();

            pointerObserver.PointerEntered += OnPointerEnter;
            pointerObserver.PointerExited += OnPointerExit;
        }

        public void OnPointerExit(PointerEventData eventData)
        {
            _isHovering = false;
            _textHover.SetBool(IsHovering, _isHovering);
        }

        public void OnPointerEnter(PointerEventData eventData)
        {
            _isHovering = true;
            _textHover.SetBool(IsHovering, _isHovering);
        }
    }
}

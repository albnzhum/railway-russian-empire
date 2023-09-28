using System;
using Observers;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;
using UnityEngine.Serialization;

namespace UI
{
    /// <summary>
    /// Class for changing main menu text state while hovering
    /// </summary>
    public class MainMenuTextState : MonoBehaviour
    {
        [SerializeField] private PointerObserver pointerObserver;
        [SerializeField] private GameObject image;
        private TMP_Text _text;
        private Animator textHover;
        private bool isHovering;
        private static readonly int IsHovering = Animator.StringToHash("IsHovering");

        private void Awake()
        {
            _text = GetComponentInChildren<TMP_Text>();
            textHover = GetComponentInChildren<Animator>();
            
            pointerObserver.PointerClicked += OnPointerClick;
            pointerObserver.PointerEntered += OnPointerEnter;
            pointerObserver.PointerExited += OnPointerExit;
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

        public void OnPointerClick(PointerEventData eventData)
        {
            SceneManager.LoadScene("LoadScreen");
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

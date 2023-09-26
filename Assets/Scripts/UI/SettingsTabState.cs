using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace UI
{
    /// <summary>
    /// Class for changing settings tab state
    /// </summary>
    public class SettingsTabState : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler
    {
        [SerializeField] private GameObject image;
        private TMP_Text text;
        private Animator _animator;
        private bool isHovering;
        private static readonly int IsHovering = Animator.StringToHash("IsHovering");

        private void Awake()
        {
            text = GetComponentInChildren<TMP_Text>();
            _animator = GetComponent<Animator>();
        }

        public void OnPointerEnter(PointerEventData eventData)
        {
            isHovering = true;
            _animator.SetBool(IsHovering, isHovering);
            text.color = Color.black;
            //image.SetActive(true);
        }

        public void OnPointerExit(PointerEventData eventData)
        {
            isHovering = false;
            _animator.SetBool(IsHovering, isHovering);
            //image.SetActive(false);
        }
        
        private void Update()
        {
            if (!isHovering)
            {
                text.color = new Color(192, 192, 192, 255);
            }
        }
    }
}

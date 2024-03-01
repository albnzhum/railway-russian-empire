using System;
using System.Collections;
using System.Collections.Generic;
using Railway.Input;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.UI
{
    public class UISettingsController : MonoBehaviour
    {
        [SerializeField] private InputReader _inputReader;
        
        public UnityAction Closed;

        private void OnEnable()
        {
            _inputReader.MenuCloseEvent += CloseScreen;
        }

        private void OnDisable()
        {
            _inputReader.MenuCloseEvent -= CloseScreen;
        }

        public void CloseScreen()
        {
            Closed.Invoke();
        }
    }
}
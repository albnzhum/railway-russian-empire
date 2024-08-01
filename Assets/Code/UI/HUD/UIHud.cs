using System;
using System.Collections;
using System.Collections.Generic;
using Railway.Events;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Railway.UI
{
    public class UIHud : MonoBehaviour
    {
        [SerializeField] private GameObject _hud;
        [SerializeField] private Button _openShopButton;
        [SerializeField] private Button _openSettingsButton;

        [Header("Listening on")] 
        [SerializeField] private BoolEventChannelSO _onLocationLoadedEvent;

        public UnityAction OpenShopEvent;
        public UnityAction OpenSettingsEvent;

        public void OpenShop()
        {
            OpenShopEvent.Invoke();
        }

        public void OpenSettings()
        {
            OpenSettingsEvent.Invoke();
        }
    }
}
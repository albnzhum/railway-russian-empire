using System;
using Railway.Events;
using Railway.Gameplay.Shop.UI;
using Railway.SceneManagement;
using Railway.UI;
using UnityEngine;

namespace Railway.Gameplay.UI
{
    public class UIManager : MonoBehaviour
    {
        [Header("Scene UI")] 
        [SerializeField] private UIPopup _popupPanel;
        [SerializeField] private UIShop _shopPanel;
        [SerializeField] private GameObject _switchTabDisplay;
        //[SerializeField] private UIPause _pauseScreen;
        [SerializeField] private UISettingsController _settingsScreen;

        [Header("Gameplay")] 
        [SerializeField] private GameStateSO _gameStateManager;
        [SerializeField] private MenuSceneSO _mainMenu;

        [Header("Listening on")] 
        [SerializeField] private VoidEventChannelSO _onSceneReady;

        [Header("Broadcasting on")] 
        [SerializeField] private LoadEventChannelSO _loadMenuEvent = default;
        [SerializeField] private VoidEventChannelSO _onInteractionEndedEvent;

        private void OnEnable()
        {
            
        }
    }
}

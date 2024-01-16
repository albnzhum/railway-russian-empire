using System;
using Railway.Gameplay;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.InputSystem;

namespace Railway.Input
{
    [CreateAssetMenu(fileName = "InputReader", menuName = "Gameplay/Input Reader")]
    public class InputReader : ScriptableObject, RailwayInputs.IGameplayActions, RailwayInputs.IMenusActions
    {
        [SerializeField] private GameStateSO _gameStateManager;
        
        public event UnityAction OpenShopEvent = delegate {  };
        public event UnityAction CloseShopEvent = delegate {  };
        
        public event UnityAction ChooseCellEvent = delegate {  };
        
        private RailwayInputs _railwayInputs;

        private void OnEnable()
        {
            if (_railwayInputs == null)
            {
                _railwayInputs = new RailwayInputs();
                
                _railwayInputs.Menus.SetCallbacks(this);
                _railwayInputs.Gameplay.SetCallbacks(this);
            }
        }

        private void OnDisable()
        {
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Disable();
        }

        public void EnableGameplayInput()
        {
            _railwayInputs.Gameplay.Enable();
            _railwayInputs.Menus.Disable();
        }

        public void EnableMenuInput()
        {
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Enable();
        }

        public void OnChooseCell(InputAction.CallbackContext context)
        {
        }

        public void OnOpenShop(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                OpenShopEvent.Invoke();
        }

        public void OnCloseShop(InputAction.CallbackContext context)
        {
            CloseShopEvent.Invoke();
        }

        public void OnClick(InputAction.CallbackContext context) { }

        public void OnRightClick(InputAction.CallbackContext context) { }

        public void OnSubmit(InputAction.CallbackContext context) { }

        public void OnCancel(InputAction.CallbackContext context)
        {
            
        }

        public void OnPoint(InputAction.CallbackContext context) { }

        public void OnPause(InputAction.CallbackContext context)
        {
            throw new NotImplementedException();
        }
    }
}

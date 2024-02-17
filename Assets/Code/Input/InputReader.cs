using System;
using Railway.Gameplay;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.InputSystem;

namespace Railway.Input
{
    [CreateAssetMenu(fileName = "InputReader", menuName = "Gameplay/Input Reader")]
    public class InputReader : ScriptableObject, RailwayInputs.IGameplayActions, RailwayInputs.IMenusActions, RailwayInputs.ITutorialsActions
    {
        [SerializeField] private GameStateSO _gameStateManager;
        
        public event UnityAction OpenShopEvent = delegate {  };
        public event UnityAction CloseShopEvent = delegate {  };
        public event UnityAction<Vector2> ChooseCellEvent = delegate {  };
        public event UnityAction<float> TabSwitched = delegate {  };
        public event UnityAction<Vector2> CameraMoveEvent = delegate { };
        public event UnityAction EnableMouseControlCameraEvent = delegate { };
        public event UnityAction DisableMouseControlCameraEvent = delegate { };

        private bool isGameplayInputEnabled;

        public bool IsGameplayInputEnabled
        {
            get;
            private set;
        }


        private RailwayInputs _railwayInputs;

        private void OnEnable()
        {
            if (_railwayInputs == null)
            {
                _railwayInputs = new RailwayInputs();
                
                _railwayInputs.Menus.SetCallbacks(this);
                _railwayInputs.Gameplay.SetCallbacks(this);
                _railwayInputs.Tutorials.SetCallbacks(this);
            }
        }

        private void OnDisable()
        {
            DisableAllInput();
        }

        public void EnableGameplayInput()
        {
            isGameplayInputEnabled = true;
            
            _railwayInputs.Gameplay.Enable();
            _railwayInputs.Menus.Disable();
            _railwayInputs.Tutorials.Disable();
        }

        public void EnableMenuInput()
        {
            isGameplayInputEnabled = false;
            
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Enable();
            _railwayInputs.Tutorials.Disable();
        }

        public void EnableTutorialInput()
        {
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Disable();
            _railwayInputs.Tutorials.Enable();
        }

        public void DisableAllInput()
        {
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Disable();
            _railwayInputs.Tutorials.Disable();
        }

        #region GAMEPLAY_INPUT

        public void OnChooseCell(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                ChooseCellEvent.Invoke(Mouse.current.position.ReadValue());
        }

        public void OnOpenShop(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                OpenShopEvent.Invoke();
        }
        
        public void OnPause(InputAction.CallbackContext context)
        {
            throw new NotImplementedException();
        }
        
        private bool IsDeviceMouse(InputAction.CallbackContext context) => context.control.device.name == "Mouse";
        
        public void OnZoomCamera(InputAction.CallbackContext context)
        {
            CameraMoveEvent.Invoke(context.ReadValue<Vector2>());
        }

        public void OnMouseControlCamera(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                EnableMouseControlCameraEvent.Invoke();

            if (context.phase == InputActionPhase.Canceled)
                DisableMouseControlCameraEvent.Invoke();
        }

        #endregion

        #region MENUS_INPUT

        public void OnCloseShop(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                CloseShopEvent.Invoke();
        }

        public void OnClick(InputAction.CallbackContext context) { }

        public void OnRightClick(InputAction.CallbackContext context) { }

        public void OnSubmit(InputAction.CallbackContext context) { }

        public void OnCancel(InputAction.CallbackContext context)
        {
            
        }

        public void OnChangeTab(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                TabSwitched.Invoke(context.ReadValue<float>());
        }

        public void OnPoint(InputAction.CallbackContext context) { }

        #endregion
    }
}

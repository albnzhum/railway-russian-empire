using System;
using Railway.Gameplay;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.InputSystem;
using Zenject;

namespace Railway.Input
{
    [CreateAssetMenu(fileName = "InputReader", menuName = "Gameplay/Input Reader")]
    public class InputReader : ScriptableObjectInstaller<InputReader>, RailwayInputs.IGameplayActions, RailwayInputs.IEditActions,
        RailwayInputs.IMenusActions, RailwayInputs.ITutorialsActions, RailwayInputs.IThirdPersonViewActions
    {
        public event UnityAction OpenShopEvent = delegate { };
        public event UnityAction CloseShopEvent = delegate { };
        public event UnityAction<Vector2> ChooseCellEvent = delegate { };
        public event Action<Vector2> PlaceItemEvent = delegate { };
        public event Action<Vector2> ChooseItemPositionEvent = delegate { };
        public event UnityAction<Vector2> HoverCellEvent = delegate { };
        public event UnityAction<float> TabSwitched = delegate { };
        public event UnityAction<Vector2> CameraZoomEvent = delegate { };
        public event UnityAction<Vector2> CameraMoveEvent = delegate { };
        public event UnityAction ChangeCameraEvent = delegate { };
        public event UnityAction EnableMouseControlCameraEvent = delegate { };
        public event UnityAction DisableMouseControlCameraEvent = delegate { };
        public event UnityAction OnCancelEvent = delegate { };
        public event UnityAction MoveSelectionEvent = delegate { };
        public event UnityAction MenuMouseMoveEvent = delegate { };
        public event UnityAction MenuCloseEvent = delegate { };
        public event UnityAction MenuPauseEvent = delegate { };
        public event UnityAction MenuUnpauseEvent = delegate { };

        private bool isGameplayInputEnabled;

        public bool IsGameplayInputEnabled
        {
            get => isGameplayInputEnabled;
            set => isGameplayInputEnabled = value;
        }

        private RailwayInputs _railwayInputs;

        private void OnEnable()
        {
            if (_railwayInputs == null)
            {
                _railwayInputs = new RailwayInputs();

                _railwayInputs.Menus.SetCallbacks(this);
                _railwayInputs.Edit.SetCallbacks(this);
                _railwayInputs.Gameplay.SetCallbacks(this);
                _railwayInputs.Tutorials.SetCallbacks(this);
                _railwayInputs.ThirdPersonView.SetCallbacks(this);
            }
        }

        private void OnDisable()
        {
            DisableAllInput();
        }

        public override void InstallBindings()
        {
            Container.Bind<InputReader>().FromInstance(this).AsCached().IfNotBound();
        }

        public void EnableGameplayInput()
        {
            isGameplayInputEnabled = true;

            _railwayInputs.Edit.Disable();
            _railwayInputs.Gameplay.Enable();
            _railwayInputs.Menus.Disable();
            _railwayInputs.Tutorials.Disable();
            _railwayInputs.ThirdPersonView.Disable();
        }

        public void EnableThirdPersonInput()
        {
            isGameplayInputEnabled = false;

            _railwayInputs.Edit.Disable();
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Disable();
            _railwayInputs.Tutorials.Disable();
            _railwayInputs.ThirdPersonView.Enable();
        }

        public bool LeftMouseDown() => Mouse.current.leftButton.isPressed;

        public void EnableEditInput()
        {
            isGameplayInputEnabled = true;

            _railwayInputs.Edit.Enable();
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Disable();
            _railwayInputs.Tutorials.Disable();
            _railwayInputs.ThirdPersonView.Disable();
        }

        public void EnableMenuInput()
        {
            isGameplayInputEnabled = false;

            _railwayInputs.Edit.Disable();
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Enable();
            _railwayInputs.Tutorials.Disable();
            _railwayInputs.ThirdPersonView.Disable();
        }

        public void EnableTutorialInput()
        {
            isGameplayInputEnabled = false;

            _railwayInputs.Edit.Disable();
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Disable();
            _railwayInputs.Tutorials.Enable();
            _railwayInputs.ThirdPersonView.Disable();
        }

        public void DisableAllInput()
        {
            _railwayInputs.Edit.Disable();
            _railwayInputs.Gameplay.Disable();
            _railwayInputs.Menus.Disable();
            _railwayInputs.Tutorials.Disable();
            _railwayInputs.ThirdPersonView.Disable();
        }

        #region GAMEPLAY_INPUT

        public void OnHoverCell(InputAction.CallbackContext context)
        {
            HoverCellEvent.Invoke(context.ReadValue<Vector2>());
        }

        public void OnChooseCell(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                ChooseCellEvent.Invoke(Mouse.current.position.value);
        }

        public void OnChooseItemPosition(InputAction.CallbackContext context)
        {
            ChooseItemPositionEvent.Invoke(context.ReadValue<Vector2>());
        }

        public void OnPlaceItem(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                PlaceItemEvent.Invoke(Mouse.current.position.value);
        }

        public void OnOpenShop(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                OpenShopEvent.Invoke();
        }

        public void OnPause(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                MenuPauseEvent.Invoke();
        }

        private bool IsDeviceMouse(InputAction.CallbackContext context) => context.control.device.name == "Mouse";

        public void OnZoomCamera(InputAction.CallbackContext context)
        {
            CameraZoomEvent.Invoke(context.ReadValue<Vector2>());
        }

        public void OnMouseControlCamera(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                EnableMouseControlCameraEvent.Invoke();

            if (context.phase == InputActionPhase.Canceled)
                DisableMouseControlCameraEvent.Invoke();
        }

        public void OnChangeCamera(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                ChangeCameraEvent.Invoke();
        }

        public void OnMoveCamera(InputAction.CallbackContext context)
        {
            CameraMoveEvent.Invoke(context.ReadValue<Vector2>());
        }

        #endregion

        #region MENUS_INPUT

        public void OnMoveSelection(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                MoveSelectionEvent.Invoke();
        }

        public void OnMouseMove(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                MenuMouseMoveEvent.Invoke();
        }

        public void OnCloseShop(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                CloseShopEvent.Invoke();
        }

        public void OnUnpause(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                MenuUnpauseEvent.Invoke();
        }

        public void OnClick(InputAction.CallbackContext context)
        {
        }

        public void OnRightClick(InputAction.CallbackContext context)
        {
        }

        public void OnSubmit(InputAction.CallbackContext context)
        {
        }

        public void OnCancel(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                MenuCloseEvent.Invoke();
        }

        public void OnCancelPlacing(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                OnCancelEvent.Invoke();
        }

        public void OnChangeTab(InputAction.CallbackContext context)
        {
            if (context.phase == InputActionPhase.Performed)
                TabSwitched.Invoke(context.ReadValue<float>());
        }

        public void OnPoint(InputAction.CallbackContext context)
        {
        }

        #endregion
    }
}
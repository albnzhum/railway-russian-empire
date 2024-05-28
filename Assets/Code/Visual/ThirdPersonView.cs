using System;
using Railway.Input;
using UnityEngine;

namespace Railway.Visual
{
    public class ThirdPersonView : MonoBehaviour
    {
        [SerializeField] private float acceleration = 50f;
        [SerializeField] private float accSprintMultiplier = 4f;
        [SerializeField] private float lookSensitivity = 1f;
        [SerializeField] private float dampingCoefficient = 5f;

        [SerializeField] private InputReader _inputReader;

        private bool focusOnEnable = true;
        private Vector3 velocity;

        private Camera cam;

        private static bool Focused
        {
            get => Cursor.lockState == CursorLockMode.Locked;
            set
            {
                Cursor.lockState = value ? CursorLockMode.Locked : CursorLockMode.None;
                Cursor.visible = value == false;
            }
        }

        private void OnEnable()
        {
            cam = GetComponent<Camera>();
        }

        private void OnDisable()
        {
            Focused = false;
        }

        private void Update()
        {
            if (cam.enabled)
            {
                UpdateInput();
                velocity = Vector3.Lerp(velocity, Vector3.zero, dampingCoefficient * Time.deltaTime);
                transform.position += velocity * Time.deltaTime;
            }
        }

        private void UpdateInput()
        {
            velocity += GetAccelerationVector() * Time.deltaTime;
            
            Vector2 mouseDelta = lookSensitivity * new Vector2( UnityEngine.Input.GetAxis( "Mouse X" ),-UnityEngine.Input.GetAxis( "Mouse Y" ) );

            Quaternion rotation = transform.rotation;
            Quaternion horizontalRotation = Quaternion.AngleAxis(mouseDelta.x, Vector3.up);
            Quaternion verticalRotation = Quaternion.AngleAxis(mouseDelta.y, Vector3.right);

            transform.rotation = horizontalRotation * rotation * verticalRotation;
        }

        Vector3 GetAccelerationVector()
        {
            Vector3 moveInput = default;

            void AddMovement(KeyCode key, Vector3 dir)
            {
                if (UnityEngine.Input.GetKey(key))
                    moveInput += dir;
            }

            AddMovement(KeyCode.W, Vector3.forward);
            AddMovement(KeyCode.S, Vector3.back);
            AddMovement(KeyCode.D, Vector3.right);
            AddMovement(KeyCode.A, Vector3.left);
            AddMovement(KeyCode.Space, Vector3.up);
            AddMovement(KeyCode.LeftControl, Vector3.down);
            
            Vector3 direction = transform.TransformVector(moveInput.normalized);

            if (UnityEngine.Input.GetKey(KeyCode.LeftShift))
                return direction * (acceleration * accSprintMultiplier);
            return direction * acceleration;
        }
    }
}
using System;
using Cinemachine;
using Railway.Input;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Serialization;

public class RTSCamera : MonoBehaviour
{
    public InputReader _inputReader;

    private Transform cameraTransform;

    [Header("Horizontal Translation")] [SerializeField]
    private float maxSpeed = 5f;

    private float speed;

    [SerializeField] private float acceleration = 10f;
    [SerializeField] private float damping = 15f;

    [Header("Vertical Translation")] [SerializeField]
    private float stepSize = 2f;

    [SerializeField] private float zoomDampening = 7.5f;
    [SerializeField] private float minHeight = 5f;
    [SerializeField] private float maxHeight = 50f;
    [SerializeField] private float zoomSpeed = 2f;

    [Header("Rotation")] [SerializeField] private float maxRotationSpeed = 1f;

    [Header("Edge Movement")] [SerializeField] [Range(0f, 0.1f)]
    private float edgeTolerance = 0.05f;

    private Vector3 targetPosition;

    private float zoomHeight;

    private Vector3 horizontalVelocity;
    private Vector3 lastPosition;

    private Vector3 startDrag;

    private void Awake()
    {
        cameraTransform = GetComponentInChildren<Camera>().transform;
    }

    private void OnEnable()
    {
        //_inputReader.EnableGameplayInput();

        zoomHeight = cameraTransform.localPosition.y;

        lastPosition = transform.position;

        _inputReader.CameraMoveEvent += ZoomCamera;
    }

    private void OnDisable()
    {
        _inputReader.CameraMoveEvent -= ZoomCamera;
        _inputReader.DisableAllInput();
    }

    private void Update()
    {
        if (_inputReader.IsGameplayInputEnabled)
        {
            CheckMouseAtScreenEdge();
            DragCamera();

            UpdateVelocity();
            UpdateBasePosition();
            UpdateCameraPosition();
        }
    }

    private void ZoomCamera(Vector2 position)
    {
        float inputValue = -position.y / 100f;

        if (Mathf.Abs(inputValue) > 0.1f)
        {
            zoomHeight = cameraTransform.localPosition.y + inputValue * stepSize;

            if (zoomHeight < minHeight) zoomHeight = minHeight;
            else if (zoomHeight > maxHeight) zoomHeight = maxHeight;
        }
    }

    private Vector3 GetCameraForward()
    {
        Vector3 forward = cameraTransform.forward;
        forward.y = 0f;
        return forward;
    }

    private Vector3 GetCameraRight()
    {
        Vector3 right = cameraTransform.right;
        right.y = 0f;
        return right;
    }

    private void UpdateVelocity()
    {
        horizontalVelocity = (transform.position - lastPosition) / Time.deltaTime;
        horizontalVelocity.y = 0f;
        lastPosition = transform.position;
    }

    private void UpdateBasePosition()
    {
        if (targetPosition.sqrMagnitude > 0.1f)
        {
            speed = Mathf.Lerp(speed, maxSpeed, Time.deltaTime * acceleration);
            transform.position += targetPosition * speed * Time.deltaTime;
        }
        else
        {
            horizontalVelocity = Vector3.Lerp(horizontalVelocity,
                Vector3.zero, Time.deltaTime * damping);
            transform.position += horizontalVelocity * Time.deltaTime;
        }

        targetPosition = Vector3.zero;
    }

    private void UpdateCameraPosition()
    {
        Vector3 zoomTarget = new Vector3(cameraTransform.localPosition.x,
            zoomHeight, cameraTransform.localPosition.z);
        zoomTarget -= zoomSpeed * (zoomHeight - cameraTransform.localPosition.y) * Vector3.forward;

        cameraTransform.localPosition = Vector3.Lerp(cameraTransform.localPosition,
            zoomTarget, Time.deltaTime * zoomDampening);
        //cameraTransform.LookAt(transform);
    }

    private void CheckMouseAtScreenEdge()
    {
        Vector2 mousePosition = Mouse.current.position.ReadValue();
        Vector3 moveDirection = Vector3.zero;
        if (mousePosition.x < edgeTolerance * Screen.width)
        {
            moveDirection += -GetCameraRight();
        }
        else if (mousePosition.x > (1f - edgeTolerance) * Screen.width)
        {
            moveDirection += GetCameraRight();
        }

        if (mousePosition.y < edgeTolerance * Screen.height)
        {
            moveDirection += -GetCameraForward();
        }
        else if (mousePosition.y > (1f - edgeTolerance) * Screen.height)
        {
            moveDirection += GetCameraForward();
        }

        //targetPosition += moveDirection;
    }

    private void DragCamera()
    {
        if (!Mouse.current.rightButton.isPressed) return;

        Plane plane = new Plane(Vector3.up, Vector3.zero);
        Ray ray = Camera.main.ScreenPointToRay(Mouse.current.position.ReadValue());

        if (plane.Raycast(ray, out float distance))
        {
            if (Mouse.current.rightButton.wasPressedThisFrame)
            {
                startDrag = ray.GetPoint(distance);
            }
            else
            {
                targetPosition += startDrag - ray.GetPoint(distance);
            }
        }
    }
}
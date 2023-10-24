using System;
using UnityEngine;

namespace LandscapeGenerator
{
    public class HexMapCamera : MonoBehaviour
    {
        private Transform _swivel, _stick;

        private float _zoom = 1f;
        public float stickMinZoom, stickMaxZoom;
        public float swivelMinZoom, swivelMaxZoom;

        public float moveSpeedMinZoom, moveSpeedMaxZoom;

        public float rotationSpeed;
        private float _rotationAngle;

        static HexMapCamera instance;

        public HexGrid grid;

        public static bool Locked
        {
            set => instance.enabled = !value;
        }

        void Awake()
        {
            _swivel = transform.GetChild(0);
            _stick = _swivel.GetChild(0);
        }

        void OnEnable()
        {
            instance = this;
        }

        void Update()
        {
            var zoomDelta = Input.GetAxis("Mouse ScrollWheel");
            if (zoomDelta != 0f)
            {
                AdjustZoom(zoomDelta);
            }

            var rotationDelta = Input.GetAxis("Rotation");
            if (rotationDelta != 0f)
            {
                AdjustRotation(rotationDelta);
            }

            var xDelta = Input.GetAxis("Horizontal");
            var zDelta = Input.GetAxis("Vertical");
            if (xDelta != 0f || zDelta != 0f)
            {
                AdjustPosition(xDelta, zDelta);
            }
        }

        public static void ValidatePosition()
        {
            instance.AdjustPosition(0f, 0f);
        }

        void AdjustZoom(float delta)
        {
            _zoom = Mathf.Clamp01(_zoom + delta);

            var distance = Mathf.Lerp(stickMinZoom, stickMaxZoom, _zoom);
            _stick.localPosition = new Vector3(0f, 0f, distance);

            var angle = Mathf.Lerp(swivelMinZoom, swivelMaxZoom, _zoom);
            _swivel.localRotation = Quaternion.Euler(angle, 0f, 0f);
        }

        void AdjustPosition(float xDelta, float zDelta)
        {
            var direction = transform.localRotation * new Vector3(xDelta, 0f, zDelta).normalized;
            var damping = Mathf.Max(Mathf.Abs(xDelta), Mathf.Abs(zDelta));
            var distance = Mathf.Lerp(moveSpeedMinZoom, moveSpeedMaxZoom, _zoom) * damping * Time.deltaTime;

            var position = transform.localPosition;
            position += direction * distance;
            transform.localPosition = ClampPosition(position);
        }

        Vector3 ClampPosition(Vector3 position)
        {
            var xMax = (grid.cellCountX - 0.5f) * (2f * HexMetrics.InnerRadius);
            position.x = Mathf.Clamp(position.x, 0f, xMax);

            var zMax = (grid.cellCountZ - 1) * (1.5f * HexMetrics.OuterRadius);
            position.z = Mathf.Clamp(position.z, 0f, zMax);

            return position;
        }

        void AdjustRotation(float delta)
        {
            _rotationAngle += delta * rotationSpeed * Time.deltaTime;
            if (_rotationAngle < 0f)
            {
                _rotationAngle += 360f;
            }
            else if (_rotationAngle >= 360f)
            {
                _rotationAngle -= 360f;
            }

            transform.localRotation = Quaternion.Euler(0f, _rotationAngle, 0f);
        }
    }
}

using Railway.Input;
using UnityEngine;

namespace TGS
{
    public class TerrainCamera : MonoBehaviour
    {
        public InputReader _inputReader;
        public float ScreenEdgeBorderThickness = 5.0f; // distance from screen edge. Used for mouse movement

        [Header("Movement Speeds")] [Space] public float minPanSpeed;
        public float maxPanSpeed;
        public float secToMaxSpeed; //seconds taken to reach max speed;
        public float zoomSpeed;

        [Header("Movement Limits")] [Space] public bool enableMovementLimits;
        public Vector2 heightLimit;
        public Vector2 lenghtLimit;
        public Vector2 widthLimit;
        public Vector2 zoomLimit;
        private float panSpeed;
        private Vector3 initialPos;
        private Vector3 panMovement;
        private Vector3 pos;
        private Quaternion rot;
        private bool rotationActive = false;
        private Vector3 lastMousePosition;
        private Quaternion initialRot;
        private float panIncrease = 0.0f;

        [Header("Rotation")] 
        [Space] public bool rotationEnabled;
        public float rotateSpeed;

        private Vector3 velocity = Vector3.zero;

        private void OnEnable()
        {
            _inputReader.CameraMoveEvent += OnCameraMove;
            _inputReader.EnableMouseControlCameraEvent += OnEnableMouseControlCamera;
            _inputReader.DisableMouseControlCameraEvent += OnDisableMouseControlCamera;
        }

        private void OnDisable()
        {
            _inputReader.CameraMoveEvent -= OnCameraMove;
            _inputReader.EnableMouseControlCameraEvent -= OnEnableMouseControlCamera;
            _inputReader.DisableMouseControlCameraEvent -= OnDisableMouseControlCamera;
        }

        void Start()
        {
            initialPos = transform.position;
            initialRot = transform.rotation;
        }

        private void OnDisableMouseControlCamera()
        {
            throw new System.NotImplementedException();
        }

        private void OnEnableMouseControlCamera()
        {
            throw new System.NotImplementedException();
        }

        //TODO: Улучшить сглаживание передвижения камеры
        private void OnCameraMove(Vector2 movePosition, bool isDeviceMouse)
        {
            panMovement = Vector3.zero;
            
            float deviceMultiplier = isDeviceMouse ? 0.03f : Time.deltaTime;
            
            if (movePosition.y >= Screen.height - ScreenEdgeBorderThickness)
            {
                panMovement += Vector3.forward * panSpeed * Time.deltaTime;
            }

            if (movePosition.y <= ScreenEdgeBorderThickness)
            {
                panMovement -= Vector3.forward * panSpeed * Time.deltaTime;
            }

            if (movePosition.x <= ScreenEdgeBorderThickness)
            {
                panMovement += Vector3.left * panSpeed * Time.deltaTime;
            }

            if (movePosition.x >= Screen.width - ScreenEdgeBorderThickness)
            {
                panMovement += Vector3.right * panSpeed * Time.deltaTime;
            }
            
            transform.Translate(panMovement, Space.World);
            
            if (movePosition.y >= Screen.height - ScreenEdgeBorderThickness
                || movePosition.y <= ScreenEdgeBorderThickness
                || movePosition.x <= ScreenEdgeBorderThickness
                || movePosition.x >= Screen.width - ScreenEdgeBorderThickness)
            {
                panIncrease += deviceMultiplier / secToMaxSpeed;
                panSpeed = Mathf.Lerp(minPanSpeed, maxPanSpeed, panIncrease);
            }
            else
            {
                panIncrease = 0;
                panSpeed = minPanSpeed;
            }
            
            #region boundaries

            if (enableMovementLimits)
            {
                //movement limits
                pos = transform.position;
                pos.y = Mathf.Clamp(pos.y, heightLimit.x, heightLimit.y);
                pos.z = Mathf.Clamp(pos.z, lenghtLimit.x, lenghtLimit.y);
                pos.x = Mathf.Clamp(pos.x, widthLimit.x, widthLimit.y);
                transform.position = pos;
            }

            #endregion
            
        }

        /*void Update()
        {
            #region Movement

            panMovement = Vector3.zero;
            if (Input.GetKey(KeyCode.W) || Input.mousePosition.y >= Screen.height - ScreenEdgeBorderThickness)
            {
                panMovement += Vector3.forward * panSpeed * Time.deltaTime;
            }

            if (Input.GetKey(KeyCode.S) || Input.mousePosition.y <= ScreenEdgeBorderThickness)
            {
                panMovement -= Vector3.forward * panSpeed * Time.deltaTime;
            }

            if (Input.GetKey(KeyCode.A) || Input.mousePosition.x <= ScreenEdgeBorderThickness)
            {
                panMovement += Vector3.left * panSpeed * Time.deltaTime;
            }

            if (Input.GetKey(KeyCode.D) || Input.mousePosition.x >= Screen.width - ScreenEdgeBorderThickness)
            {
                panMovement += Vector3.right * panSpeed * Time.deltaTime;
                //pos.x += panSpeed * Time.deltaTime;
            }

            if (Input.GetKey(KeyCode.Q))
            {
                panMovement += Vector3.up * panSpeed * Time.deltaTime;
            }

            if (Input.GetKey(KeyCode.E))
            {
                panMovement += Vector3.down * panSpeed * Time.deltaTime;
            }

            transform.Translate(panMovement, Space.World);

            if (Input.GetKey(KeyCode.W) || Input.GetKey(KeyCode.S)
                                        || Input.GetKey(KeyCode.A) || Input.GetKey(KeyCode.D)
                                        || Input.GetKey(KeyCode.E) || Input.GetKey(KeyCode.Q)
                                        || Input.mousePosition.y >= Screen.height - ScreenEdgeBorderThickness
                                        || Input.mousePosition.y <= ScreenEdgeBorderThickness
                                        || Input.mousePosition.x <= ScreenEdgeBorderThickness
                                        || Input.mousePosition.x >= Screen.width - ScreenEdgeBorderThickness)
            {
                panIncrease += Time.deltaTime / secToMaxSpeed;
                panSpeed = Mathf.Lerp(minPanSpeed, maxPanSpeed, panIncrease);
            }
            else
            {
                panIncrease = 0;
                panSpeed = minPanSpeed;
            }

            #endregion

            #region Zoom

            Camera.main.fieldOfView -= Input.mouseScrollDelta.y * zoomSpeed;
            Camera.main.fieldOfView = Mathf.Clamp(Camera.main.fieldOfView, zoomLimit.x, zoomLimit.y);

            #endregion

            #region boundaries

            if (enableMovementLimits == true)
            {
                //movement limits
                pos = transform.position;
                pos.y = Mathf.Clamp(pos.y, heightLimit.x, heightLimit.y);
                pos.z = Mathf.Clamp(pos.z, lenghtLimit.x, lenghtLimit.y);
                pos.x = Mathf.Clamp(pos.x, widthLimit.x, widthLimit.y);
                transform.position = pos;
            }

            #endregion
        }*/
    }
}
using Railway.Input;
using UnityEngine;

namespace Railway.Visual
{
    public class CameraViewController : MonoBehaviour
    {
        [SerializeField] private GameObject topView;
        [SerializeField] private Camera thirdPersonViewZoom;

        [SerializeField] private InputReader _inputReader;

        private bool isTopViewEnabled;

        private void OnEnable()
        {
            _inputReader.ChangeCameraEvent += ChangeCamera;
        }

        private void OnDisable()
        {
            _inputReader.ChangeCameraEvent -= ChangeCamera;
        }

        private void Start()
        {
            isTopViewEnabled = true;
            
            topView.SetActive(isTopViewEnabled);
            thirdPersonViewZoom.enabled = false;
        }

        private void ChangeCamera()
        {
            isTopViewEnabled = !isTopViewEnabled;
            
            topView.SetActive(isTopViewEnabled);
            thirdPersonViewZoom.enabled = !thirdPersonViewZoom.enabled;

            if (thirdPersonViewZoom.enabled)
            {
                _inputReader.EnableThirdPersonInput();
            }
            else if (isTopViewEnabled)
            {
                _inputReader.EnableGameplayInput();
            }
        }
    }
}

using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Zenject;

namespace UI
{
    /// <summary>
    /// Class for asynchronously loading scene 
    /// </summary>
    public class LoadingScreen : MonoBehaviour
    {
        [SerializeField] private Slider loadingSlider;
        [Inject] private Configuration _config;
        
        private readonly float _loadingSpeed = 1;
        private float _targetValue;
        private AsyncOperation _operation;

        private string locationName;
        
        private void Start()
        {
            locationName = _config.City.name;
            loadingSlider.value = 0.0f;
            if (SceneManager.GetActiveScene().name == "LoadScreen")
            {
                StartCoroutine(LoadSceneAsync());
            }
        }

        IEnumerator LoadSceneAsync()
        {
            _operation = SceneManager.LoadSceneAsync(locationName);
            _operation.allowSceneActivation = false;
            yield return _operation;
        }

        private void Update()
        {
            _targetValue = _operation.progress;
            if (_operation.progress >= 0.9f)
            {
                _targetValue = 1.0f;
            }

            if (_targetValue != loadingSlider.value)
            {
                loadingSlider.value = Mathf.Lerp(loadingSlider.value, _targetValue, Time.deltaTime * _loadingSpeed);
                if (Mathf.Abs(loadingSlider.value - _targetValue) < 0.01f)
                {
                    loadingSlider.value = _targetValue;
                }

                if ((int)(loadingSlider.value * 100) == 100)
                {
                    _operation.allowSceneActivation = true;
                }
            }
        }
    }
}

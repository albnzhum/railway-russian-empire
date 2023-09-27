using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class LoadingScreen : MonoBehaviour
{
    [SerializeField] private Slider loadingSlider;
    private float loadingSpeed = 1;
    private float targetValue;
    private AsyncOperation operation;

    private void Start()
    {
        loadingSlider.value = 0.0f;
        if (SceneManager.GetActiveScene().name == "LoadScreen")
        {
            StartCoroutine(LoadSceneAsync());
        }
    }
    
    IEnumerator LoadSceneAsync()
    { 
        operation = SceneManager.LoadSceneAsync("Game");
        operation.allowSceneActivation = false;
        yield return operation;
    }

    private void Update()
    {
        targetValue = operation.progress;
        if (operation.progress >= 0.9f)
        {
            targetValue = 1.0f;
        }

        if (targetValue != loadingSlider.value)
        {
            loadingSlider.value = Mathf.Lerp(loadingSlider.value, targetValue, Time.deltaTime * loadingSpeed);
            if (Mathf.Abs(loadingSlider.value - targetValue) < 0.01f)
            {
                loadingSlider.value = targetValue;
            }

            if ((int)(loadingSlider.value * 100) == 100)
            {
                // Разрешить автоматическое переключение сцен после асинхронной загрузки
                operation.allowSceneActivation = true;
            }
        }
    }
}

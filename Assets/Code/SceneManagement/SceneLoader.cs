using System;
using System.Collections;
using Railway.Events;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.ResourceProviders;
using UnityEngine.SceneManagement;

namespace Railway.SceneManagement
{
    /// <summary>
    /// Class for control of loading and unloading scenes
    /// </summary>
    public class SceneLoader : MonoBehaviour
    {
        [SerializeField] private GameSceneSO _gamePlayScene;

        [Header("Listening To")] 
        [SerializeField] private LoadEventChannelSO _loadLocation;

        [SerializeField] private LoadEventChannelSO _loadScene;

        [SerializeField] private LoadEventChannelSO _loadMenu;
        [SerializeField] private LoadEventChannelSO _coldStartupLocation;
        [SerializeField] private BoolEventChannelSO _onLocationLoadedEvent;

        [Header("Broadcasting on")] 
        [SerializeField] private BoolEventChannelSO _toggleLoadingScreen = default;

        [SerializeField] private FadeChannelSO _fadeRequestChannel = default;

        private AsyncOperationHandle<SceneInstance> _loadingOperationHandle;
        private AsyncOperationHandle<SceneInstance> _gameplayManagerLoadingOperationHandle;

        private GameSceneSO _sceneToLoad;
        private GameSceneSO _currentlyLoadedScene;
        private bool _showLoadingScreen;

        private SceneInstance _gameplayManagerSceneInstance = new SceneInstance();
        private float _fadeDuration = .5f;
        private bool _isLoading = false;

        private void OnEnable()
        {
            _loadLocation.OnLoadingRequested += LoadLocation;
            _loadScene.OnLoadingRequested += LoadScene;
            _loadMenu.OnLoadingRequested += LoadMenu;
#if UNITY_EDITOR
            _coldStartupLocation.OnLoadingRequested += LocationColdStartup;
#endif
        }

        private void OnDisable()
        {
            _loadLocation.OnLoadingRequested -= LoadLocation;
            _loadScene.OnLoadingRequested -= LoadScene;
            _loadMenu.OnLoadingRequested -= LoadMenu;

#if UNITY_EDITOR
            _coldStartupLocation.OnLoadingRequested -= LocationColdStartup;
#endif
        }

        /// <summary>
        /// Starts loading the specified menu
        /// </summary>
        /// <param name="menuToLoad"></param>
        /// <param name="showLoadingScreen"></param>
        /// <param name="fadeScreen"></param>
        private void LoadMenu(GameSceneSO menuToLoad, bool showLoadingScreen, bool fadeScreen)
        {
            if (_isLoading) return;

            _sceneToLoad = menuToLoad;
            _showLoadingScreen = showLoadingScreen;
            _isLoading = true;

            if (_gameplayManagerSceneInstance.Scene != null && _gameplayManagerSceneInstance.Scene.isLoaded)
            {
                Addressables.UnloadSceneAsync(_gameplayManagerLoadingOperationHandle, true);
            }

            StartCoroutine(UnloadPreviousScene());
        }

        /// <summary>
        /// Starts loading the specified location
        /// </summary>
        /// <param name="locationToLoad"></param>
        /// <param name="showLoadingScreen"></param>
        /// <param name="fadeScreen"></param>
        private void LoadLocation(GameSceneSO locationToLoad, bool showLoadingScreen, bool fadeScreen)
        {
            if (_isLoading)
                return;

            _sceneToLoad = locationToLoad;
            _showLoadingScreen = showLoadingScreen;
            _isLoading = true;

            if (_gameplayManagerSceneInstance.Scene == null
                || !_gameplayManagerSceneInstance.Scene.isLoaded)
            {
                _gameplayManagerLoadingOperationHandle
                    = _gamePlayScene.sceneReference.LoadSceneAsync(LoadSceneMode.Additive, true);
                _gameplayManagerLoadingOperationHandle.Completed += OnGameplayManagersLoaded;
            }
            else
            {
                StartCoroutine(UnloadPreviousScene());
            }
        }

        private void IsLocationLoading()
        {
            if (_sceneToLoad.sceneType == GameSceneSO.GameSceneType.Location)
            {
                Debug.Log("Location loaded");

                _onLocationLoadedEvent.RaiseEvent(true);
            }
        }

        private void LoadScene(GameSceneSO locationToLoad, bool showLoadingScreen, bool fadeScreen)
        {
            if (_isLoading)
                return;

            _sceneToLoad = locationToLoad;
            _showLoadingScreen = showLoadingScreen;
            _isLoading = true;

            StartCoroutine(UnloadPreviousScene());
        }

        /// <summary>
        /// Start after the gameplay manager completes loading.
        /// </summary>
        /// <param name="obj"></param>
        private void OnGameplayManagersLoaded(AsyncOperationHandle<SceneInstance> obj)
        {
            _gameplayManagerSceneInstance = _gameplayManagerLoadingOperationHandle.Result;

            StartCoroutine(UnloadPreviousScene());
        }


#if UNITY_EDITOR
        private void LocationColdStartup(GameSceneSO currentlyOpenedLocation, bool showLoadingScreen, bool fadeScreen)
        {
            _currentlyLoadedScene = currentlyOpenedLocation;

            if (_currentlyLoadedScene.sceneType == GameSceneSO.GameSceneType.Location)
            {
                _gameplayManagerLoadingOperationHandle =
                    _gamePlayScene.sceneReference.LoadSceneAsync(LoadSceneMode.Additive, true);
                _gameplayManagerLoadingOperationHandle.WaitForCompletion();
                _gameplayManagerSceneInstance = _gameplayManagerLoadingOperationHandle.Result;

                //StartGameplay();
            }
        }
#endif

        /// <summary>
        /// Starts uploading the previous scene
        /// </summary>
        /// <returns></returns>
        private IEnumerator UnloadPreviousScene()
        {
            _fadeRequestChannel.FadeOut(_fadeDuration);

            yield return new WaitForSeconds(_fadeDuration);

            if (_currentlyLoadedScene != null)
            {
                if (_currentlyLoadedScene.sceneReference.OperationHandle.IsValid())
                {
                    _currentlyLoadedScene.sceneReference.UnLoadScene();
                }
#if UNITY_EDITOR
                else
                {
                    SceneManager.UnloadSceneAsync(_currentlyLoadedScene.sceneReference.editorAsset.name);
                }
#endif
            }

            LoadNewScene();
        }

        /// <summary>
        /// Starts loading a new scene
        /// </summary>
        private void LoadNewScene()
        {
            if (_showLoadingScreen)
            {
                _toggleLoadingScreen.RaiseEvent(true);
            }

            _loadingOperationHandle = _sceneToLoad.sceneReference.LoadSceneAsync(LoadSceneMode.Additive, true, 0);
            _loadingOperationHandle.Completed += OnNewSceneLoaded;
        }

        /// <summary>
        /// Sets the new scene as current, activates it, and completes the boot process
        /// </summary>
        /// <param name="obj"></param>
        private void OnNewSceneLoaded(AsyncOperationHandle<SceneInstance> obj)
        {
            _currentlyLoadedScene = _sceneToLoad;

            IsLocationLoading();

            Scene s = obj.Result.Scene;
            SceneManager.SetActiveScene(s);
            _isLoading = false;

            if (_showLoadingScreen)
            {
                _toggleLoadingScreen.RaiseEvent(false);
            }

            _fadeRequestChannel.FadeIn(_fadeDuration);
        }
    }
}
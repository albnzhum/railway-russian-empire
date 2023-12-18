using Components;
using UI;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.SceneManagement;
using Zenject;

public class ChooseLocationSystem : MonoBehaviour
{
    //[Inject] private Configuration _config;
    
    private int _difficulty;
    
    public void SetDifficultyId(int id)
    {
        _difficulty = id;
    }

    /*public void SetDifficulty()
    {
        if (_config != null)
        {
            _config.LevelDifficulty = (LevelDifficulty)_difficulty;
        }

        SceneManager.LoadScene("LoadScreen");
    }

    public void SetLocation(string name)
    {
        AsyncOperationHandle<CityComponent> handle = Addressables.LoadAssetAsync<CityComponent>("Installers/" + name);
        handle.Completed += OnLoadComplete;
    }*/

    /*private async void OnLoadComplete(AsyncOperationHandle<CityComponent> handle)
    {
        await handle.Task;
        if (handle.Status == AsyncOperationStatus.Succeeded)
        {
            if (handle.Result != null)
            {
                _config.City = handle.Result;
            }
        }
        else
        {
            Debug.LogError($"Failed to load CityComponent: {handle.DebugName}");
        }

        Addressables.Release(handle);
    }*/
}
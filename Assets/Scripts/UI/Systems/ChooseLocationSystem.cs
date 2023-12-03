using System.Collections;
using System.Collections.Generic;
using Components;
using Leopotam.EcsLite.Di;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;
using Resources = UnityEngine.Resources;

public class ChooseLocationSystem : MonoBehaviour
{
    private EcsCustomInject<StaticData> _config = default;
    public AssetReference reference;
    
    public void ChooseLocation()
    {
        // Use Addressables to load the CityComponent asynchronously.
        AsyncOperationHandle<CityComponent> handle = Addressables.LoadAssetAsync<CityComponent>(reference);

        // Attach a completion callback to handle the loaded asset.
        handle.Completed += OnLoadComplete;
    }

    // Callback method for handling the loaded asset.
    private async void OnLoadComplete(AsyncOperationHandle<CityComponent> handle)
    {
        await handle.Task;
        if (handle.Status == AsyncOperationStatus.Succeeded)
        {
            if (handle.Result != null)
            {
                _config.Value.City = handle.Result;
            }
            else
            {
                Debug.Log("null");
            }
            
        }
        else
        {
            // Handle the case where loading failed.
            Debug.LogError($"Failed to load CityComponent: {handle.DebugName}");
        }

        // Release the handle to free up resources.
        Addressables.Release(handle);
    }

    public void ChooseLevelDifficulty(int id)
    {
        _config.Value.LevelDifficulty = (LevelDifficulty)id;
    }
}

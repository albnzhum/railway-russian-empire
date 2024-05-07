using UnityEngine;
using UnityEngine.AddressableAssets;

namespace Railway.SceneManagement
{
    public class GameSceneSO : ScriptableObject
    {
        public GameSceneType sceneType;
        public AssetReference sceneReference;

        public enum GameSceneType
        {
            //Playable scenes
            Location, //SceneSelector tool will also load PersistentManagers and Gameplay
            Menu, //SceneSelector tool will also load Gameplay

            //Special scenes
            Initialisation,
            PersistentManagers,
            Gameplay
        }
    }
}
using Leopotam.EcsLite.Unity.Ugui;
using UnityEngine.SceneManagement;
using UnityEngine.Scripting;
using Leopotam.EcsLite;
using Leopotam.EcsLite.Di;
using Client;
using UnityEngine;

namespace UI
{
    public class MainMenuSystem : EcsUguiCallbackSystem, IEcsRunSystem
    {
        private EcsPoolInject<ShowScreenRequest> _showScreenPool = default;
        
        [Preserve]
        [EcsUguiClickEvent(Idents.MainMenu.NewGame)]
        void OnNewGameClick(in EcsUguiClickEvent evt)
        {
            SceneManager.LoadScene("LoadScreen");
        }
        
        [Preserve]
        [EcsUguiEnterEvent(Idents.MainMenu.NewGame)]
        void OnNewGamePointerEnter(in EcsUguiEnterEvent evt)
        {
            Debug.Log("Mouse enter New Game");
        }

        [Preserve]
        [EcsUguiClickEvent(Idents.MainMenu.LoadGame)]
        void OnLoadGameClick(in EcsUguiClickEvent evt)
        {
            Debug.Log("Load Game Clicked");
        }
        
        [Preserve]
        [EcsUguiEnterEvent(Idents.MainMenu.LoadGame)]
        void OnLoadGamePointerEnter(in EcsUguiEnterEvent evt)
        {
            Debug.Log("Mouse enter Load Game");
        }

        [Preserve]
        [EcsUguiClickEvent(Idents.MainMenu.Settings)]
        void OnSettingsClick(in EcsUguiClickEvent evt)
        {
            //_settingsCanvas.SetActive(true);
        }
        
        [Preserve]
        [EcsUguiEnterEvent(Idents.MainMenu.Settings)]
        void OnSettingsPointerEnter(in EcsUguiEnterEvent evt)
        {
            Debug.Log("Mouse enter Settings");
        }

        [Preserve]
        [EcsUguiClickEvent(Idents.MainMenu.Exit)]
        void OnExitClick(in EcsUguiClickEvent evt)
        {
            Application.Quit();
        }
        
        [Preserve]
        [EcsUguiEnterEvent(Idents.MainMenu.Exit)]
        void OnExitPointerEnter(in EcsUguiEnterEvent evt)
        {
            Debug.Log("Mouse enter Exit");
        }
        

        /*public void Run(IEcsSystems systems)
        {
            
        }*/
    }
}

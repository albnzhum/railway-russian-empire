using Leopotam.EcsLite.Unity.Ugui;
using UnityEngine.SceneManagement;
using UnityEngine.Scripting;
using Leopotam.EcsLite;
using UnityEngine;

namespace UI
{
    public class MainMenuSystem : EcsUguiCallbackSystem 
    {
        //[EcsUguiNamed("Settings")] GameObject _settingsCanvas;
        [Preserve]
        [EcsUguiClickEvent("NewGame")]
        void OnNewGameClick(in EcsUguiClickEvent evt)
        {
            SceneManager.LoadScene("LoadScreen");
        }

        [Preserve]
        [EcsUguiClickEvent("LoadGame")]
        void OnLoadGameClick(in EcsUguiClickEvent evt)
        {
            Debug.Log("Load Game Clicked");
        }

        [Preserve]
        [EcsUguiClickEvent("Settings")]
        void OnSettingsClick(in EcsUguiClickEvent evt)
        {
            //_settingsCanvas.SetActive(true);
        }

        [Preserve]
        [EcsUguiClickEvent("Exit")]
        void OnExitClick(in EcsUguiClickEvent evt)
        {
            Application.Quit();
        }
        [Preserve]
        [EcsUguiClickEvent("Button")]
        void OnButtonClick(in EcsUguiClickEvent evt)
        {
            Debug.Log("Load Game Clicked");
        }
        
        /*public void Init (IEcsSystems systems) {
            
        }*/
    }
}

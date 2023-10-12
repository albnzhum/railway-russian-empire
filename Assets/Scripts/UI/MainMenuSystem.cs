using Leopotam.EcsLite.Unity.Ugui;
using UnityEngine.SceneManagement;
using UnityEngine.Scripting;
using Leopotam.EcsLite;
using Client;
using UnityEngine;

namespace UI
{
    public class MainMenuSystem : EcsUguiCallbackSystem
    {
        private EcsFilter _settingsFilter;

        [Preserve]
        [EcsUguiClickEvent(Idents.MainMenu.NewGame)]
        void OnNewGameClick(in EcsUguiClickEvent evt)
        {
            SceneManager.LoadScene("LoadScreen");
        }

        [Preserve]
        [EcsUguiClickEvent(Idents.MainMenu.LoadGame)]
        void OnLoadGameClick(in EcsUguiClickEvent evt)
        {
            Debug.Log("Load Game Clicked");
        }

        [Preserve]
        [EcsUguiClickEvent(Idents.MainMenu.Settings)]
        void OnSettingsClick(in EcsUguiClickEvent evt)
        {
            ViewManager.Show<SettingsScreen>();
        }

        [Preserve]
        [EcsUguiClickEvent(Idents.MainMenu.Exit)]
        void OnExitClick(in EcsUguiClickEvent evt)
        {
            Application.Quit();
        }
    }
}

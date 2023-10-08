using System.Collections.Generic;
using JimboA.Plugins.FrameworkExtensions;
using JimboA.Plugins;
using Leopotam.EcsLite;
using UnityEngine;
using UnityEngine.UI;

namespace UI
{
    public interface IScreen
    {
        public void Init(EcsWorld world);
        public void Show(EcsWorld world);
        public void Hide(EcsWorld world);
        public void Activate(EcsWorld world);
        public void Deactivate(EcsWorld world);
    }
    
    public class ScreenBase : MonoBehaviour, IScreen
    {
        protected List<Selectable> Selectables = new List<Selectable>();

        public void Init(EcsWorld world)
        {
            GetComponentsInChildren<Selectable>(Selectables);
        }

        public void Show(EcsWorld world)
        {
            gameObject.SetActive(true);
        }

        public void Hide(EcsWorld world)
        {
            gameObject.SetActive(false);
        }

        public void Activate(EcsWorld world)
        {
            foreach (var selectable in Selectables)
            {
                selectable.interactable = true;
            }
        }

        public void Deactivate(EcsWorld world)
        {
            foreach (var selectable in Selectables)
            {
                selectable.interactable = false;
            }
        }
        
        protected virtual void OnInit(EcsWorld world) {}
        protected virtual void OnShow(EcsWorld world) {}
        protected virtual void OnHide(EcsWorld world) {}
    }

    public static class ScreenExtensions
    {
        public static void BindScreen<TScreen>(this TScreen screen, EcsWorld world, int entity)
            where TScreen : ScreenBase
        {
            world.Add<MonoLink<TScreen>>(entity).Value = screen;
        }
    }
}

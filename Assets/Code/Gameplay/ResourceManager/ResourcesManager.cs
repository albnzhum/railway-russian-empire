using Railway.Components;
using Railway.Gameplay.UI;
using UnityEngine;
using UnityEditor;

namespace Railway.Gameplay
{
    public class ResourcesManager : MonoBehaviour
    {
        [SerializeField] private MissionInitializer _mission;

        public static ResourcesManager Instance;

        private void OnEnable()
        {
            Instance = this;

#if UNITY_EDITOR
            EditorApplication.quitting += OnEditorQuit;
#endif
        }

        private void OnDisable()
        {
#if UNITY_EDITOR
            EditorApplication.quitting -= OnEditorQuit;
#endif
        }

        private void OnApplicationQuit()
        {
            ResetResources();
        }

#if UNITY_EDITOR
        private void OnEditorQuit()
        {
            ResetResources();
        }
#endif

        private void ResetResources()
        {
            _mission.CurrentResources = new MissionInitializer.Resources(_mission.OriginalResources);
        }

        public void Add(ResourceType resourceType, float amount)
        {
            _mission.GetAddedReactiveProperty(resourceType).Value += amount;
        }

        public void Spend(ResourceType resourceType, float amount)
        {
            var resourceProperty = _mission.GetCurrentReactiveProperty(resourceType);
            resourceProperty.Value = Mathf.Max(resourceProperty.Value - amount, 0f);
        }
    }
}
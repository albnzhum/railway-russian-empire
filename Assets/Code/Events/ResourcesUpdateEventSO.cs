using Railway.Components;
using UnityEngine;
using UnityEngine.Events;
using Resources = Railway.Components.MissionInitializer.Resources;

namespace Railway.Events
{
    [CreateAssetMenu(fileName = "New Resources Update Event", menuName = "Events/Resources Update Event")]
    public class ResourcesUpdateEventSO : ScriptableObject
    {
        public event UnityAction<Resources> OnResourcesUpdated;

        public void RaiseEvent(Resources resources)
        {
            if (OnResourcesUpdated != null)
            {
                OnResourcesUpdated.Invoke(resources);
            }
            else
            {
                Debug.LogWarning("Nobody picked it up");
            }
        }
    }
}

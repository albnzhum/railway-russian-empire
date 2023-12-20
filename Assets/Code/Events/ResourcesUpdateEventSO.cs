using Railway.Components;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Events
{
    [CreateAssetMenu(fileName = "New Resources Update Event", menuName = "Events/Resources Update Event")]
    public class ResourcesUpdateEventSO : ScriptableObject
    {
        public event UnityAction<MissionInitializer.Resources> OnResourcesUpdated;

        public void RaiseEvent(MissionInitializer.Resources resources)
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

using UnityEngine;
using UnityEngine.Events;

namespace Railway.Events
{
    [CreateAssetMenu(menuName = "Events/Bool Event Channel")]
    public class BoolEventChannelSO : ScriptableObject
    {
        public event UnityAction<bool> OnEventRaised;

        public void RaiseEvent(bool value)
        {
            if (OnEventRaised != null)
                OnEventRaised.Invoke(value);
        }
    }
}
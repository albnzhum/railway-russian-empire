using UnityEngine;
using UnityEngine.Events;

namespace Railway.Events
{
    [CreateAssetMenu(menuName = "Events/Float Event Channel")]
    public class FloatEventChannelSO : ScriptableObject
    {
        public UnityAction<float> OnEventRaised;

        public void RaiseEvent(float value)
        {
            if (OnEventRaised != null)
                OnEventRaised.Invoke(value);
        }
    }
}
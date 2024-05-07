using UnityEngine;
using UnityEngine.Events;

namespace Railway.Events
{
    [CreateAssetMenu(fileName = "New Int Event", menuName = "Events/Int Event Channel")]
    public class IntEventChannel : ScriptableObject
    {
        public UnityAction<int> OnEventRaised;

        public void RaiseEvent(int value)
        {
            if (OnEventRaised != null)
            {
                OnEventRaised.Invoke(value);
            }
        }
    }
}
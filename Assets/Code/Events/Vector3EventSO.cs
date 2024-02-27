using UnityEngine;
using UnityEngine.Events;

namespace Railway.Events
{
    [CreateAssetMenu(fileName = "New Vector3 Event", menuName = "Events/Vector3 Event Channel")]
    public class Vector3EventSO : ScriptableObject
    {
        public event UnityAction<Vector3> OnEventRaised;

        public void RaiseEvent(Vector3 value)
        {
            if (OnEventRaised != null)
            {
                OnEventRaised.Invoke(value);
            }
        }
    }
}

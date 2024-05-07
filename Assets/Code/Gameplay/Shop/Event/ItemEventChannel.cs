using Railway.Shop.Data;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Events
{
    [CreateAssetMenu(fileName = "New Item Event Channel", menuName = "Events/Item Event")]
    public class ItemEventChannel : ScriptableObject
    {
        public UnityAction<ShopItem> OnEventRaised;

        public void RaiseEvent(ShopItem item)
        {
            if (OnEventRaised != null)
            {
                OnEventRaised.Invoke(item);
            }
            else
            {
                Debug.Log("Nobody picked it up");
            }
        }
    }
}
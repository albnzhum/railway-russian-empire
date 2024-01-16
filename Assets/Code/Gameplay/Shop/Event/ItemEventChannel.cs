using Railway.Shop.Data;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Events
{
    public class ItemEventChannel : ScriptableObject
    {
        public UnityAction<ShopItem> OnEventRaised;

        public void RaiseEvent(ShopItem item)
        {
            if (OnEventRaised != null)
            {
                OnEventRaised.Invoke(item);
            }
        }
    }
}

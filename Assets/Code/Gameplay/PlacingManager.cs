using Railway.Events;
using Railway.Input;
using Railway.Shop.Data;
using TGS;
using UnityEngine;

namespace Railway.Gameplay
{
    public class PlacingManager : MonoBehaviour
    {
        [SerializeField] private ItemEventChannel _useItemEventChannel;
        [SerializeField] private InputReader _inputReader;
        
        private void OnEnable()
        {
            _useItemEventChannel.OnEventRaised += PlaceItem;
        }

        private void OnDisable()
        {
            _useItemEventChannel.OnEventRaised -= PlaceItem;
        }

        private void PlaceItem(ShopItem itemToPlace)
        {
            if (itemToPlace != null)
            {
                GameObject item = Instantiate(itemToPlace.Prefab);
                DragAndDropItem.RaiseEvent(item, true);
            }
        }
    }
}

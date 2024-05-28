using Railway.Shop.Data;

namespace Railway.Gameplay
{
    public class ItemData 
    {
        private ShopItem _currentItem;
        private IPlaceable _currentPlacer;

        public ShopItem CurrentItem => _currentItem;
        public IPlaceable CurrentPlacer => _currentPlacer;

        public void SetCurrentItem(ShopItem itemToPlace)
        {
            if (itemToPlace != null)
            {
                _currentItem = itemToPlace;
                _currentPlacer = itemToPlace.Prefab.GetComponent<IPlaceable>();
            }
        }

        public void ResetItem()
        {
            _currentItem = null;
            _currentPlacer = null;
        }
    }
}
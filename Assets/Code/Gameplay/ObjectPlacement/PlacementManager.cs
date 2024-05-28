using Railway.Gameplay.UI;
using Railway.Shop.Data;
using TGS;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Gameplay
{
    public class PlacementManager
    {
        private Wagon previousWagon;
        
        private PlacementManager(TerrainGridSystem tgs)
        {
            _tgs = tgs;
        }

        private static PlacementManager _instance;

        public static PlacementManager Instance(TerrainGridSystem tgs)
        {
            if (_instance == null)
            {
                _instance = new PlacementManager(tgs);
            }

            return _instance;
        }

        private bool _isFirstRail = false;
        
        private TerrainGridSystem _tgs;

        public void PlaceItem(Cell startCell, Cell currentCell, ItemData _itemData)
        {
            ResourcesManager.Instance.Spend(ResourceType.Gold, _itemData.CurrentItem.Price);

            var cellPosition = _tgs.CellGetPosition(currentCell);

            _itemData.CurrentPlacer.Place(currentCell);

            switch (_itemData.CurrentItem.ItemType.Type)
            {
                case ItemType.Rails:

                    if (!_isFirstRail)
                    {
                        Vector3 position = _tgs.CellGetPosition(startCell);
                        RailBuilder.Instance.Build(position);

                        _isFirstRail = true;
                    }

                    RailBuilder.Instance.Build(cellPosition);
                    break;

                case ItemType.Locomotive:
                case ItemType.Carriage:

                    AddWagonToTrain(_itemData.CurrentPlacer.Prefab.GetComponentInChildren<Wagon>());
                    break;
            }
        }
        
        private void AddWagonToTrain(Wagon newWagon)
        {
            if (previousWagon == null)
            {
                previousWagon = newWagon;
            }
            else
            {
                previousWagon.back = newWagon;

                if (!newWagon.isEngine)
                {
                    newWagon.front = previousWagon;
                    newWagon.SetupRecursively(previousWagon);
                }
                else
                {
                    newWagon.SetupRecursively(null);
                }

                previousWagon = newWagon;
            }
        }
    }
}
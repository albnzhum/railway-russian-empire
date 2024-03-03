using System.Collections.Generic;
using System.Linq;
using R3;
using Railway.Events;
using Railway.Gameplay.Resources;
using Railway.Gameplay.UI;
using Railway.Input;
using Railway.Shop.Data;
using TGS;
using UnityEngine;

namespace Railway.Gameplay
{
    /// <summary>
    /// Отвечает за размещение купленного предмета
    /// </summary>
    public class PlacementManager : MonoBehaviour
    {
        [SerializeField] private InputReader _inputReader;
        [SerializeField] private GameStateSO _gameState;
        [SerializeField] private ItemEventChannel _useItemEvent;

        [SerializeField] private CellEnterEventSO _cellEnter;
        [SerializeField] private Camera _camera;
        [SerializeField] private PlacingObject _startGO;

        private TerrainGridSystem _tgs;

        private Cell _currentCell;
        private ShopItem _currentItem;
        private GameObject _currentItemGO;

        private bool isPlacing = false;

        private CompositeDisposable _disposable = new CompositeDisposable();

        private List<Cell> _availableCell = new List<Cell>();
        Dictionary<ItemType, List<Cell>> _occupiedCells = new Dictionary<ItemType, List<Cell>>();
        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;

            _useItemEvent.OnEventRaised += SetCurrentItem;

            var chooseItemPositionStream = Observable.FromEvent<Vector2>(
                handler => _inputReader.PlaceItemEvent += handler,
                handler => _inputReader.PlaceItemEvent -= handler);

            var placeItemStream = Observable.FromEvent<Vector2>(
                    handler => _inputReader.PlaceItemEvent += handler,
                    handler => _inputReader.PlaceItemEvent -= handler)
                .Where(_ => UnityEngine.Input.GetMouseButtonDown(0));

            chooseItemPositionStream
                .Subscribe(OnChooseItemPosition)
                .AddTo(_disposable);

            placeItemStream
                .Subscribe(PlaceItem)
                .AddTo(_disposable);
        }

        private void OnDisable()
        {
            _useItemEvent.OnEventRaised -= SetCurrentItem;
            _occupiedCells.Clear();
            _disposable.Dispose();
        }

        private void PlaceWorkers()
        {
            if (_currentCell.tag == (int)CellBuildingType.Building)
            {
                if (_currentCell == null) return;

                _tgs.CellSetTag(_currentCell, (int)CellBuildingType.Workers);

                ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);
                ResourcesManager.Instance.Add(ResourceType.Workers, _currentItem.Amount);

                _tgs.CellSetCanCross(_tgs.CellGetIndex(_currentCell), false);

                var cellPosition = _tgs.CellGetPosition(_currentCell);
                Instantiate(_currentItem.Prefab, cellPosition, Quaternion.identity);

                _occupiedCells[_currentItem.ItemType.ItemType].Add(_currentCell);
            }
            else
            {
                Debug.LogError("Workers can't be placing!");
            }

            StopPlacing();
        }

        private void PlaceRails()
        {
            if (_currentCell == null) return;

            _tgs.CellSetTag(_currentCell, (int)CellBuildingType.Rails);

            ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);

            _tgs.CellSetCanCross(_tgs.CellGetIndex(_currentCell), false);

            var cellPosition = _tgs.CellGetPosition(_currentCell);
            
            RailBuilder.Instance.Build(cellPosition);

            _occupiedCells[_currentItem.ItemType.ItemType].Add(_currentCell);

            StopPlacing();
        }

        private void PlaceBuilding()
        {
            if (_currentCell == null) return;

            _tgs.CellSetTag(_currentCell, (int)CellBuildingType.Building);

            ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);

            _tgs.CellSetCanCross(_tgs.CellGetIndex(_currentCell), false);

            var cellPosition = _tgs.CellGetPosition(_currentCell);
            Instantiate(_currentItem.Prefab, cellPosition, Quaternion.identity);

            _occupiedCells[_currentItem.ItemType.ItemType].Add(_currentCell);

            StopPlacing();
        }

        private void PlaceItem(Vector2 mousePosition)
        {
            if (_currentCell == null) return;

            if (_currentCell.tag == 0)
            {
                if (_availableCell.Contains(_currentCell))
                {
                    switch (_currentItem.ItemType.ItemType)
                    {
                        case ItemType.Workers:
                            PlaceWorkers();
                            break;
                        case ItemType.Rails:
                            PlaceRails();
                            break;
                        case ItemType.Building:
                            PlaceBuilding();
                            break;
                    }
                }
            }
        }

        /// <summary>
        /// Управляет позицией предмета
        /// </summary>
        /// <param name="mousePosition"></param>
        private void OnChooseItemPosition(Vector2 mousePosition)
        {
            if (isPlacing)
            {
                Ray ray = _camera.ScreenPointToRay(mousePosition);

                RaycastHit hit;
                if (Physics.Raycast(ray, out hit))
                {
                    _currentCell = DetermineCell(hit.point);
                }
            }
        }

        /// <summary>
        /// Отмена покупки предмета
        /// </summary>
        private void StopPlacing()
        {
            if (isPlacing)
            {
                isPlacing = false;

                foreach (var cell in _availableCell)
                {
                    int index = _tgs.CellGetIndex(cell);
                    _tgs.CellToggleRegionSurface(index, false, Color.green);
                }

                _availableCell.Clear();

                _currentItem = null;
                _currentCell = null;

                _gameState.UpdateGameState(GameState.Gameplay);
                _inputReader.EnableGameplayInput();
            }
        }

        private void GetCellNeighbours()
        {
            if (!_occupiedCells.TryGetValue(_currentItem.ItemType.ItemType, out var cells))
            {
                _occupiedCells[_currentItem.ItemType.ItemType] = new List<Cell>();
                cells = _occupiedCells[_currentItem.ItemType.ItemType];
            }

            _availableCell = cells.Any() ? _tgs.CellGetNeighbours(cells.Last()) : _tgs.CellGetNeighbours(_startGO.CellIndex);

            foreach (var cell in _availableCell)
            {
                int index = _tgs.CellGetIndex(cell);
                _tgs.CellToggleRegionSurface(index, true, Color.green);
            }
        }


        /// <summary>
        /// Устанавливает текущий предмет
        /// </summary>
        /// <param name="_item"></param>
        private void SetCurrentItem(ShopItem _item)
        {
            if (_item != null)
            {
                _currentItem = _item;
                isPlacing = true;

                GetCellNeighbours();
            }
        }

        private Cell DetermineCell(Vector3 position)
        {
            return _tgs.CellGetAtPosition(position, true);
        }
    }
}
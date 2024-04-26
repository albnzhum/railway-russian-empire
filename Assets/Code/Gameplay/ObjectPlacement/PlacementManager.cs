using System;
using System.Collections.Generic;
using System.Linq;
using Dreamteck.Splines;
using R3;
using Railway.Events;
using Railway.Gameplay.Resources;
using Railway.Gameplay.UI;
using Railway.Input;
using Railway.Shop.Data;
using TGS;
using Unity.Collections;
using UnityEngine;
using UnityEngine.Serialization;

namespace Railway.Gameplay
{
    /// <summary>
    /// Отвечает за размещение купленного предмета
    /// </summary>
    public class PlacementManager : MonoBehaviour
    {
        [ReadOnly] [SerializeField] private InputReader _inputReader;
        [SerializeField] private GameStateSO gameState;
        [SerializeField] private ItemEventChannel useItemEvent;

        [SerializeField] private Camera _camera;
        [ReadOnly] [SerializeField] private PlacingObject _startGO;
        [SerializeField] private GameObject _particleSystem;

        private TerrainGridSystem _tgs;

        private Cell _currentCell;
        private ShopItem _currentItem;
        private GameObject _currentItemGO;

        private bool _isPlacing = false;

        private CompositeDisposable _disposable = new CompositeDisposable();

        private Cell[] _availableCell = new Cell[15];
        private Dictionary<ItemType, List<Cell>> _occupiedCells = new Dictionary<ItemType, List<Cell>>();

        private bool _isFirstRail = false;

        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;

            useItemEvent.OnEventRaised += SetCurrentItem;

            var chooseItemPositionStream = Observable.FromEvent<Vector2>(
                handler => _inputReader.PlaceItemEvent += handler,
                handler => _inputReader.PlaceItemEvent -= handler);

            _inputReader.OnCancelEvent += StopPlacing;

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
            useItemEvent.OnEventRaised -= SetCurrentItem;
            _occupiedCells.Clear();
            _disposable.Dispose();
        }

        //TODO: скрипт workers 
        private void PlaceWorkers()
        {
            if (_currentCell.tag == (int)CellBuildingType.Building)
            {
                _tgs.CellSetTag(_currentCell, (int)CellBuildingType.Workers);

                ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);
                ResourcesManager.Instance.Add(ResourceType.Workers, _currentItem.Amount);

                _tgs.CellSetCanCross(_tgs.CellGetIndex(_currentCell), false);

                var cellPosition = _tgs.CellGetPosition(_currentCell);
                Instantiate(_currentItem.Prefab, cellPosition, Quaternion.identity);

                GameObject ps = Instantiate(_particleSystem, cellPosition, Quaternion.identity);
                ps.transform.position = cellPosition;

                _occupiedCells[_currentItem.TabType.ItemType].Add(_currentCell);
            }
            else
            {
                Debug.LogError("Workers can't be placing!");
            }

            StopPlacing();
        }

        //TODO:  как проверить конец пути
        private void PlaceRails()
        {
            _tgs.CellSetTag(_currentCell, (int)CellBuildingType.Rails);

            ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);

            _tgs.CellSetCanCross(_tgs.CellGetIndex(_currentCell), false);

            var cellPosition = _tgs.CellGetPosition(_currentCell);

            if (!_isFirstRail)
            {
                RailBuilder.Instance.Build(_startGO.transform.position);

                _isFirstRail = true;
            }

            RailBuilder.Instance.Build(cellPosition);

            _occupiedCells[_currentItem.TabType.ItemType].Add(_currentCell);

            StopPlacing();
        }

        //TODO: отдельный building скрипт, для управления ресурсами получаемыеми от здания
        private void PlaceBuilding()
        {
            _tgs.CellSetTag(_currentCell, (int)CellBuildingType.Building);

            ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);

            _tgs.CellSetCanCross(_tgs.CellGetIndex(_currentCell), false);

            var cellPosition = _tgs.CellGetPosition(_currentCell);
            
            Instantiate(_currentItem.Prefab, cellPosition, Quaternion.identity);

            GameObject ps = Instantiate(_particleSystem, cellPosition, Quaternion.identity);
            ps.transform.position = cellPosition;

            _occupiedCells[_currentItem.TabType.ItemType].Add(_currentCell);

            StopPlacing();
        }

        private Wagon previousWagon;
        private void PlaceCarriage()
        {
            if (_currentCell.tag == (int)CellBuildingType.Rails)
            {
                ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);

                var cellPosition = _tgs.CellGetPosition(_currentCell);
                var currentWagon = Instantiate(_currentItem.Prefab, cellPosition, Quaternion.identity);
                
                currentWagon.GetComponentInChildren<SplinePositioner>().spline = RailBuilder.Instance.spline;

                if (previousWagon == null) 
                    previousWagon = currentWagon.GetComponentInChildren<Wagon>();
                else
                {
                    previousWagon.back = currentWagon.GetComponentInChildren<Wagon>();
                    currentWagon.GetComponentInChildren<Wagon>().front = previousWagon;
                }

                GameObject ps = Instantiate(_particleSystem, cellPosition, Quaternion.identity);
                ps.transform.position = cellPosition;

                _occupiedCells[_currentItem.TabType.ItemType].Add(_currentCell);
            }
            else
            {
                Debug.LogError("Carriage can't be placing!");
            }

            StopPlacing();
        }

        private void PlaceLocomotive()
        {
            if (_currentCell.tag == (int)CellBuildingType.Rails)
            {
                ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);

                var cellPosition = _tgs.CellGetPosition(_currentCell);
                
                var locomotive = Instantiate(_currentItem.Prefab, cellPosition, Quaternion.identity);
                locomotive.GetComponentInChildren<SplineFollower>().spline = RailBuilder.Instance.spline;
                
                if (previousWagon == null) 
                    previousWagon = locomotive.GetComponentInChildren<Wagon>();
                else
                {
                    previousWagon.back = locomotive.GetComponentInChildren<Wagon>();
                }

                var ps = Instantiate(_particleSystem, cellPosition, Quaternion.identity);
                
                ps.transform.position = cellPosition;

                _occupiedCells[_currentItem.TabType.ItemType].Add(_currentCell);
            }
            else
            {
                Debug.LogError("Locomotive can't be placing!");
            }

            StopPlacing();
        }

        private void PlaceItem(Vector2 mousePosition)
        {
            if (_currentCell == null) return;

            if (_currentCell.tag == 1) return;
            
            if (_availableCell.Contains(_currentCell))
            {
                switch (_currentItem.TabType.ItemType)
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
                    case ItemType.Carriage:
                        PlaceCarriage();
                        break;
                    case ItemType.Locomotive:
                        PlaceLocomotive();
                        break;
                }
            }
        }

        /// <summary>
        /// Управляет позицией предмета
        /// </summary>
        /// <param name="mousePosition"></param>
        private void OnChooseItemPosition(Vector2 mousePosition)
        {
            if (_isPlacing)
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
            if (_isPlacing)
            {
                _isPlacing = false;
                
                foreach (var cell in _availableCell)
                {
                    int index = _tgs.CellGetIndex(cell);
                    _tgs.CellToggleRegionSurface(index, false, Color.green);
                }

                Array.Clear(_availableCell, 0, _availableCell.Length);

                _currentItem = null;
                _currentCell = null;

                gameState.UpdateGameState(GameState.Gameplay);
                _inputReader.EnableGameplayInput();
            }
        }

        private void GetCellNeighbours()
        {
            if (!_occupiedCells.TryGetValue(_currentItem.TabType.ItemType, out var cells))
            {
                _occupiedCells[_currentItem.TabType.ItemType] = new List<Cell>();
                cells = _occupiedCells[_currentItem.TabType.ItemType];
            }

            switch (_currentItem.TabType.ItemType)
            {
                case ItemType.Locomotive:
                    _availableCell = _tgs.Cells
                        .Where(x => _tgs.CellGetTag(_tgs.CellGetIndex(x)) == (int)CellBuildingType.Rails).ToArray();
                    break;
                case ItemType.Workers:
                    _availableCell = _tgs.Cells
                        .Where(x => _tgs.CellGetTag(_tgs.CellGetIndex(x)) == (int)CellBuildingType.Building).ToArray();
                    break;
                case ItemType.Carriage:
                    _availableCell = _tgs.Cells
                        .Where(x => _tgs.CellGetTag(_tgs.CellGetIndex(x)) == (int)CellBuildingType.Rails).ToArray();
                    break;
                default:
                    _availableCell = cells.Any()
                        ? _tgs.CellGetNeighbours(cells.Last()).Where(cell => cell.canCross).ToArray()
                        : _tgs.CellGetNeighbours(_startGO.CellIndex).Where(cell => cell.canCross).ToArray();
                    break;
            }

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
                _isPlacing = true;

                GetCellNeighbours();
            }
        }

        private Cell DetermineCell(Vector3 position)
        {
            return _tgs.CellGetAtPosition(position, true);
        }
    }
}
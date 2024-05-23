using System;
using System.Collections.Generic;
using System.Linq;
using Dreamteck.Splines;
using R3;
using Railway.Events;
using Railway.Gameplay.UI;
using Railway.Input;
using Railway.Shop.Data;
using TGS;
using Unity.Collections;
using UnityEngine;

namespace Railway.Gameplay
{
    /// <summary>
    /// Отвечает за размещение купленного предмета
    /// </summary>
    public class ItemPlacement : MonoBehaviour
    {
        [Header("Gameplay")]
        [ReadOnly] [SerializeField] private InputReader _inputReader;
        [SerializeField] private GameStateSO gameState;
        [SerializeField] private ItemEventChannel useItemEvent;

        [Header("Scene Object")]
        [SerializeField] private Camera _camera;
        [ReadOnly] [SerializeField] private NonInteractableObject _startGO;
        [SerializeField] private GameObject _particleSystem;

        private TerrainGridSystem _tgs;

        private Cell _currentCell;
        private ShopItem _currentItem;
        private IPlaceable _currentPlacer;

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

        private Wagon previousWagon;

        private void PlaceItem()
        {
            ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);

            var cellPosition = _tgs.CellGetPosition(_currentCell);

            _currentPlacer.Place(_currentCell);

            switch (_currentItem.ItemType.ItemType)
            {
                case ItemType.Rails:

                    if (!_isFirstRail)
                    {
                        RailBuilder.Instance.Build(_startGO.transform.position);

                        _isFirstRail = true;
                    }

                    RailBuilder.Instance.Build(cellPosition);
                    break;

                case ItemType.Locomotive:
                case ItemType.Carriage:

                    AddWagonToTrain(_currentPlacer.Prefab.GetComponentInChildren<Wagon>());
                    break;
            }

            var ps = Instantiate(_particleSystem, cellPosition, Quaternion.identity);

            ps.transform.position = cellPosition;

            _occupiedCells[_currentItem.ItemType.ItemType].Add(_currentCell);

            StopPlacing();
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

        private void PlaceItem(Vector2 mousePosition)
        {
            if (_currentCell == null) return;

            if (_currentCell.tag == (int)CellBuildingType.NON_INTERACTABLE) return;

            if (_availableCell.Contains(_currentCell))
            {
                PlaceItem();
            }
        }

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
            if (!_occupiedCells.TryGetValue(_currentItem.ItemType.ItemType, out var cells))
            {
                _occupiedCells[_currentItem.ItemType.ItemType] = new List<Cell>();
                cells = _occupiedCells[_currentItem.ItemType.ItemType];
            }

            switch (_currentItem.ItemType.ItemType)
            {
                case ItemType.Locomotive:
                    _availableCell = _tgs.Cells
                        .Where(x => _tgs.CellGetTag(_tgs.CellGetIndex(x)) == (int)CellBuildingType.RAILS).ToArray();
                    break;
                case ItemType.Workers:
                    _availableCell = _tgs.Cells
                        .Where(x => _tgs.CellGetTag(_tgs.CellGetIndex(x)) == (int)CellBuildingType.BUILD).ToArray();
                    break;
                case ItemType.Carriage:
                    _availableCell = _tgs.Cells
                        .Where(x => _tgs.CellGetTag(_tgs.CellGetIndex(x)) == (int)CellBuildingType.RAILS).ToArray();
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


        private void SetCurrentItem(ShopItem _item)
        {
            if (_item != null)
            {
                _currentItem = _item;
                _currentPlacer = _item.Prefab.GetComponent<IPlaceable>();
                _currentPlacer.TGS = _tgs;
                _currentPlacer.Prefab = _currentItem.Prefab;
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
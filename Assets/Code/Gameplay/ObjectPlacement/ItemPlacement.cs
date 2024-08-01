using System;
using System.Collections.Generic;
using System.Linq;
using R3;
using Railway.Events;
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
        private GameStateSO _gameState;
        [SerializeField] private ItemEventChannel useItemEvent;
        [SerializeField] private CellInputHandler inputHandler;

        [Header("Scene Object")] 
        [SerializeField] private Camera _camera;

        [SerializeField] [ReadOnly] private NonInteractableObject _startGO;
        [SerializeField] private GameObject _particleSystem;

        private ItemData _currentItemData;

        private TerrainGridSystem _tgs;

        private Cell _currentCell;
        private Cell _startCell;

        private Cell[] _availableCell = new Cell[15];
        private Dictionary<ItemType, List<Cell>> _occupiedCells = new Dictionary<ItemType, List<Cell>>();

        private CompositeDisposable _disposable = new CompositeDisposable();

        private NeighborFinder _neighborFinder;

        private bool _isPlacing = false;

        private void OnEnable()
        {
            useItemEvent.OnEventRaised += SetCurrentItem;

            inputHandler.OnChooseItemPositionStream
                .Subscribe(OnChooseItemPosition)
                .AddTo(_disposable);

            inputHandler.OnPlaceItemStream
                .Subscribe(PlaceItem)
                .AddTo(_disposable);

            inputHandler.OnStopItemPlacing += StopPlacing;
        }

        private void OnDisable()
        {
            useItemEvent.OnEventRaised -= SetCurrentItem;
            inputHandler.OnStopItemPlacing -= StopPlacing;

            _occupiedCells.Clear();
            _disposable.Dispose();
        }

        private void Start()
        {
            _startCell = _tgs.CellGetAtPosition(_startGO.transform.position);
            _currentItemData = new ItemData();
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

        private void PlaceItem()
        {
            PlacementManager.Instance(_tgs).PlaceItem(_startCell, _currentCell, _currentItemData);
            
            var cellPosition = _tgs.CellGetPosition(_currentCell);
            
            var ps = Instantiate(_particleSystem, cellPosition, Quaternion.identity);

            ps.transform.position = cellPosition;

            _occupiedCells[_currentItemData.CurrentItem.ItemType.Type].Add(_currentCell);

            StopPlacing();
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
                _neighborFinder.ClearHighlightedCells(_availableCell);

                Array.Clear(_availableCell, 0, _availableCell.Length);

                //Reset

                _gameState.UpdateGameState(GameState.Gameplay);
            }
        }

        private void SetCurrentItem(ShopItem _item)
        {
            if (_item != null)
            {
                _isPlacing = true;

                _availableCell = _neighborFinder.GetAvailableCell(_item, _startCell, _occupiedCells);

                _currentItemData.SetCurrentItem(_item);
            }
        }

        private Cell DetermineCell(Vector3 position)
        {
            return _tgs.CellGetAtPosition(position, true);
        }
    }
}
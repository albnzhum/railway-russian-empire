using System;
using System.Collections;
using Code.Gameplay;
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

        private TerrainGridSystem _tgs;
        
        private Cell _currentCell;
        private ShopItem _currentItem;
        private GameObject _currentItemGO;
        
        private bool isPlacing = false;

        private CompositeDisposable _disposable = new CompositeDisposable();
        
        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;
            
            _useItemEvent.OnEventRaised += SetCurrentItem;

            _inputReader.OnCancelEvent += CancelPlaceItem;

            var chooseItemPositionHandler = Observable.FromEvent<Vector2>
            (handler => _inputReader.ChooseItemPositionEvent += handler,
                handler => _inputReader.ChooseItemPositionEvent -= handler);

            var placeItemHandler = Observable.FromEvent(
                handler => _inputReader.PlaceItemEvent += handler,
                handler => _inputReader.PlaceItemEvent -= handler);

            chooseItemPositionHandler
                 .Subscribe(OnChooseItemPosition)
                 .AddTo(_disposable);
            
            placeItemHandler
                 .ThrottleLast(TimeSpan.FromSeconds(2))
                 .Subscribe(PlaceItem)
                 .AddTo(_disposable);
        }

        private void OnDisable()
        {
            _useItemEvent.OnEventRaised -= SetCurrentItem;

            _inputReader.OnCancelEvent -= CancelPlaceItem;
            _disposable.Dispose();
        }

        //TODO: позиция объекта управляется с помощью мыши - при нажатии всплывает окно подтвердить/нет
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
                    Cell _cell = DetermineCell(hit.point);

                    if (_cell != null)
                    {
                        if (_cell.tag != (int)CellBuildingType.NonInteractable &
                            _cell.tag != (int)CellType.SlopeAndWater & _cell.canCross)
                        {
                            _currentCell = _cell;
                            _currentItemGO.transform.position = _tgs.CellGetPosition(_cell);
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Отмена покупки предмета
        /// </summary>
        private void CancelPlaceItem()
        {
            if (isPlacing)
            {
                isPlacing = false;

                Destroy(_currentItemGO);

                _currentItem = null;
                _currentCell = null;

                _gameState.UpdateGameState(GameState.Gameplay);
                _inputReader.EnableGameplayInput();
            }
        }

        /// <summary>
        /// Размещает объект на клетке и в зависимости от типа итема присваивает тег клетке
        /// </summary>
        private void PlaceItem(Unit _unit)
        {
            if (isPlacing)
            {
                isPlacing = false;

                switch (_currentItem.ItemType.ItemType)
                {
                    case ItemType.Rails:
                        _tgs.CellSetTag(_currentCell, (int)CellBuildingType.Rails);
                        break;
                    case ItemType.Workers:
                        _tgs.CellSetTag(_currentCell, (int)CellBuildingType.Workers);
                        break;
                }
                
                ResourcesManager.Instance.Spend(ResourceType.Gold, _currentItem.Price);

                _tgs.CellSetCanCross(_tgs.CellGetIndex(_currentCell), false);

                _currentItemGO = null;
                _currentItem = null;
                _currentCell = null;

                _gameState.UpdateGameState(GameState.Gameplay);
                _inputReader.EnableGameplayInput();
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

                GameObject go = Instantiate(_currentItem.Prefab);
                _currentItemGO = go;
            }
        }

        private Cell DetermineCell(Vector3 position)
        {
            return _tgs.CellGetAtPosition(position, true);
        }
    }
}
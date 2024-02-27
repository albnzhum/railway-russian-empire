using System.Collections;
using Railway.Events;
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
        
        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;
            _useItemEvent.OnEventRaised += SetCurrentItem;

            _inputReader.OnCancelEvent += CancelPlaceItem;
            _inputReader.ChooseItemPositionEvent += OnChooseItemPosition;
        }

        private void OnDisable()
        {
            _useItemEvent.OnEventRaised -= SetCurrentItem;

            _inputReader.OnCancelEvent -= CancelPlaceItem;
            _inputReader.ChooseItemPositionEvent -= OnChooseItemPosition;
            _inputReader.PlaceItemEvent -= PlaceItem;
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

                StartCoroutine(EnablePlaceItem());
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

        IEnumerator EnablePlaceItem()
        {
            yield return new WaitForSeconds(2f);
            _inputReader.PlaceItemEvent += PlaceItem;
        }
        
        /// <summary>
        /// Размещает объект на клетке и в зависимости от типа итема присваивает тег клетке
        /// </summary>
        private void PlaceItem()
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

                _tgs.CellSetCanCross(_tgs.CellGetIndex(_currentCell), false);

                _currentItemGO = null;
                _currentItem = null;
                _currentCell = null;

                _gameState.UpdateGameState(GameState.Gameplay);
                _inputReader.EnableGameplayInput();
                
                _inputReader.PlaceItemEvent -= PlaceItem;
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
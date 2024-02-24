using System;
using Railway.Gameplay;
using Railway.Input;
using TGS;
using UnityEngine;

public class MouseInputSystem : MonoBehaviour
{
    [SerializeField] private InputReader _inputReader;
    [SerializeField] private Camera _camera;
    
    [Header("Listening to")]
    [SerializeField] private CellEnterEventSO _cellEnterEvent;
    [SerializeField] private CellExitEventSO _cellExitEvent;
    [SerializeField] private CellClickedEventSO _cellClickedEvent;

    private static TerrainGridSystem _tgs;
    public static MouseInputSystem Instance { get; private set; }

    private Cell _currentCell;

    public Cell CurrentCell
    {
        get => _currentCell; 
        private set => _currentCell = value;
    }

    private int _currentCellIndex = -1;
    public int CurrentCellIndex
    {
        get => _tgs.CellGetIndex(_currentCell);
        private set => _currentCellIndex = value;
    }

    private void OnEnable()
    {
        Instance = this;
        _tgs = TerrainGridSystem.Instance;

        _inputReader.ChooseCellEvent += ChooseCell;
        _inputReader.PlaceItemEvent += PlaceItem;
    }

    private void OnDisable()
    {
        _inputReader.ChooseCellEvent -= ChooseCell;
        _inputReader.PlaceItemEvent -= PlaceItem;
    }
    
    private void PlaceItem(Vector2 mousePosition)
    {
        Ray ray = _camera.ScreenPointToRay(mousePosition);

        RaycastHit hit;
        if (Physics.Raycast(ray, out hit))
        {
            Cell _cell = DetermineCell(hit.point);
            if (_cell != null)
            {
                if (_cell != _currentCell)
                {
                    if (_currentCell != null)
                    {
                        _cellExitEvent.RaiseEvent();
                    }

                    _currentCell = _cell;
                    _cellEnterEvent.RaiseEvent();
                }
            }
            else
            {
                if (_currentCell != null)
                {
                    _cellExitEvent.RaiseEvent();
                    _currentCell = null;
                }
            }
        }
    }
    
    private void ChooseCell(Vector2 mousePosition)
    {
        Ray ray = _camera.ScreenPointToRay(mousePosition);

        RaycastHit hit;
        if (Physics.Raycast(ray, out hit))
        {
            Cell _cell = DetermineCell(hit.point);
            if (_cell != null)
            {
                _cellClickedEvent.RaiseEvent();
            }
        }
    }
    
    private Cell DetermineCell(Vector3 position)
    {
        return _tgs.CellGetAtPosition(position, true);
    }
}
using System.Collections;
using System.Collections.Generic;
using Railway.Input;
using TGS;
using UnityEngine;

public class MouseInputSystem : MonoBehaviour
{
    [SerializeField] private InputReader _inputReader;

    private static TerrainGridSystem _tgs;
    public static MouseInputSystem Instance { get; set; }

    private Cell _currentCell;

    private void Awake()
    {
        Instance = this;
    }

    private void OnEnable()
    {
        _inputReader.PlaceItemEvent += HandleCellPositionChanged;
    }

    private void OnDisable()
    {
        _inputReader.PlaceItemEvent -= HandleCellPositionChanged;
    }

    void Start()
    {
        _tgs = TerrainGridSystem.Instance;
    }

    private void HandleCellPositionChanged(Vector2 position)
    {
        Ray ray = Camera.main.ScreenPointToRay(position);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit))
        {
            Cell _cell = DetermineCell(hit.point);
            if (_cell != null)
            {
                _currentCell = _cell;
            }
        }
    }

    public Vector3 CellGetPosition()
    {
        return _tgs.CellGetPosition(_currentCell);
    }

    private Cell DetermineCell(Vector3 position)
    {
        return _tgs.CellGetAtPosition(position, true);
    }
}
using System;
using Railway.Events;
using Railway.Input;
using TGS;
using UnityEngine;

public class TerrainTrigger : MonoBehaviour
{
    public InputReader _inputReader;
    public static event Action<Vector3> OnCellPositionChanged;

    private TerrainGridSystem _tgs;
    public static TerrainTrigger Instance { get; private set; }

    private void Awake() 
    {
        if (Instance != null && Instance != this) 
        { 
            Destroy(this); 
        } 
        else 
        { 
            Instance = this; 
        } 
    }

    private void OnEnable()
    {
        _inputReader.ChooseCellEvent += ChooseCell;
    }

    private void OnDisable()
    {
        _inputReader.ChooseCellEvent -= ChooseCell;
    }

    private void Start()
    {
        if (GetComponent<TerrainCollider>() == null)
        {
            gameObject.AddComponent<TerrainCollider>();
        }

        _tgs = transform.GetComponentInChildren<TerrainGridSystem>();
        if (_tgs == null )
        {
            Debug.LogError("Missing Terrain Highlight System reference in Terrain Trigger script");
            DestroyImmediate(this);
        }
    }

    private void ChooseCell(Vector2 mousePosition)
    {
        Ray ray = Camera.main.ScreenPointToRay(mousePosition);
        
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit))
        {
            Cell _cell = DetermineCell(hit.point);
            if (_cell != null)
            {
                Vector3 cellPosition = _tgs.CellGetPosition(_cell);
                Debug.Log("Cell chosen at position: " + cellPosition);
                
                // Вызываем статическое событие для других скриптов
                OnCellPositionChanged?.Invoke(cellPosition);
            }
        }
        
        Debug.Log("Cell chosen");
    }
    
    private Cell DetermineCell(Vector3 position)
    {
        return _tgs.CellGetAtPosition(position, true);
    }
}

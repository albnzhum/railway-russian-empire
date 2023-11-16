using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TGS;
using UnityEngine;

public class CellTerrainType : MonoBehaviour
{

    enum CellType
    {
        Default = 1,
        SlopeAndWater = 2
    }
    
    private TerrainGridSystem _tgs;
    
    [SerializeField] private bool showHighlight;

    private List<Cell> cellsWithTag2;

    private void Start()
    {
        _tgs = TerrainGridSystem.Instance;

        foreach (var cell in _tgs.Cells)
        {
            Vector3 cellPosition = _tgs.CellGetPosition(cell);
            float terrainHeight = GetTerrainHeight(cellPosition);

            if (terrainHeight <= 0 || terrainHeight <= 6 || IsCellOnSteepSlope(cellPosition))
            {
                _tgs.CellSetTag(cell, (int)CellType.SlopeAndWater); 
                cell.CanCross = false;
                cellsWithTag2.Add(cell);
            }
            else
            {
                _tgs.CellSetTag(cell, (int)CellType.Default);
            }
        }
    }

    private void Update()
    { 
        if (showHighlight)
        {
            foreach (var cell in cellsWithTag2)
            {
                _tgs.CellToggleRegionSurface(_tgs.CellGetIndex(cell), true, Color.red, false);
            }
        }
        else
        {
            foreach (var cell in cellsWithTag2)
            {
                _tgs.CellToggleRegionSurface(_tgs.CellGetIndex(cell), false, Color.red, false);
            }
        }
    }

    float GetTerrainHeight(Vector3 worldPosition)
    {
        Vector3 terrainLocalPos = _tgs.Terrain.transform.InverseTransformPoint(worldPosition);
        float terrainHeight = _tgs.Terrain.SampleHeight(terrainLocalPos);

        return terrainHeight;
    }

    bool IsCellOnSteepSlope(Vector3 worldPosition)
    {
        float normalizedX = worldPosition.x / _tgs.Terrain.terrainData.size.x;
        float normalizedY = worldPosition.z / _tgs.Terrain.terrainData.size.z;
        float slopeAngle = _tgs.Terrain.terrainData.GetSteepness(normalizedX, normalizedY);
        return slopeAngle > 16.0f && slopeAngle < 80.0f;
    }
}
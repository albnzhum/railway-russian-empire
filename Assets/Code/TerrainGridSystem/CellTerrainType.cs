using System.Collections;
using System.Collections.Generic;
using TGS;
using UnityEngine;

public enum CellType
{
    Default = 6,
    SlopeAndWater = 1
}

public class CellTerrainType : MonoBehaviour
{
    private TerrainGridSystem _tgs;
    private Terrain _terrain;
    private TerrainData _terrainData;

    private int alphamapWidth;
    private int alphamapHeight;
    private float[,,] splatmapData;
    private int numTextures;

    private void Start()
    {
        _tgs = TerrainGridSystem.Instance;
        _terrain = _tgs.Terrain;
        _terrainData = _terrain.terrainData;

        alphamapWidth = _terrainData.alphamapWidth;
        alphamapHeight = _terrainData.alphamapHeight;
        splatmapData = _terrainData.GetAlphamaps(0, 0, alphamapWidth, alphamapHeight);
        numTextures = splatmapData.Length / (alphamapWidth * alphamapHeight);

        foreach (var cell in _tgs.Cells)
        {
            int cellLayerIndex = GetActiveTerrainTextureIdx(_tgs.CellGetPosition(cell));

            if (cellLayerIndex == 1)
            {
                _tgs.CellSetTag(cell, (int)CellType.SlopeAndWater);
            }
        }
    }

    private int GetActiveTerrainTextureIdx(Vector3 position)
    {
        Vector3 terrainCord = ConvertToSplatMapCoordinate(position);
        int activeTerrainIndex = 0;
        float largestOpacity = 0f;
        for (int i = 0; i < numTextures; i++)
        {
            if (largestOpacity < splatmapData[(int)terrainCord.z, (int)terrainCord.x, i])
            {
                activeTerrainIndex = i;
                largestOpacity = splatmapData[(int)terrainCord.z, (int)terrainCord.x, i];
            }
        }

        return activeTerrainIndex;
    }

    private Vector3 ConvertToSplatMapCoordinate(Vector3 position)
    {
        Vector3 splatPosition = new();
        Vector3 terPosition = _terrain.transform.position;
        splatPosition.x = ((position.x - terPosition.x) / _terrainData.size.x) * _terrainData.alphamapWidth;
        splatPosition.z = ((position.z - terPosition.z) / _terrainData.size.z) * _terrainData.alphamapHeight;
        return splatPosition;
    }
}
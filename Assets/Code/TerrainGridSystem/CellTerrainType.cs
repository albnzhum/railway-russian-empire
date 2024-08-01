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

    private int _alphamapWidth;
    private int _alphamapHeight;
    private float[,,] _splatmapData;
    private int _numTextures;

    private void Start()
    {
        _terrain = _tgs.Terrain;
        _terrainData = _terrain.terrainData;

        _alphamapWidth = _terrainData.alphamapWidth;
        _alphamapHeight = _terrainData.alphamapHeight;
        _splatmapData = _terrainData.GetAlphamaps(0, 0, _alphamapWidth, _alphamapHeight);
        _numTextures = _splatmapData.Length / (_alphamapWidth * _alphamapHeight);

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
        var activeTerrainIndex = 0;
        var largestOpacity = 0f;
        for (int i = 0; i < _numTextures; i++)
        {
            if (largestOpacity < _splatmapData[(int)terrainCord.z, (int)terrainCord.x, i])
            {
                activeTerrainIndex = i;
                largestOpacity = _splatmapData[(int)terrainCord.z, (int)terrainCord.x, i];
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
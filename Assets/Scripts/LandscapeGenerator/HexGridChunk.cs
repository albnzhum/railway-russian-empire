using System;
using UnityEngine;

namespace LandscapeGenerator
{
    public class HexGridChunk : MonoBehaviour
    {
        private HexCell[] cells;
        private HexMesh hexMesh;
        private Canvas gridCanvas;

        private void Awake()
        {
            gridCanvas = GetComponentInChildren<Canvas>();
            hexMesh = GetComponentInChildren<HexMesh>();

            cells = new HexCell[HexMetrics.chunkSizeX * HexMetrics.chunkSizeZ];
        }

        private void Start()
        {
            hexMesh.Triangulate(cells);
        }
    }
}

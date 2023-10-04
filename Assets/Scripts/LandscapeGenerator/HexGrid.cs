using System;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    /// <summary>
    /// Manages a grid for hex cells
    /// </summary>
    public class HexGrid : MonoBehaviour
    {
        int cellCountX, cellCountZ;

        public HexCell cellPrefab;
        public Text cellLabelPrefab;

        private HexCell[] _cells;

        public Color defaultColor = Color.white;

        public Texture2D noiseSource;

        public int chunkCountX = 4, chunkCountZ = 3;
        public HexGridChunk chunkPrefab;
        private HexGridChunk[] chunks;
        
#region UNITY_ENGINE
        
        private void OnEnable()
        {
            HexMetrics.noiseSource = noiseSource;
        }

        private void Awake()
        {
            HexMetrics.noiseSource = noiseSource;

            cellCountX = chunkCountX * HexMetrics.chunkSizeX;
            cellCountZ = chunkCountZ * HexMetrics.chunkSizeZ;
            CreateChunks();
            CreateCells();
        }

#endregion

        void CreateChunks()
        {
            chunks = new HexGridChunk[chunkCountX * chunkCountZ];
            for (int z = 0, i = 0; z < chunkCountZ; z++)
            {
                for (int x = 0; x < chunkCountX; x++)
                {
                    HexGridChunk chunk = chunks[i++] = Instantiate(chunkPrefab);
                    chunk.transform.SetParent(transform);
                }
            }
        }

        void CreateCells()
        {
            _cells = new HexCell[cellCountZ * cellCountX];
            for (int z = 0, i = 0; z < cellCountZ; z++)
            {
                for (int x = 0; x < cellCountX; x++)
                {
                    CreateCell(x, z, i++);
                }
            }
        }

        void CreateCell(int x, int z, int i)
        {
            Vector3 position;
            position.x = (x + z * 0.5f - z / 2) * (HexMetrics.innerRadius * 2f);
            position.y = 0f;
            position.z = z * (HexMetrics.outerRadius * 1.5f);

            HexCell cell = _cells[i] = Instantiate<HexCell>(cellPrefab);
            cell.transform.SetParent(transform, false);
            cell.transform.localPosition = position;
            cell.coordinates = HexCoordinates.FromOffsetCoordinates(x, z);
            cell.Color = defaultColor;

            if (x > 0) {
                cell.SetNeighbor(HexDirection.W, _cells[i - 1]);
            }
            if (z > 0) {
                if ((z & 1) == 0) {
                    cell.SetNeighbor(HexDirection.SE, _cells[i - cellCountX]);
                    if (x > 0) {
                        cell.SetNeighbor(HexDirection.SW, _cells[i - cellCountX - 1]);
                    }
                }
                else {
                    cell.SetNeighbor(HexDirection.SW, _cells[i - cellCountX]);
                    if (x < cellCountX - 1) {
                        cell.SetNeighbor(HexDirection.SE, _cells[i - cellCountX + 1]);
                    }
                }
            }

            Text label = Instantiate<Text>(cellLabelPrefab);
            label.rectTransform.anchoredPosition = new Vector2(position.x, position.z);
            label.text = cell.coordinates.ToStringOnSeparateLines();
            cell.uiRect = label.rectTransform;
            cell.Elevation = 0;
            AddCellToChunk(x, z, cell);
        }

        void AddCellToChunk(int x, int z, HexCell cell)
        {
            int chunkX = x / HexMetrics.chunkSizeX;
            int chunkZ = z / HexMetrics.chunkSizeZ;
            HexGridChunk chunk = chunks[chunkX + chunkZ * chunkCountX];

            int localX = x - chunkX * HexMetrics.chunkSizeX;
            int localZ = z - chunkZ * HexMetrics.chunkSizeZ;
            chunk.AddCell(localX + localZ * HexMetrics.chunkSizeX, cell);
        }
        

        /// <summary>
        /// Returns the cell at a specified position
        /// </summary>
        /// <param name="position"></param>
        /// <returns></returns>
        public HexCell GetCell(Vector3 position)
        {
            position = transform.InverseTransformPoint(position);
            HexCoordinates coordinates = HexCoordinates.FromPosition(position);
            int index = coordinates.X + coordinates.Z * cellCountX + coordinates.Z / 2;
            return _cells[index];
        }

        public HexCell GetCell(HexCoordinates coordinates)
        {
            int z = coordinates.Z;
            if (z < 0 || z >= cellCountZ)
            {
                return null;
            }
            int x = coordinates.X + z / 2;
            
            if (x < 0 || x >= cellCountX)
            {
                return null;
            }
            return _cells[x + z * cellCountX];
        }

        public void ShowUI(bool visible)
        {
            for (int i = 0; i < chunks.Length; i++)
            {
                chunks[i].ShowUI(visible);
            }
        }
        
        
    }
}

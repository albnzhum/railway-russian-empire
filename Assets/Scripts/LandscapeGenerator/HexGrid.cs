using System;
using UnityEngine;
using System.IO;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    /// <summary>
    /// Manages a grid for hex cells
    /// </summary>
    public class HexGrid : MonoBehaviour
    {
        int _cellCountX, _cellCountZ;

        public HexCell cellPrefab;
        public Text cellLabelPrefab;

        private HexCell[] _cells;

        public Color defaultColor = Color.white;

        public Texture2D noiseSource;

        public int chunkCountX = 4, chunkCountZ = 3;
        public HexGridChunk chunkPrefab;
        private HexGridChunk[] _chunks;

        public int seed;
        public Color[] colors;


        #region UNITY_ENGINE

        private void OnEnable()
        {
            if (!HexMetrics.NoiseSource)
            {
                HexMetrics.NoiseSource = noiseSource;
                HexMetrics.InitializeHashGrid(seed);
                HexMetrics.colors = colors;
            }
        }

        private void Awake()
        {
            HexMetrics.NoiseSource = noiseSource;
            HexMetrics.InitializeHashGrid(seed);
            HexMetrics.colors = colors;

            _cellCountX = chunkCountX * HexMetrics.ChunkSizeX;
            _cellCountZ = chunkCountZ * HexMetrics.ChunkSizeZ;
            CreateChunks();
            CreateCells();
        }

        #endregion

        public void Save(BinaryWriter writer)
        {
            for (int i = 0; i < _cells.Length; i++)
            {
                _cells[i].Save(writer);
            }
        }

        public void Load(BinaryReader reader)
        {
            for (int i = 0; i < _cells.Length; i++)
            {
                _cells[i].Load(reader);
            }

            for (int i = 0; i < _cells.Length; i++)
            {
                _chunks[i].Refresh();
            }
        }

        void CreateChunks()
        {
            _chunks = new HexGridChunk[chunkCountX * chunkCountZ];
            for (int z = 0, i = 0; z < chunkCountZ; z++)
            {
                for (int x = 0; x < chunkCountX; x++)
                {
                    HexGridChunk chunk = _chunks[i++] = Instantiate(chunkPrefab);
                    chunk.transform.SetParent(transform);
                }
            }
        }

        void CreateCells()
        {
            _cells = new HexCell[_cellCountZ * _cellCountX];
            for (int z = 0, i = 0; z < _cellCountZ; z++)
            {
                for (int x = 0; x < _cellCountX; x++)
                {
                    CreateCell(x, z, i++);
                }
            }
        }

        void CreateCell(int x, int z, int i)
        {
            Vector3 position;
            position.x = (x + z * 0.5f - z / 2) * (HexMetrics.InnerRadius * 2f);
            position.y = 0f;
            position.z = z * (HexMetrics.OuterRadius * 1.5f);

            HexCell cell = _cells[i] = Instantiate<HexCell>(cellPrefab);
            cell.transform.SetParent(transform, false);
            cell.transform.localPosition = position;
            cell.coordinates = HexCoordinates.FromOffsetCoordinates(x, z);
            if (x > 0)
            {
                cell.SetNeighbor(HexDirection.W, _cells[i - 1]);
            }

            if (z > 0)
            {
                if ((z & 1) == 0)
                {
                    cell.SetNeighbor(HexDirection.Se, _cells[i - _cellCountX]);
                    if (x > 0)
                    {
                        cell.SetNeighbor(HexDirection.SW, _cells[i - _cellCountX - 1]);
                    }
                }
                else
                {
                    cell.SetNeighbor(HexDirection.SW, _cells[i - _cellCountX]);
                    if (x < _cellCountX - 1)
                    {
                        cell.SetNeighbor(HexDirection.Se, _cells[i - _cellCountX + 1]);
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
            int chunkX = x / HexMetrics.ChunkSizeX;
            int chunkZ = z / HexMetrics.ChunkSizeZ;
            HexGridChunk chunk = _chunks[chunkX + chunkZ * chunkCountX];

            int localX = x - chunkX * HexMetrics.ChunkSizeX;
            int localZ = z - chunkZ * HexMetrics.ChunkSizeZ;
            chunk.AddCell(localX + localZ * HexMetrics.ChunkSizeX, cell);
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
            int index = coordinates.X + coordinates.Z * _cellCountX + coordinates.Z / 2;
            return _cells[index];
        }

        public HexCell GetCell(HexCoordinates coordinates)
        {
            int z = coordinates.Z;
            if (z < 0 || z >= _cellCountZ)
            {
                return null;
            }

            int x = coordinates.X + z / 2;

            if (x < 0 || x >= _cellCountX)
            {
                return null;
            }

            return _cells[x + z * _cellCountX];
        }

        public void ShowUI(bool visible)
        {
            for (int i = 0; i < _chunks.Length; i++)
            {
                _chunks[i].ShowUI(visible);
            }
        }
    }
}
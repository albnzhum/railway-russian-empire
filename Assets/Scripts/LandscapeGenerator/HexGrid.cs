using System;
using UnityEngine;
using System.IO;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    /// <summary>
    /// Manages a grid for hex cells
    /// </summary>
    public class HexGrid : MonoBehaviour
    {
        int _chunkCountX, _chunkCountZ;

        public HexCell cellPrefab;
        public Text cellLabelPrefab;

        private HexCell[] _cells;

        public Color defaultColor = Color.white;

        public Texture2D noiseSource;

        public int cellCountX = 4;
        public int cellCountZ = 3;
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

            CreateMap(cellCountX, cellCountZ);
        }

        #endregion

        public bool CreateMap(int x, int z)
        {
            if (
                x <= 0 || x % HexMetrics.ChunkSizeX != 0 ||
                z <= 0 || z % HexMetrics.ChunkSizeZ != 0
            ) {
                Debug.LogError("Unsupported map size.");
                return false;
            }
            
            if (_chunks != null)
            {
                for (int i = 0; i < _chunks.Length; i++)
                {
                    Destroy(_chunks[i].gameObject);
                }
            }

            cellCountX = x;
            cellCountZ = z;
            
            _chunkCountX = cellCountX / HexMetrics.ChunkSizeX;
            _chunkCountZ = cellCountZ / HexMetrics.ChunkSizeZ;
            CreateChunks();
            CreateCells();

            return true;
        }
        
        public void Save(BinaryWriter writer)
        {
            writer.Write(cellCountX);
            writer.Write(cellCountZ);
		
            for (int i = 0; i < _cells.Length; i++) {
                _cells[i].Save(writer);
            }
        }

        public void Load (BinaryReader reader, int header) {
            int x = 20, z = 15;
            if (header >= 1) {
                x = reader.ReadInt32();
                z = reader.ReadInt32();
            }
            if (x != cellCountX || z != cellCountZ) {
                if (!CreateMap(x, z)) {
                    return;
                }
            }
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
            _chunks = new HexGridChunk[cellCountX * cellCountZ];
            for (int z = 0, i = 0; z < cellCountZ; z++)
            {
                for (int x = 0; x < cellCountX; x++)
                {
                    HexGridChunk chunk = _chunks[i++] = Instantiate(chunkPrefab);
                    chunk.transform.SetParent(transform);
                }
            }
        }

        void CreateCells()
        {
            _cells = new HexCell[_chunkCountZ * _chunkCountX];
            for (int z = 0, i = 0; z < _chunkCountZ; z++)
            {
                for (int x = 0; x < _chunkCountX; x++)
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
                    cell.SetNeighbor(HexDirection.Se, _cells[i - _chunkCountX]);
                    if (x > 0)
                    {
                        cell.SetNeighbor(HexDirection.SW, _cells[i - _chunkCountX - 1]);
                    }
                }
                else
                {
                    cell.SetNeighbor(HexDirection.SW, _cells[i - _chunkCountX]);
                    if (x < _chunkCountX - 1)
                    {
                        cell.SetNeighbor(HexDirection.Se, _cells[i - _chunkCountX + 1]);
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
            HexGridChunk chunk = _chunks[chunkX + chunkZ * cellCountX];

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
            int index = coordinates.X + coordinates.Z * _chunkCountX + coordinates.Z / 2;
            return _cells[index];
        }

        public HexCell GetCell(HexCoordinates coordinates)
        {
            int z = coordinates.Z;
            if (z < 0 || z >= _chunkCountZ)
            {
                return null;
            }

            int x = coordinates.X + z / 2;

            if (x < 0 || x >= _chunkCountX)
            {
                return null;
            }

            return _cells[x + z * _chunkCountX];
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
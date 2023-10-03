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
        int cellCountX,cellCountZ ;

        public HexCell cellPrefab;
        public Text cellLabelPrefab;
        private Canvas gridCanvas;

        private HexCell[] _cells;
        private HexMesh _hexMesh;

        public Color defaultColor = Color.white;

        public Texture2D noiseSource;

        public int chunkCountX = 4, chunkCountZ = 3;
        public HexGridChunk chunkPrefab;
        private HexGridChunk[] chunks;
        
        #region UNITY_ENGINE

        private void Start()
        {
            _hexMesh.Triangulate(_cells);
        }

        private void OnEnable()
        {
            HexMetrics.noiseSource = noiseSource;
        }

        private void Awake()
        {
            HexMetrics.noiseSource = noiseSource;
            gridCanvas = GetComponentInChildren<Canvas>();
            _hexMesh = GetComponentInChildren<HexMesh>();

            cellCountX = chunkCountX * HexMetrics.chunkSizeX;
            cellCountZ = chunkCountZ * HexMetrics.chunkSizeZ;
            CreateChunks();
            CreateCells();
        }

        #endregion

        public void Refresh()
        {
            _hexMesh.Triangulate(_cells);
        }

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
                    CreateCell(x, z, i);
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
            cell.Coordinates = HexCoordinates.FromOffsetCoordinates(x, z);
            cell.color = defaultColor;

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

            Text label = Instantiate<Text>(cellLabelPrefab, gridCanvas.transform, false);
            label.rectTransform.anchoredPosition = new Vector2(position.x, position.z);
            label.text = cell.Coordinates.ToStringOnSeparateLines();
            cell.uiRect = label.rectTransform;
            cell.Elevation = 0;
        }

        /// <summary>
        /// Colors a cell at a specified position with a given color.
        /// </summary>
        /// <param name="position"></param>
        /// <param name="color"></param>
        public void ColorCell(Vector3 position, Color color)
        {
            position = transform.InverseTransformPoint(position);
            HexCoordinates coordinates = HexCoordinates.FromPosition(position);
            int index = coordinates.X + coordinates.Z * cellCountX  + coordinates.Z / 2;
            HexCell cell = _cells[index];
            cell.color = color;
            _hexMesh.Triangulate(_cells);
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
        
        
    }
}

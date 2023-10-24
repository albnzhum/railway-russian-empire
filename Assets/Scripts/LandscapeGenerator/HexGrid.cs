using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.IO;

namespace LandscapeGenerator
{
    /// <summary>
    /// Hex grid manager
    /// </summary>
    public class HexGrid : MonoBehaviour
    {
        public int cellCountX = 20, cellCountZ = 15;

        public HexCell cellPrefab;
        public Text cellLabelPrefab;
        public HexGridChunk chunkPrefab;

        public Texture2D noiseSource;

        public int seed;
        public HexUnit hexUnit;

        HexGridChunk[] Chunks;
        HexCell[] Cells;

        int ChunkCountX, ChunkCountZ;
        HexCellPriorityQueue SearchFrontier;
        int SearchFrontierPhase;

        HexCell CurrentPathFrom, CurrentPathTo;

        List<HexUnit> Units = new List<HexUnit>();

        HexCellShaderData CellShaderData;

        public bool HasPath { get; private set; }

        void Awake()
        {
            HexMetrics.NoiseSource = noiseSource;
            HexMetrics.InitializeHashGrid(seed);
            HexUnit.unitPrefab = hexUnit;
            CellShaderData = gameObject.AddComponent<HexCellShaderData>();
            CreateMap(cellCountX, cellCountZ);
        }

        void OnEnable()
        {
            if (!HexMetrics.NoiseSource)
            {
                HexMetrics.NoiseSource = noiseSource;
                HexMetrics.InitializeHashGrid(seed);
                HexUnit.unitPrefab = hexUnit;
            }
        }

        #region A* Pathfinding

        public void FindPath (HexCell fromCell, HexCell toCell, int speed) {
            ClearPath();
            CurrentPathFrom = fromCell;
            CurrentPathTo = toCell;
            HasPath = Search(fromCell, toCell, speed);
            ShowPath(speed);
        }

        bool Search (HexCell fromCell, HexCell toCell, int speed) {
            SearchFrontierPhase += 2;
            if (SearchFrontier == null) {
                SearchFrontier = new HexCellPriorityQueue();
            }
            else {
                SearchFrontier.Clear();
            }

            fromCell.SearchPhase = SearchFrontierPhase;
            fromCell.Distance = 0;
            SearchFrontier.Enqueue(fromCell);
            while (SearchFrontier.Count > 0) {
                var current = SearchFrontier.Dequeue();
                current.SearchPhase += 1;

                if (current == toCell) {
                    return true;
                }

                var currentTurn = (current.Distance - 1) / speed;

                for (var d = HexDirection.NE; d <= HexDirection.NW; d++) {
                    var neighbor = current.GetNeighbor(d);
                    if (
                        neighbor == null ||
                        neighbor.SearchPhase > SearchFrontierPhase
                    ) {
                        continue;
                    }
                    if (neighbor.IsUnderwater || neighbor.Unit) {
                        continue;
                    }
                    var edgeType = current.GetEdgeType(neighbor);
                    if (edgeType == HexEdgeType.Cliff) {
                        continue;
                    }
                    int moveCost;
                    if (current.HasRoadThroughEdge(d)) {
                        moveCost = 1;
                    }
                    else if (current.Walled != neighbor.Walled) {
                        continue;
                    }
                    else {
                        moveCost = edgeType == HexEdgeType.Flat ? 5 : 10;
                        moveCost += neighbor.UrbanLevel + neighbor.FarmLevel +
                                    neighbor.PlantLevel;
                    }

                    var distance = current.Distance + moveCost;
                    var turn = (distance - 1) / speed;
                    if (turn > currentTurn) {
                        distance = turn * speed + moveCost;
                    }

                    if (neighbor.SearchPhase < SearchFrontierPhase) {
                        neighbor.SearchPhase = SearchFrontierPhase;
                        neighbor.Distance = distance;
                        neighbor.PathFrom = current;
                        neighbor.SearchHeuristic =
                            neighbor.coordinates.DistanceTo(toCell.coordinates);
                        SearchFrontier.Enqueue(neighbor);
                    }
                    else if (distance < neighbor.Distance) {
                        var oldPriority = neighbor.SearchPriority;
                        neighbor.Distance = distance;
                        neighbor.PathFrom = current;
                        SearchFrontier.Change(neighbor, oldPriority);
                    }
                }
            }
            return false;
        }

        void ShowPath (int speed) {
            if (HasPath) {
                var current = CurrentPathTo;
                while (current != CurrentPathFrom) {
                    var turn = (current.Distance - 1) / speed;
                    current.SetLabel(turn.ToString());
                    current.EnableHighlight(Color.white);
                    current = current.PathFrom;
                }
            }
            CurrentPathFrom.EnableHighlight(Color.blue);
            CurrentPathTo.EnableHighlight(Color.red);
        }

        public void ClearPath () {
            if (HasPath) {
                var current = CurrentPathTo;
                while (current != CurrentPathFrom) {
                    current.SetLabel(null);
                    current.DisableHighlight();
                    current = current.PathFrom;
                }
                current.DisableHighlight();
                HasPath = false;
            }
            else if (CurrentPathFrom) {
                CurrentPathFrom.DisableHighlight();
                CurrentPathTo.DisableHighlight();
            }
            CurrentPathFrom = CurrentPathTo = null;
        }

        public List<HexCell> GetPath () {
            if (!HasPath) {
                return null;
            }
            var path = ListPool<HexCell>.Get();
            for (var c = CurrentPathTo; c != CurrentPathFrom; c = c.PathFrom) {
                path.Add(c);
            }
            path.Add(CurrentPathFrom);
            path.Reverse();
            return path;
        }

        #endregion

        #region Create map

        public bool CreateMap(int x, int z)
        {
            if (
                x <= 0 || x % HexMetrics.ChunkSizeX != 0 ||
                z <= 0 || z % HexMetrics.ChunkSizeZ != 0
            )
            {
                Debug.LogError("Unsupported map size.");
                return false;
            }

            ClearPath();
            ClearUnits();
            if (Chunks != null) {
                for (var i = 0; i < Chunks.Length; i++) {
                    Destroy(Chunks[i].gameObject);
                }
            }

            cellCountX = x;
            cellCountZ = z;
            ChunkCountX = cellCountX / HexMetrics.ChunkSizeX;
            ChunkCountZ = cellCountZ / HexMetrics.ChunkSizeZ;
            CellShaderData.Initialize(cellCountX, cellCountZ);
            CreateChunks();
            CreateCells();
            return true;
        }

        void CreateChunks()
        {
            Chunks = new HexGridChunk[ChunkCountX * ChunkCountZ];

            for (int z = 0, i = 0; z < ChunkCountZ; z++)
            {
                for (var x = 0; x < ChunkCountX; x++)
                {
                    var chunk = Chunks[i++] = Instantiate(chunkPrefab);
                    chunk.transform.SetParent(transform);
                }
            }
        }

        void CreateCells()
        {
            Cells = new HexCell[cellCountZ * cellCountX];

            for (int z = 0, i = 0; z < cellCountZ; z++)
            {
                for (var x = 0; x < cellCountX; x++)
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

            var cell = Cells[i] = Instantiate<HexCell>(cellPrefab);
            cell.transform.localPosition = position;
            cell.coordinates = HexCoordinates.FromOffsetCoordinates(x, z);
            cell.Index = i;
            cell.ShaderData = CellShaderData;

            if (x > 0)
            {
                cell.SetNeighbor(HexDirection.W, Cells[i - 1]);
            }

            if (z > 0)
            {
                if ((z & 1) == 0)
                {
                    cell.SetNeighbor(HexDirection.SE, Cells[i - cellCountX]);
                    if (x > 0)
                    {
                        cell.SetNeighbor(HexDirection.SW, Cells[i - cellCountX - 1]);
                    }
                }
                else
                {
                    cell.SetNeighbor(HexDirection.SW, Cells[i - cellCountX]);
                    if (x < cellCountX - 1)
                    {
                        cell.SetNeighbor(HexDirection.SE, Cells[i - cellCountX + 1]);
                    }
                }
            }

            var label = Instantiate(cellLabelPrefab);
            label.rectTransform.anchoredPosition =
                new Vector2(position.x, position.z);
            cell.uiRect = label.rectTransform;

            cell.Elevation = 0;

            AddCellToChunk(x, z, cell);
        }

        #endregion

        HexCell GetCell(Vector3 position)
        {
            position = transform.InverseTransformPoint(position);
            var coordinates = HexCoordinates.FromPosition(position);
            var index =
                coordinates.X + coordinates.Z * cellCountX + coordinates.Z / 2;
            return Cells[index];
        }

        public HexCell GetCell(HexCoordinates coordinates)
        {
            var z = coordinates.Z;
            if (z < 0 || z >= cellCountZ)
            {
                return null;
            }

            var x = coordinates.X + z / 2;
            if (x < 0 || x >= cellCountX)
            {
                return null;
            }

            return Cells[x + z * cellCountX];
        }

        public HexCell GetCell(Ray ray)
        {
            return Physics.Raycast(ray, out var hit) ? GetCell(hit.point) : null;
        }

        public void ShowUI(bool visible)
        {
            for (var i = 0; i < Chunks.Length; i++)
            {
                Chunks[i].ShowUI(visible);
            }
        }

        void AddCellToChunk(int x, int z, HexCell cell)
        {
            var chunkX = x / HexMetrics.ChunkSizeX;
            var chunkZ = z / HexMetrics.ChunkSizeZ;
            var chunk = Chunks[chunkX + chunkZ * ChunkCountX];

            var localX = x - chunkX * HexMetrics.ChunkSizeX;
            var localZ = z - chunkZ * HexMetrics.ChunkSizeZ;
            chunk.AddCell(localX + localZ * HexMetrics.ChunkSizeX, cell);
        }

        public void AddUnit(HexUnit unit, HexCell location, float orientation)
        {
            Units.Add(unit);
            unit.transform.SetParent(transform, false);
            unit.Location = location;
            unit.Orientation = orientation;
        }

        void ClearUnits()
        {
            for (var i = 0; i < Units.Count; i++)
            {
                Units[i].Die();
            }
            Units.Clear();
        }

        public void RemoveUnit(HexUnit unit)
        {
            Units.Remove(unit);
            unit.Die();
        }

        public void Save(BinaryWriter writer)
        {
            writer.Write(cellCountX);
            writer.Write(cellCountZ);

            for (var i = 0; i < Cells.Length; i++)
            {
                Cells[i].Save(writer);
            }

            writer.Write(Units.Count);
            for (var i = 0; i < Units.Count; i++)
            {
                Units[i].Save(writer);
            }
        }

        public void Load(BinaryReader reader, int header)
        {
            ClearPath();
            ClearUnits();
            int x = 20, z = 15;
            if (header >= 1)
            {
                x = reader.ReadInt32();
                z = reader.ReadInt32();
            }

            if (x != cellCountX || z != cellCountZ)
            {
                if (!CreateMap(x, z))
                {
                    return;
                }
            }

            for (var i = 0; i < Cells.Length; i++)
            {
                Cells[i].Load(reader);
            }

            for (var i = 0; i < Chunks.Length; i++)
            {
                Chunks[i].Refresh();
            }

            if (header >= 2) {
                var unitCount = reader.ReadInt32();
                for (var i = 0; i < unitCount; i++) {
                    HexUnit.Load(reader, this);
                }
            }
        }
    }
}

using UnityEngine;

namespace LandscapeGenerator
{
    public class HexCell : MonoBehaviour
    {
        public HexCoordinates coordinates;

        public RectTransform uiRect;

        public HexGridChunk chunk;

        private Color _color;

        private int _elevation = int.MinValue;
        private int _waterLevel;
        private int urbanLevel, farmLevel, plantLevel;
        private bool walled;

        [SerializeField] HexCell[] neighbors;

        [SerializeField] private bool[] roads;

        #region Public Properties

        public Color Color
        {
            get => _color;
            set
            {
                if (_color == value)
                {
                    return;
                }

                _color = value;
                Refresh();
            }
        }

        public int Elevation
        {
            get => _elevation;
            set
            {
                if (_elevation == value)
                {
                    return;
                }

                _elevation = value;
                Vector3 position = transform.localPosition;
                position.y = value * HexMetrics.ElevationStep;
                position.y +=
                    (HexMetrics.SampleNoise(position).y * 2f - 1f) *
                    HexMetrics.ElevationPerturbStrength;
                transform.localPosition = position;

                Vector3 uiPosition = uiRect.localPosition;
                uiPosition.z = -position.y;
                uiRect.localPosition = uiPosition;
                ValidateRivers();

                for (int i = 0; i < roads.Length; i++)
                {
                    if (roads[i] && GetElevationDifference((HexDirection)i) > 1)
                    {
                        SetRoad(i, false);
                    }
                }
                
                Refresh();
            }
        }

        public bool HasIncomingRiver { get; private set; }

        private bool HasOutgoingRiver { get; set; }

        public HexDirection IncomingRiver { get; private set; }

        public HexDirection OutgoingRiver { get; private set; }

        public bool HasRiver => HasIncomingRiver || HasOutgoingRiver;
        public bool HasRiverBeginOrEnd => HasIncomingRiver != HasOutgoingRiver;
        public float StreamDebY => (_elevation + HexMetrics.StreamBedElevationOffset) 
                                   * HexMetrics.ElevationStep;

        public float RiverSurfaceY => (_elevation + HexMetrics.WaterElevationOffset) 
                                      * HexMetrics.ElevationStep;

        public float WaterSurfaceY =>
            (_waterLevel + HexMetrics.WaterElevationOffset) *
            HexMetrics.ElevationStep;

        public bool HasRoads
        {
            get {
                for (int i = 0; i < roads.Length; i++) {
                    if (roads[i]) {
                        return true;
                    }
                }
                return false;
            }
        }
        public HexDirection RiverBeginOrEndDirection => 
            HasIncomingRiver ? IncomingRiver : OutgoingRiver;
        
        public int WaterLevel {
            get => _waterLevel;
            set {
                if (_waterLevel == value) {
                    return;
                }
                _waterLevel = value;
                ValidateRivers();
                Refresh();
            }
        }
        public bool IsUnderwater => _waterLevel > _elevation;

        public int UrbanLevel
        {
            get => urbanLevel;
            set
            {
                if (urbanLevel != value)
                {
                    urbanLevel = value;
                    RefreshSelfOnly();
                }
            }
        }

        public int FarmLevel
        {
            get => farmLevel;
            set
            {
                if (farmLevel != value)
                {
                    farmLevel = value;
                    RefreshSelfOnly();
                }
            }
        }

        public int PlantLevel
        {
            get => plantLevel;
            set
            {
                if (plantLevel != value)
                {
                    plantLevel = value;
                    RefreshSelfOnly();
                }
            }
        }

        public bool Walled
        {
            get => walled;
            set
            {
                if (walled != value)
                {
                    walled = value;
                    Refresh();
                }
            }
        }

        #endregion

        #region Rivers

        public bool HasRiverThroughEdge(HexDirection direction)
        {
            return HasIncomingRiver && IncomingRiver == direction ||
                   HasOutgoingRiver && OutgoingRiver == direction;
        }

        private void RemoveOutgoingRiver()
        {
            if (!HasOutgoingRiver) return;
            HasOutgoingRiver = false;
            RefreshSelfOnly();

            HexCell neighbor = GetNeighbor(OutgoingRiver);
            neighbor.HasIncomingRiver = false;
            neighbor.RefreshSelfOnly();
        }

        private void RemoveIncomingRiver()
        {
            if (!HasIncomingRiver) return;
            HasIncomingRiver = false;
            RefreshSelfOnly();

            HexCell neighbor = GetNeighbor(IncomingRiver);
            neighbor.HasOutgoingRiver = false;
            neighbor.RefreshSelfOnly();
        }

        public void RemoveRiver()
        {
            RemoveOutgoingRiver();
            RemoveIncomingRiver();
        }

        public void SetOutgoingRiver(HexDirection direction)
        {
            if (HasOutgoingRiver && OutgoingRiver == direction) return;
            HexCell neighbor = GetNeighbor(direction);
            if (!IsValidRiverDestination(neighbor)) {
                return;
            }
            RemoveOutgoingRiver();
            if (HasIncomingRiver && IncomingRiver == direction)
            {
                RemoveIncomingRiver();
            }

            HasOutgoingRiver = true;
            OutgoingRiver = direction;
            
            neighbor.RemoveIncomingRiver();
            neighbor.HasIncomingRiver = true;
            neighbor.IncomingRiver = direction.Opposite();
            
            SetRoad((int)direction, false);
        }
        
        bool IsValidRiverDestination (HexCell neighbor) {
            return neighbor && (
                _elevation >= neighbor._elevation || _waterLevel == neighbor._elevation
            );
        }
        
        void ValidateRivers () {
            if (
                HasOutgoingRiver &&
                !IsValidRiverDestination(GetNeighbor(OutgoingRiver))
            ) {
                RemoveOutgoingRiver();
            }
            if (
                HasOutgoingRiver &&
                !GetNeighbor(IncomingRiver).IsValidRiverDestination(this)
            ) {
                RemoveIncomingRiver();
            }
        }

        #endregion

        private void RefreshSelfOnly()
        {
            chunk.Refresh();
        }

        public Vector3 Position => transform.localPosition;

        public HexCell GetNeighbor(HexDirection direction)
        {
            return neighbors[(int)direction];
        }

        public void SetNeighbor(HexDirection direction, HexCell cell)
        {
            neighbors[(int)direction] = cell;
            cell.neighbors[(int)direction.Opposite()] = this;
        }

        public HexEdgeType GetEdgeType(HexDirection direction)
        {
            return HexMetrics.GetEdgeType(
                _elevation, neighbors[(int)direction]._elevation
            );
        }

        public HexEdgeType GetEdgeType(HexCell otherCell)
        {
            return HexMetrics.GetEdgeType(
                _elevation, otherCell._elevation
            );
        }

        #region Roads

        public bool HasRoadThroughEdge(HexDirection direction)
        {
            return roads[(int)direction];
        }

        public void AddRoad(HexDirection direction)
        {
            if (!roads[(int)direction] && !HasRiverThroughEdge(direction)
                && GetElevationDifference(direction) <= 1)
            {
                SetRoad((int)direction, true);
            }
        }

        private void SetRoad(int index, bool state)
        {
            roads[index] = state;
            neighbors[index].roads[(int)((HexDirection)index).Opposite()] = state;
            neighbors[index].RefreshSelfOnly();
            RefreshSelfOnly();
        }

        private int GetElevationDifference(HexDirection direction)
        {
            int difference = _elevation - GetNeighbor(direction)._elevation;
            return difference >= 0 ? difference : -difference;
        }

        public void RemoveRoads()
        {
            for (int i = 0; i < neighbors.Length; i++)
            {
                if (roads[i])
                {
                    roads[i] = false;
                    neighbors[i].roads[(int)((HexDirection)i).Opposite()] = false;
                    neighbors[i].RefreshSelfOnly();
                    RefreshSelfOnly();
                }
            }
        }

        #endregion

        private void Refresh()
        {
            if (chunk)
            {
                chunk.Refresh();
                foreach (var neighbor in neighbors)
                {
                    if (neighbor != null && neighbor.chunk != chunk)
                    {
                        neighbor.chunk.Refresh();
                    }
                }
            }
        }
    }
}
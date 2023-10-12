using UnityEngine;
using System.IO;

namespace LandscapeGenerator
{
    public class HexCell : MonoBehaviour
    {
        public HexCoordinates coordinates;

        public RectTransform uiRect;

        public HexGridChunk chunk;

        private int terrainTypeIndex;

        private int elevation = int.MinValue;
        private int waterLevel;
        private int urbanLevel, farmLevel, plantLevel;
        private bool walled;
        private int specialIndex;

        [SerializeField] HexCell[] neighbors;

        [SerializeField] private bool[] roads;

        #region Public Properties

        public Vector3 Position => transform.localPosition;

        public int TerrainTypeIndex
        {
            get => terrainTypeIndex;
            set
            {
                if (terrainTypeIndex != value)
                {
                    terrainTypeIndex = value;
                    Refresh();
                }
            }
        }

        public int Elevation
        {
            get => elevation;
            set
            {
                if (elevation == value)
                {
                    return;
                }

                elevation = value;
                RefreshPosition();
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

        public float StreamBedY => (elevation + HexMetrics.StreamBedElevationOffset)
                                   * HexMetrics.elevationStep;

        public float RiverSurfaceY => (elevation + HexMetrics.WaterElevationOffset)
                                      * HexMetrics.elevationStep;

        public float WaterSurfaceY =>
            (waterLevel + HexMetrics.WaterElevationOffset) *
            HexMetrics.elevationStep;

        public bool HasRoads
        {
            get
            {
                for (int i = 0; i < roads.Length; i++)
                {
                    if (roads[i])
                    {
                        return true;
                    }
                }

                return false;
            }
        }

        public HexDirection RiverBeginOrEndDirection =>
            HasIncomingRiver ? IncomingRiver : OutgoingRiver;

        public int WaterLevel
        {
            get => waterLevel;
            set
            {
                if (waterLevel == value)
                {
                    return;
                }

                waterLevel = value;
                ValidateRivers();
                Refresh();
            }
        }

        public bool IsUnderwater => waterLevel > elevation;

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

        public int SpecialIndex
        {
            get => specialIndex;
            set
            {
                if (specialIndex != value && !HasRiver)
                {
                    specialIndex = value;
                    RemoveRoads();
                    RefreshSelfOnly();
                }
            }
        }

        public bool IsSpecial => specialIndex > 0;

        #endregion

        public void Save(BinaryWriter writer)
        {
            writer.Write((byte)terrainTypeIndex);
            writer.Write((byte)elevation);
            writer.Write((byte)waterLevel);
            writer.Write((byte)urbanLevel);
            writer.Write((byte)farmLevel);
            writer.Write((byte)plantLevel);
            writer.Write((byte)specialIndex);
            writer.Write(walled);

            if (HasIncomingRiver)
            {
                writer.Write((byte)(IncomingRiver + 128));
            }
            else
            {
                writer.Write((byte)0);
            }

            if (HasOutgoingRiver)
            {
                writer.Write((byte)(OutgoingRiver + 128));
            }
            else
            {
                writer.Write((byte)0);
            }

            int roadFlags = 0;
            for (int i = 0; i < roads.Length; i++)
            {
                if (roads[i])
                {
                    roadFlags |= 1 << i;
                }
            }

            writer.Write((byte)roadFlags);
        }

        public void Load(BinaryReader reader)
        {
            terrainTypeIndex = reader.ReadByte();
            elevation = reader.ReadByte();
            RefreshPosition();
            waterLevel = reader.ReadByte();
            urbanLevel = reader.ReadByte();
            farmLevel = reader.ReadByte();
            plantLevel = reader.ReadByte();
            specialIndex = reader.ReadByte();
            walled = reader.ReadBoolean();

            byte riverData = reader.ReadByte();
            if (riverData >= 128)
            {
                HasIncomingRiver = true;
                IncomingRiver = (HexDirection)(riverData - 128);
            }
            else
            {
                HasIncomingRiver = false;
            }

            riverData = reader.ReadByte();
            if (riverData >= 128)
            {
                HasOutgoingRiver = true;
                OutgoingRiver = (HexDirection)(riverData - 128);
            }
            else
            {
                HasOutgoingRiver = false;
            }

            int roadFlags = reader.ReadByte();
            for (int i = 0; i < roads.Length; i++)
            {
                roads[i] = (roadFlags & (1 << i)) != 0;
            }
        }

        #region Rivers

        public bool HasRiverThroughEdge(HexDirection direction)
        {
            return HasIncomingRiver && IncomingRiver == direction ||
                   HasOutgoingRiver && OutgoingRiver == direction;
        }

        void RemoveOutgoingRiver()
        {
            if (!HasOutgoingRiver) return;
            HasOutgoingRiver = false;
            RefreshSelfOnly();

            HexCell neighbor = GetNeighbor(OutgoingRiver);
            neighbor.HasIncomingRiver = false;
            neighbor.RefreshSelfOnly();
        }

        void RemoveIncomingRiver()
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
            if (!IsValidRiverDestination(neighbor))
            {
                return;
            }

            RemoveOutgoingRiver();
            if (HasIncomingRiver && IncomingRiver == direction)
            {
                RemoveIncomingRiver();
            }

            HasOutgoingRiver = true;
            OutgoingRiver = direction;
            specialIndex = 0;

            neighbor.RemoveIncomingRiver();
            neighbor.HasIncomingRiver = true;
            neighbor.IncomingRiver = direction.Opposite();
            neighbor.specialIndex = 0;

            SetRoad((int)direction, false);
        }

        bool IsValidRiverDestination(HexCell neighbor)
        {
            return neighbor && (
                elevation >= neighbor.elevation || waterLevel == neighbor.elevation
            );
        }

        void ValidateRivers()
        {
            if (
                HasOutgoingRiver &&
                !IsValidRiverDestination(GetNeighbor(OutgoingRiver))
            )
            {
                RemoveOutgoingRiver();
            }

            if (
                HasOutgoingRiver &&
                !GetNeighbor(IncomingRiver).IsValidRiverDestination(this)
            )
            {
                RemoveIncomingRiver();
            }
        }

        #endregion

        #region Roads

        public bool HasRoadThroughEdge(HexDirection direction)
        {
            return roads[(int)direction];
        }

        public void AddRoad(HexDirection direction)
        {
            if (!roads[(int)direction] && !HasRiverThroughEdge(direction) &&
                !IsSpecial && !GetNeighbor(direction).IsSpecial &&
                GetElevationDifference(direction) <= 1)
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
            int difference = elevation - GetNeighbor(direction).elevation;
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

        void Refresh()
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

        void RefreshSelfOnly()
        {
            chunk.Refresh();
        }

        void RefreshPosition()
        {
            Vector3 position = transform.localPosition;
            position.y = elevation * HexMetrics.elevationStep;
            position.y +=
                (HexMetrics.SampleNoise(position).y * 2f - 1f) *
                HexMetrics.elevationPerturbStrength;
            transform.localPosition = position;

            Vector3 uiPosition = uiRect.localPosition;
            uiPosition.z = -position.y;
            uiRect.localPosition = uiPosition;
        }

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
                elevation, neighbors[(int)direction].elevation
            );
        }

        public HexEdgeType GetEdgeType(HexCell otherCell)
        {
            return HexMetrics.GetEdgeType(
                elevation, otherCell.elevation
            );
        }
    }
}

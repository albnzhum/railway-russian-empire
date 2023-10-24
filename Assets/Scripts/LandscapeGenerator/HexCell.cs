using UnityEngine;
using UnityEngine.UI;
using System.IO;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    public class HexCell : MonoBehaviour
    {

        public HexCoordinates coordinates;

        public RectTransform uiRect;

        public HexGridChunk chunk;
        int terrainTypeIndex;

        int elevation = int.MinValue;
        int waterLevel;

        int urbanLevel, farmLevel, plantLevel;

        int specialIndex;

        int distance;

        bool walled;

        bool hasIncomingRiver, hasOutgoingRiver;
        HexDirection incomingRiver, outgoingRiver;

        [SerializeField] HexCell[] neighbors;

        [SerializeField] bool[] roads;

        #region Public Properties

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

                for (var i = 0; i < roads.Length; i++)
                {
                    if (roads[i] && GetElevationDifference((HexDirection)i) > 1)
                    {
                        SetRoad(i, false);
                    }
                }

                Refresh();
            }
        }

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

        public bool HasIncomingRiver => hasIncomingRiver;

        public bool HasOutgoingRiver => hasOutgoingRiver;

        public bool HasRiver => hasIncomingRiver || hasOutgoingRiver;

        public bool HasRiverBeginOrEnd => hasIncomingRiver != hasOutgoingRiver;

        public HexDirection RiverBeginOrEndDirection => hasIncomingRiver ? incomingRiver : outgoingRiver;

        public bool HasRoads
        {
            get
            {
                for (var i = 0; i < roads.Length; i++)
                {
                    if (roads[i])
                    {
                        return true;
                    }
                }

                return false;
            }
        }

        public HexDirection IncomingRiver => incomingRiver;

        public HexDirection OutgoingRiver => outgoingRiver;

        public Vector3 Position => transform.localPosition;

        public float StreamBedY =>
            (elevation + HexMetrics.StreamBedElevationOffset) *
            HexMetrics.ElevationStep;

        public float RiverSurfaceY =>
            (elevation + HexMetrics.WaterElevationOffset) *
            HexMetrics.ElevationStep;

        public float WaterSurfaceY =>
            (waterLevel + HexMetrics.WaterElevationOffset) *
            HexMetrics.ElevationStep;

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

        public int TerrainTypeIndex
        {
            get => terrainTypeIndex;
            set
            {
                if (terrainTypeIndex != value)
                {
                    terrainTypeIndex = value;
                    ShaderData.RefreshTerrain(this);
                }
            }
        }

        public int Distance
        {
            get => distance;
            set {
                distance = value;
            }
        }
        public HexCell PathFrom { get; set; }

        public int SearchHeuristic { get; set; }

        public int SearchPriority => distance + SearchHeuristic;

        public HexCell NextWithSamePriority { get; set; }

        public int SearchPhase { get; set; }

        public HexUnit Unit { get; set; }

        public HexCellShaderData ShaderData { get; set; }

        public int Index { get; set; }

        #endregion

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

        public bool HasRiverThroughEdge(HexDirection direction)
        {
            return
                hasIncomingRiver && incomingRiver == direction ||
                hasOutgoingRiver && outgoingRiver == direction;
        }

        void RemoveIncomingRiver()
        {
            if (!hasIncomingRiver)
            {
                return;
            }

            hasIncomingRiver = false;
            RefreshSelfOnly();

            var neighbor = GetNeighbor(incomingRiver);
            neighbor.hasOutgoingRiver = false;
            neighbor.RefreshSelfOnly();
        }

        void RemoveOutgoingRiver()
        {
            if (!hasOutgoingRiver)
            {
                return;
            }

            hasOutgoingRiver = false;
            RefreshSelfOnly();

            var neighbor = GetNeighbor(outgoingRiver);
            neighbor.hasIncomingRiver = false;
            neighbor.RefreshSelfOnly();
        }

        public void RemoveRiver()
        {
            RemoveOutgoingRiver();
            RemoveIncomingRiver();
        }

        public void SetOutgoingRiver(HexDirection direction)
        {
            if (hasOutgoingRiver && outgoingRiver == direction)
            {
                return;
            }

            var neighbor = GetNeighbor(direction);
            if (!IsValidRiverDestination(neighbor))
            {
                return;
            }

            RemoveOutgoingRiver();
            if (hasIncomingRiver && incomingRiver == direction)
            {
                RemoveIncomingRiver();
            }

            hasOutgoingRiver = true;
            outgoingRiver = direction;
            specialIndex = 0;

            neighbor.RemoveIncomingRiver();
            neighbor.hasIncomingRiver = true;
            neighbor.incomingRiver = direction.Opposite();
            neighbor.specialIndex = 0;

            SetRoad((int)direction, false);
        }

        public bool HasRoadThroughEdge(HexDirection direction)
        {
            return roads[(int)direction];
        }

        public void AddRoad(HexDirection direction)
        {
            if (
                !roads[(int)direction] && !HasRiverThroughEdge(direction) &&
                !IsSpecial && !GetNeighbor(direction).IsSpecial &&
                GetElevationDifference(direction) <= 1
            )
            {
                SetRoad((int)direction, true);
            }
        }

        public void RemoveRoads()
        {
            for (var i = 0; i < neighbors.Length; i++)
            {
                if (roads[i])
                {
                    SetRoad(i, false);
                }
            }
        }

        int GetElevationDifference(HexDirection direction)
        {
            var difference = elevation - GetNeighbor(direction).elevation;
            return difference >= 0 ? difference : -difference;
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
                hasOutgoingRiver &&
                !IsValidRiverDestination(GetNeighbor(outgoingRiver))
            )
            {
                RemoveOutgoingRiver();
            }

            if (
                hasIncomingRiver &&
                !GetNeighbor(incomingRiver).IsValidRiverDestination(this)
            )
            {
                RemoveIncomingRiver();
            }
        }

        void SetRoad(int index, bool state)
        {
            roads[index] = state;
            neighbors[index].roads[(int)((HexDirection)index).Opposite()] = state;
            neighbors[index].RefreshSelfOnly();
            RefreshSelfOnly();
        }

        void RefreshPosition()
        {
            var center = this.Position;
            for (var d = HexDirection.NE; d <= HexDirection.NW; d++)
            {
                var e = new EdgeVertices(
                    center + HexMetrics.GetFirstSolidCorner(d),
                    center + HexMetrics.GetSecondSolidCorner(d)
                );

                center.y = elevation * HexMetrics.ElevationStep;
                center.y +=
                    (HexMetrics.SampleNoise(center).y ) *
                    HexMetrics.ElevationPerturbStrength;

                e.v1.y = elevation * HexMetrics.ElevationStep;
                e.v1.y +=
                    (HexMetrics.SampleNoise(center).y) * 5;
                e.v2.y = elevation * HexMetrics.ElevationStep;
                e.v2.y +=
                    (HexMetrics.SampleNoise(center).y ) * 5;
                e.v3.y = elevation * HexMetrics.ElevationStep;
                e.v3.y +=
                    (HexMetrics.SampleNoise(center).y ) * 5;
                e.v4.y = elevation * HexMetrics.ElevationStep;
                e.v4.y +=
                    (HexMetrics.SampleNoise(center).y ) * 5;
                e.v5.y = elevation * HexMetrics.ElevationStep;
                e.v5.y +=
                    (HexMetrics.SampleNoise(center).y ) * 5;

                InnerEdgeVertices innerEdgeVertices = new InnerEdgeVertices(center, e.v1, e.v2);
                InnerEdgeVertices innerEdgeVertices1 = new InnerEdgeVertices(center, e.v2, e.v3);
                InnerEdgeVertices innerEdgeVertices3 = new InnerEdgeVertices(center, e.v3, e.v4);
                InnerEdgeVertices innerEdgeVertices4 = new InnerEdgeVertices(center, e.v4, e.v5);
                transform.localPosition = center;
            }

            var uiPosition = uiRect.localPosition;
            //uiPosition.z = -position.y;
            uiRect.localPosition = uiPosition;
        }

        void Refresh()
        {
            if (chunk)
            {
                chunk.Refresh();
                for (var i = 0; i < neighbors.Length; i++)
                {
                    var neighbor = neighbors[i];
                    if (neighbor != null && neighbor.chunk != chunk)
                    {
                        neighbor.chunk.Refresh();
                    }
                }
                if (Unit)
                {
                    Unit.ValidateLocation();
                }
            }
        }

        void RefreshSelfOnly()
        {
            chunk.Refresh();
            if (Unit)
            {
                Unit.ValidateLocation();
            }
        }

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

            if (hasIncomingRiver)
            {
                writer.Write((byte)(incomingRiver + 128));
            }
            else
            {
                writer.Write((byte)0);
            }

            if (hasOutgoingRiver)
            {
                writer.Write((byte)(outgoingRiver + 128));
            }
            else
            {
                writer.Write((byte)0);
            }

            var roadFlags = 0;
            for (var i = 0; i < roads.Length; i++)
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
            ShaderData.RefreshTerrain(this);
            elevation = reader.ReadByte();
            RefreshPosition();
            waterLevel = reader.ReadByte();
            urbanLevel = reader.ReadByte();
            farmLevel = reader.ReadByte();
            plantLevel = reader.ReadByte();
            specialIndex = reader.ReadByte();
            walled = reader.ReadBoolean();

            var riverData = reader.ReadByte();
            if (riverData >= 128)
            {
                hasIncomingRiver = true;
                incomingRiver = (HexDirection)(riverData - 128);
            }
            else
            {
                hasIncomingRiver = false;
            }

            riverData = reader.ReadByte();
            if (riverData >= 128)
            {
                hasOutgoingRiver = true;
                outgoingRiver = (HexDirection)(riverData - 128);
            }
            else
            {
                hasOutgoingRiver = false;
            }

            int roadFlags = reader.ReadByte();
            for (var i = 0; i < roads.Length; i++)
            {
                roads[i] = (roadFlags & (1 << i)) != 0;
            }
        }

        public void SetLabel(string text)
        {
            var label = uiRect.GetComponent<Text>();
            label.text = text;
        }

        public void DisableHighlight () {
            var highlight = uiRect.GetChild(0).GetComponent<Image>();
            highlight.enabled = false;
        }

        public void EnableHighlight (Color color) {
            var highlight = uiRect.GetChild(0).GetComponent<Image>();
            highlight.color = color;
            highlight.enabled = true;
        }
    }
}

using System;
using UnityEngine;

namespace LandscapeGenerator
{
    public class HexCell : MonoBehaviour
    {
        public HexCoordinates coordinates;

        public RectTransform uiRect;

        public HexGridChunk chunk;

        private bool hasIncomingRiver, hasOutgoingRiver;
        private HexDirection incomingRiver, outgoingRiver;
        
        Color color;

        int elevation = int.MinValue;
        int waterLevel;

        [SerializeField] HexCell[] neighbors;

        [SerializeField] private bool[] roads;

        #region Public Properties

        public Color Color
        {
            get => color;
            set
            {
                if (color == value)
                {
                    return;
                }

                color = value;
                Refresh();
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
                Vector3 position = transform.localPosition;
                position.y = value * HexMetrics.elevationStep;
                position.y +=
                    (HexMetrics.SampleNoise(position).y * 2f - 1f) *
                    HexMetrics.elevationPerturbStrength;
                transform.localPosition = position;

                Vector3 uiPosition = uiRect.localPosition;
                uiPosition.z = -position.y;
                uiRect.localPosition = uiPosition;

                if (hasOutgoingRiver && elevation < GetNeighbor(outgoingRiver).elevation)
                {
                    RemoveOutgoingRiver();
                }

                if (hasIncomingRiver && elevation < GetNeighbor(incomingRiver).elevation)
                {
                    RemoveIncomingRiver();
                }

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

        public bool HasIncomingRiver => hasIncomingRiver;
        public bool HasOutgoingRiver => hasOutgoingRiver;
        public HexDirection IncomingRiver => incomingRiver;
        public HexDirection OutgoingRiver => outgoingRiver;
        public bool HasRiver => hasIncomingRiver || hasOutgoingRiver;
        public bool HasRiverBeginOrEnd => hasIncomingRiver != hasOutgoingRiver;
        public float StreamDebY => (elevation + HexMetrics.streamBedElevationOffset) 
                                   * HexMetrics.elevationStep;

        public float RiverSurfaceY => (elevation + HexMetrics.waterElevationOffset) 
                                      * HexMetrics.elevationStep;
        
        public float WaterSurfaceY =>
            (waterLevel + HexMetrics.waterElevationOffset) *
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
            hasIncomingRiver ? incomingRiver : outgoingRiver;
        
        public int WaterLevel {
            get => waterLevel;
            set {
                if (waterLevel == value) {
                    return;
                }
                waterLevel = value;
                Refresh();
            }
        }
        public bool IsUnderwater => waterLevel > elevation;

        #endregion

        #region Rivers

        public bool HasRiverThroughEdge(HexDirection direction)
        {
            return hasIncomingRiver && incomingRiver == direction ||
                   hasOutgoingRiver && outgoingRiver == direction;
        }

        public void RemoveOutgoingRiver()
        {
            if (!hasOutgoingRiver) return;
            hasOutgoingRiver = false;
            RefreshSelfOnly();

            HexCell neighbor = GetNeighbor(outgoingRiver);
            neighbor.hasIncomingRiver = false;
            neighbor.RefreshSelfOnly();
        }

        public void RemoveIncomingRiver()
        {
            if (!hasIncomingRiver) return;
            hasIncomingRiver = false;
            RefreshSelfOnly();

            HexCell neighbor = GetNeighbor(incomingRiver);
            neighbor.hasOutgoingRiver = false;
            neighbor.RefreshSelfOnly();
        }

        public void RemoveRiver()
        {
            RemoveOutgoingRiver();
            RemoveIncomingRiver();
        }

        public void SetOutgoingRiver(HexDirection direction)
        {
            if (hasOutgoingRiver && outgoingRiver == direction) return;
            HexCell neighbor = GetNeighbor(direction);
            if (!neighbor || elevation < neighbor.elevation) return;
            RemoveOutgoingRiver();
            if (hasIncomingRiver && incomingRiver == direction)
            {
                RemoveIncomingRiver();
            }

            hasOutgoingRiver = true;
            outgoingRiver = direction;
            
            neighbor.RemoveIncomingRiver();
            neighbor.hasIncomingRiver = true;
            neighbor.incomingRiver = direction.Opposite();
            
            SetRoad((int)direction, false);
        }

        #endregion

        void RefreshSelfOnly()
        {
            chunk.Refresh();
        }

        public Vector3 Position
        {
            get { return transform.localPosition; }
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

        public int GetElevationDifference(HexDirection direction)
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
                for (int i = 0; i < neighbors.Length; i++)
                {
                    HexCell neighbor = neighbors[i];
                    if (neighbor != null && neighbor.chunk != chunk)
                    {
                        neighbor.chunk.Refresh();
                    }
                }
            }
        }
    }
}
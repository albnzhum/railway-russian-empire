using UnityEngine;

namespace LandscapeGenerator
{
    public class HexGridChunk : MonoBehaviour
    {
        private HexCell[] _cells;
        public HexMesh terrain, rivers, roads, water, waterShore, estuaries;
        private Canvas _gridCanvas;
        public HexFeatureManager features;

        private void Awake()
        {
            _gridCanvas = GetComponentInChildren<Canvas>();
            _cells = new HexCell[HexMetrics.ChunkSizeX * HexMetrics.ChunkSizeZ];
            ShowUI(false);
        }

        public void AddCell (int index, HexCell cell) {
            _cells[index] = cell;
            cell.chunk = this;
            cell.transform.SetParent(transform, false);
            cell.uiRect.SetParent(_gridCanvas.transform, false);
        }

        public void Refresh () {
            enabled = true;
        }

        void LateUpdate () {
            Triangulate();
            enabled = false;
        }

        public void ShowUI(bool visible)
        {
            _gridCanvas.gameObject.SetActive(visible);
        }

        #region Triangulate

        /// <summary>
        /// Triangulates an array of HexCells to create the mesh
        /// </summary>
        void Triangulate()
        {
            terrain.Clear();
            rivers.Clear();
            roads.Clear();
            water.Clear();
            waterShore.Clear();
            estuaries.Clear();
            features.Clear();

            for (int i = 0; i < _cells.Length; i++)
            {
                Triangulate(_cells[i]);
            }
            terrain.Apply();
            rivers.Apply();
            roads.Apply();
            water.Apply();
            waterShore.Apply();
            estuaries.Apply();
            features.Apply();
        }
        
        /// <summary>
        /// Triangulates a single HexCell
        /// </summary>
        void Triangulate(HexCell cell)
        {
            for (HexDirection d = HexDirection.Ne; d <= HexDirection.Nw; d++)
            {
                Triangulate(d, cell);
            }
            /*if (!cell.IsUnderwater && !cell.HasRiver && !cell.HasRoads) {
                features.AddFeature(cell.Position);
            }*/
        }
        
        /// <summary>
        /// Triangulates a specific direction of a hexagonal cells
        /// </summary>
        void Triangulate(HexDirection direction, HexCell cell)
        {
            Vector3 center = cell.Position;
            EdgeVertices e = new EdgeVertices(
                center + HexMetrics.GetFirstSolidCorner(direction),
                center + HexMetrics.GetSecondSolidCorner(direction)
            );

            if (cell.HasRiver) {
                if (cell.HasRiverThroughEdge(direction)) {
                    e.V3.y = cell.StreamDebY;
                    if (cell.HasRiverBeginOrEnd) {
                        TriangulateWithRiverBeginOrEnd(direction, cell, center, e);
                    }
                    else {
                        TriangulateWithRiver(direction, cell, center, e);
                    }
                }
                else {
                    TriangulateAdjacentToRiver(direction, cell, center, e);
                }
            }
            else {
                TriangulateWithoutRiver(direction, cell, center, e);
                if (!cell.IsUnderwater && !cell.HasRoadThroughEdge(direction)) {
                    features.AddFeature(cell, (center + e.V1 + e.V5) * (1f / 3f));
                }
            }

            if (direction <= HexDirection.Se) {
                TriangulateConnection(direction, cell, e);
            }

            if (cell.IsUnderwater)
            {
                TriangulateWater(direction, cell, center);
            }
        }

        /// <summary>
        /// Triangulate the connection between two cells
        /// </summary>
        void TriangulateConnection (
            HexDirection direction, HexCell cell, EdgeVertices e1
        ) {
            HexCell neighbor = cell.GetNeighbor(direction);
            if (neighbor == null) {
                return;
            }

            Vector3 bridge = HexMetrics.GetBridge(direction);
            bridge.y = neighbor.Position.y - cell.Position.y;
            EdgeVertices e2 = new EdgeVertices(
                e1.V1 + bridge,
                e1.V5 + bridge);
            
            bool hasRiver = cell.HasRiverThroughEdge(direction);
            bool hasRoad = cell.HasRoadThroughEdge(direction);

            if (hasRiver)
            {
                e2.V3.y = neighbor.StreamDebY;
                if (!cell.IsUnderwater) {
                    if (!neighbor.IsUnderwater) {
                        TriangulateRiverQuad(
                            e1.V2, e1.V4, e2.V2, e2.V4,
                            cell.RiverSurfaceY, neighbor.RiverSurfaceY, 0.8f,
                            cell.HasIncomingRiver && cell.IncomingRiver == direction
                        );
                    }
                    else if (cell.Elevation > neighbor.WaterLevel) {
                        TriangulateWaterfallInWater(
                            e1.V2, e1.V4, e2.V2, e2.V4,
                            cell.RiverSurfaceY, neighbor.RiverSurfaceY,
                            neighbor.WaterSurfaceY
                        );
                    }
                }
                else if (
                    !neighbor.IsUnderwater &&
                    neighbor.Elevation > cell.WaterLevel
                ) {
                    TriangulateWaterfallInWater(
                        e2.V4, e2.V2, e1.V4, e1.V2,
                        neighbor.RiverSurfaceY, cell.RiverSurfaceY,
                        cell.WaterSurfaceY
                    );
                }
            }

            if (cell.GetEdgeType(direction) == HexEdgeType.Slope) {
                TriangulateEdgeTerraces(
                    e1, cell, e2, neighbor, cell.HasRoadThroughEdge(direction));
            }
            else {
                TriangulateEdgeStrip(e1, cell.Color, e2, neighbor.Color, cell.HasRoadThroughEdge(direction));
            }

            features.AddWall(e1, cell, e2, neighbor, hasRiver, hasRoad);
            
            HexCell nextNeighbor = cell.GetNeighbor(direction.Next());
            if (direction <= HexDirection.E && nextNeighbor != null)
            {
                Vector3 v5 = e1.V5 + HexMetrics.GetBridge(direction.Next());
                v5.y = nextNeighbor.Position.y;
                if (cell.Elevation <= neighbor.Elevation) {
                    if (cell.Elevation <= nextNeighbor.Elevation) {
                        TriangulateCorner(
                            e1.V5, cell, e2.V5, neighbor, v5, nextNeighbor);
                    }
                    else {
                        TriangulateCorner(
                            v5, nextNeighbor, e1.V5, cell, e2.V5, neighbor);
                    }
                }
                else if (neighbor.Elevation <= nextNeighbor.Elevation) {
                    TriangulateCorner(
                        e2.V5, neighbor, v5, nextNeighbor, e1.V5, cell);
                }
                else {
                    TriangulateCorner(
                        v5, nextNeighbor, e1.V5, cell, e2.V5, neighbor);
                }
            }
        }

        /// <summary>
        /// Triangulates a slope edge between two cells
        /// </summary>
        void TriangulateEdgeTerraces(
            EdgeVertices begin, HexCell beginCell,
            EdgeVertices end, HexCell endCell, bool hasRoad)
        {
            EdgeVertices e2 = EdgeVertices.TerraceLerp(begin, end, 1);
            Color c2 = HexMetrics.TerraceLerp(beginCell.Color, endCell.Color, 1);
            
            TriangulateEdgeStrip(begin, beginCell.Color, e2, c2);

            for (int i = 2; i < HexMetrics.TerraceSteps; i++)
            {
                EdgeVertices e1 = e2;
                Color c1 = c2;
                e2 = EdgeVertices.TerraceLerp(begin, end, i);
                c2 = HexMetrics.TerraceLerp(beginCell.Color, endCell.Color, i);
                TriangulateEdgeStrip(e1, c1, e2, c2, hasRoad);
            }
            TriangulateEdgeStrip(e2, c2, end, endCell.Color, hasRoad);
        }

        /// <summary>
        /// Triangulates a corner between three hex cells with terraces
        /// </summary>
        void TriangulateCorner(
            Vector3 bottom, HexCell bottomCell,
            Vector3 left, HexCell leftCell,
            Vector3 right, HexCell rightCell)
        {
            HexEdgeType leftEdgeType = bottomCell.GetEdgeType(leftCell);
            HexEdgeType rightEdgeType = bottomCell.GetEdgeType(rightCell);

            if (leftEdgeType == HexEdgeType.Slope) {
                if (rightEdgeType == HexEdgeType.Slope) {
                    TriangulateCornerTerrace(
                        bottom, bottomCell, left, leftCell, right, rightCell
                    );
                }
                else if (rightEdgeType == HexEdgeType.Flat) {
                    TriangulateCornerTerrace(
                        left, leftCell, right, rightCell, bottom, bottomCell
                    );
                }
                else {
                    TriangulateCornerTerraceCliff(
                        bottom, bottomCell, left, leftCell, right, rightCell
                    );
                }
            }
            else if (rightEdgeType == HexEdgeType.Slope) {
                if (leftEdgeType == HexEdgeType.Flat) {
                    TriangulateCornerTerrace(
                        right, rightCell, bottom, bottomCell, left, leftCell
                    );
                }
                else {
                    TriangulateCornerCliffTerrace(
                        bottom, bottomCell, left, leftCell, right, rightCell
                    );
                }
            }
            else if (leftCell.GetEdgeType(rightCell) == HexEdgeType.Slope) {
                if (leftCell.Elevation < rightCell.Elevation) {
                    TriangulateCornerCliffTerrace(
                        right, rightCell, bottom, bottomCell, left, leftCell
                    );
                }
                else {
                    TriangulateCornerTerraceCliff(
                        left, leftCell, right, rightCell, bottom, bottomCell
                    );
                }
            }
            else {
                terrain.AddTriangle(bottom, left, right);
                terrain.AddTriangleColor(bottomCell.Color, leftCell.Color, rightCell.Color);
            }
            features.AddWall(bottom, bottomCell, left, leftCell, right, rightCell);
        }
        
        void TriangulateCornerTerrace(
            Vector3 begin, HexCell beginCell,
            Vector3 left, HexCell leftCell,
            Vector3 right, HexCell rightCell)
        {
            Vector3 v3 = HexMetrics.TerraceLerp(begin, left, 1);
            Vector3 v4 = HexMetrics.TerraceLerp(begin, right, 1);
            Color c3 = HexMetrics.TerraceLerp(beginCell.Color, leftCell.Color, 1);
            Color c4 = HexMetrics.TerraceLerp(beginCell.Color, rightCell.Color, 1);
            
            terrain.AddTriangle(begin, v3, v4);
            terrain.AddTriangleColor(beginCell.Color, c3, c4);

            for (int i = 2; i < HexMetrics.TerraceSteps; i++)
            {
                Vector3 v1 = v3;
                Vector3 v2 = v4;
                Color c1 = c3;
                Color c2 = c4;
                v3 = HexMetrics.TerraceLerp(begin, left, i);
                v4 = HexMetrics.TerraceLerp(begin, right, i);
                c3 = HexMetrics.TerraceLerp(beginCell.Color, leftCell.Color, i);
                c4 = HexMetrics.TerraceLerp(beginCell.Color, rightCell.Color, i);
                terrain.AddQuad(v1, v2, v3, v4);
                terrain.AddQuadColor(c1, c2, c3, c4);
            }
            
            terrain.AddQuad(v3, v4, left, right);
            terrain.AddQuadColor(c3, c4, leftCell.Color, rightCell.Color);
        }

        /// <summary>
        /// Triangulates a corner with terraces and cliffs
        /// </summary>
        void TriangulateCornerTerraceCliff(
            Vector3 begin, HexCell beginCell,
            Vector3 left, HexCell leftCell,
            Vector3 right, HexCell rightCell)
        {
            float b = 1f / (rightCell.Elevation - beginCell.Elevation);
            if (b < 0)
            {
                b = -b;
            }
            Vector3 boundary = Vector3.Lerp(HexMetrics.Perturb(begin), HexMetrics.Perturb(right), b);
            Color boundaryColor = Color.Lerp(beginCell.Color, rightCell.Color, b);

            TriangulateBoundaryTriangle(
                begin, beginCell, left, leftCell, boundary, boundaryColor);

            if (leftCell.GetEdgeType(rightCell) == HexEdgeType.Slope)
            {
                TriangulateBoundaryTriangle(
                    left, leftCell, right, rightCell, boundary, boundaryColor);
            }
            else
            {
                terrain.AddTriangleUnperturbed(HexMetrics.Perturb(left), HexMetrics.Perturb(right), boundary);
                terrain.AddTriangleColor(leftCell.Color, rightCell.Color, boundaryColor);
            }
        }
        
        void TriangulateCornerCliffTerrace(
            Vector3 begin, HexCell beginCell,
            Vector3 left, HexCell leftCell,
            Vector3 right, HexCell rightCell)
        {
            float b = 1f / (leftCell.Elevation - beginCell.Elevation);
            if (b < 0)
            {
                b = -b;
            }
            Vector3 boundary = Vector3.Lerp(HexMetrics.Perturb(begin), HexMetrics.Perturb(left), b);
            Color boundaryColor = Color.Lerp(beginCell.Color, leftCell.Color, b);

            TriangulateBoundaryTriangle(
                right, rightCell, begin, beginCell, boundary, boundaryColor);

            if (leftCell.GetEdgeType(rightCell) == HexEdgeType.Slope)
            {
                TriangulateBoundaryTriangle(
                    left, leftCell, right, rightCell, boundary, boundaryColor);
            }
            else
            {
                terrain.AddTriangleUnperturbed(HexMetrics.Perturb(left), HexMetrics.Perturb(right), boundary);
                terrain.AddTriangleColor(leftCell.Color, rightCell.Color, boundaryColor);
            }
        }

        /// <summary>
        /// Triangulates a boundary triangle
        /// </summary>
        void TriangulateBoundaryTriangle(
            Vector3 begin, HexCell beginCell,
            Vector3 left, HexCell leftCell,
            Vector3 boundary, Color boundaryColor)
        {
            Vector3 v2 = HexMetrics.Perturb(HexMetrics.TerraceLerp(begin, left, 1));
            Color c2 = HexMetrics.TerraceLerp(beginCell.Color, leftCell.Color, 1);
            
            terrain.AddTriangleUnperturbed(HexMetrics.Perturb(begin), v2, boundary);
            terrain.AddTriangleColor(beginCell.Color, c2, boundaryColor);

            for (int i = 2; i < HexMetrics.TerraceSteps; i++)
            {
                Vector3 v1 = v2;
                Color c1 = c2;
                v2 = HexMetrics.Perturb(HexMetrics.TerraceLerp(begin, left, i));
                c2 = HexMetrics.TerraceLerp(beginCell.Color, leftCell.Color, i);
                terrain.AddTriangleUnperturbed(v1, v2, boundary);
                terrain.AddTriangleColor(c1, c2, boundaryColor);
            }
            
            terrain.AddTriangle(v2, HexMetrics.Perturb(left), boundary);
            terrain.AddTriangleColor(c2, leftCell.Color, boundaryColor);
        }

        void TriangulateEdgeFan(Vector3 center, EdgeVertices edge, Color color)
        {
            terrain.AddTriangle(center, edge.V1, edge.V2);
            terrain.AddTriangleColor(color);
            terrain.AddTriangle(center, edge.V2, edge.V3);
            terrain.AddTriangleColor(color);
            terrain.AddTriangle(center, edge.V3, edge.V4);
            terrain.AddTriangleColor(color);
            terrain.AddTriangle(center, edge.V4, edge.V5);
            terrain.AddTriangleColor(color);
        }

        void TriangulateEdgeStrip(EdgeVertices e1, Color c1,
            EdgeVertices e2, Color c2, bool hasRoad = false)
        {
            terrain.AddQuad(e1.V1, e1.V2, e2.V1, e2.V2);
            terrain.AddQuadColor(c1, c2);
            terrain.AddQuad(e1.V2, e1.V3, e2.V2, e2.V3);
            terrain.AddQuadColor(c1, c2);
            terrain.AddQuad(e1.V3, e1.V4, e2.V3, e2.V4);
            terrain.AddQuadColor(c1, c2);
            terrain.AddQuad(e1.V4, e1.V5, e2.V4, e2.V5);
            terrain.AddQuadColor(c1, c2);

            if (hasRoad) {
                TriangulateRoadSegment(e1.V2, e1.V3, e1.V4, e2.V2, e2.V3, e2.V4);
            }
        }

        #endregion
        
        #region Triangulate Rivers

        void TriangulateRiverQuad(Vector3 v1, Vector3 v2, Vector3 v3, Vector3 v4, 
            float y1, float y2, float v, bool reversed)
        {
            v1.y = v2.y = y1;
            v3.y = v4.y = y2;
            rivers.AddQuad(v1, v2, v3, v4);
            if (reversed)
            {
                rivers.AddQuadUV(1f, 0f, 0.8f - v, 0.6f - v);
            }
            else
            {
                rivers.AddQuadUV(0f, 1f, v, v +0.2f);
            }
        }

        void TriangulateRiverQuad(
            Vector3 v1, Vector3 v2, Vector3 v3, Vector3 v4, float y, float v, bool reversed)
        {
            TriangulateRiverQuad(v1, v2, v3, v4, y, y, v, reversed);
        }

        void TriangulateWithRiver(HexDirection direction, HexCell cell, Vector3 center, EdgeVertices e)
        {
            Vector3 centerL, centerR;
            if (cell.HasRiverThroughEdge(direction.Opposite())) {
                centerL = center +
                          HexMetrics.GetFirstSolidCorner(direction.Previous()) * 0.25f;
                centerR = center +
                          HexMetrics.GetSecondSolidCorner(direction.Next()) * 0.25f;
            }
            else if (cell.HasRiverThroughEdge(direction.Next())) {
                centerL = center;
                centerR = Vector3.Lerp(center, e.V5, 2f / 3f);
            }
            else if (cell.HasRiverThroughEdge(direction.Previous())) {
                centerL = Vector3.Lerp(center, e.V1, 2f / 3f);
                centerR = center;
            }
            else if (cell.HasRiverThroughEdge(direction.Next2())) {
                centerL = center;
                centerR = center +
                          HexMetrics.GetSolidEdgeMiddle(direction.Next()) *
                          (0.5f * HexMetrics.InnerToOuter);
            }
            else {
                centerL = center +
                          HexMetrics.GetSolidEdgeMiddle(direction.Previous()) *
                          (0.5f * HexMetrics.InnerToOuter);
                centerR = center;
            }
            center = Vector3.Lerp(centerL, centerR, 0.5f);

            EdgeVertices m = new EdgeVertices(
                Vector3.Lerp(centerL, e.V1, 0.5f),
                Vector3.Lerp(centerR, e.V5, 0.5f),
                1f / 6f
            );
            m.V3.y = center.y = e.V3.y;

            TriangulateEdgeStrip(m, cell.Color, e, cell.Color);

            terrain.AddTriangle(centerL, m.V1, m.V2);
            terrain.AddTriangleColor(cell.Color);
            terrain.AddQuad(centerL, center, m.V2, m.V3);
            terrain.AddQuadColor(cell.Color);
            terrain.AddQuad(center, centerR, m.V3, m.V4);
            terrain.AddQuadColor(cell.Color);
            terrain.AddTriangle(centerR, m.V4, m.V5);
            terrain.AddTriangleColor(cell.Color);

            if (!cell.IsUnderwater)
            {
                bool reversed = cell.IncomingRiver == direction;
                TriangulateRiverQuad(
                    centerL, centerR, m.V2, m.V4, cell.RiverSurfaceY, 0.4f, reversed
                );
                TriangulateRiverQuad(
                    m.V2, m.V4, e.V2, e.V4, cell.RiverSurfaceY, 0.6f, reversed
                );
            }
        }

        private void TriangulateAdjacentToRiver (
            HexDirection direction, HexCell cell, Vector3 center, EdgeVertices e) {
            if (cell.HasRoads)
            {
                TriangulateRoadAdjacentToRiver(direction, cell, center, e);
            }
            if (cell.HasRiverThroughEdge(direction.Next())) {
                if (cell.HasRiverThroughEdge(direction.Previous())) {
                    center += HexMetrics.GetSolidEdgeMiddle(direction) *
                              (HexMetrics.InnerToOuter * 0.5f);
                }
                else if (
                    cell.HasRiverThroughEdge(direction.Previous2())
                ) {
                    center += HexMetrics.GetFirstSolidCorner(direction) * 0.25f;
                }
            }
            else if (
                cell.HasRiverThroughEdge(direction.Previous()) &&
                cell.HasRiverThroughEdge(direction.Next2())
            ) {
                center += HexMetrics.GetSecondSolidCorner(direction) * 0.25f;
            }

            EdgeVertices m = new EdgeVertices(
                Vector3.Lerp(center, e.V1, 0.5f),
                Vector3.Lerp(center, e.V5, 0.5f)
            );

            TriangulateEdgeStrip(m, cell.Color, e, cell.Color);
            TriangulateEdgeFan(center, m, cell.Color);
            
            if (!cell.IsUnderwater && !cell.HasRoadThroughEdge(direction)) {
                features.AddFeature(cell, (center + e.V1 + e.V5) * (1f / 3f));
            }
        }

        private void TriangulateWithRiverBeginOrEnd (
            HexDirection direction, HexCell cell, Vector3 center, EdgeVertices e) {
            EdgeVertices m = new EdgeVertices(
                Vector3.Lerp(center, e.V1, 0.5f),
                Vector3.Lerp(center, e.V5, 0.5f)
            );
            m.V3.y = e.V3.y;

            TriangulateEdgeStrip(m, cell.Color, e, cell.Color);
            TriangulateEdgeFan(center, m, cell.Color);

            if (!cell.IsUnderwater)
            {
                bool reversed = cell.HasIncomingRiver;
                TriangulateRiverQuad(
                    m.V2, m.V4, e.V2, e.V4, cell.RiverSurfaceY, 0.6f, reversed
                );
                center.y = m.V2.y = m.V4.y = cell.RiverSurfaceY;
                rivers.AddTriangle(center, m.V2, m.V4);
                if (reversed) {
                    rivers.AddTriangleUV(
                        new Vector2(0.5f, 0.4f),
                        new Vector2(1f, 0.2f), new Vector2(0f, 0.2f)
                    );
                }
                else {
                    rivers.AddTriangleUV(
                        new Vector2(0.5f, 0.4f),
                        new Vector2(0f, 0.6f), new Vector2(1f, 0.6f)
                    );
                }
            }
        }

        void TriangulateWithoutRiver (
            HexDirection direction, HexCell cell, Vector3 center, EdgeVertices e
        ) {
            TriangulateEdgeFan(center, e, cell.Color);

            if (cell.HasRoads) {
                Vector2 interpolators = GetRoadInterpolators(direction, cell);
                TriangulateRoad(
                    center,
                    Vector3.Lerp(center, e.V1, interpolators.x),
                    Vector3.Lerp(center, e.V5, interpolators.y),
                    e, cell.HasRoadThroughEdge(direction)
                );
            }
        }

        #endregion

        #region Triangulate Roads

        void TriangulateRoadSegment(
            Vector3 v1, Vector3 v2, Vector3 v3,
            Vector3 v4, Vector3 v5, Vector3 v6)
        {
            roads.AddQuad(v1, v2, v4, v5);
            roads.AddQuad(v2, v3, v5, v6);
            
            roads.AddQuadUV(0f, 1f, 0f, 0f);
            roads.AddQuadUV(1f, 0f, 0f, 0f);
        }

        void TriangulateRoad(Vector3 center, Vector3 mL, 
            Vector3 mR, EdgeVertices e, bool hasRoadThroughCellEdge)
        {
            if (hasRoadThroughCellEdge)
            {
                Vector3 mC = Vector3.Lerp(mL, mR, 0.5f);
                TriangulateRoadSegment(mL, mC, mR, e.V2, e.V3, e.V4);
                roads.AddTriangle(center, mL, mC);
                roads.AddTriangle(center, mC, mR);
                roads.AddTriangleUV(
                    new Vector2(1f, 0f), new Vector2(0f, 0f), new Vector2(1f, 0f));
                roads.AddTriangleUV(
                    new Vector2(1f, 0f), new Vector2(1f, 0f), new Vector2(0f, 0f));
            }
            else
            {
                TriangulateRoadEdge(center, mL, mR);
            }
        }

        void TriangulateRoadEdge(Vector3 center, Vector3 mL, Vector3 mR)
        {
            roads.AddTriangle(center, mL, mR);
            roads.AddTriangleUV(
                new Vector2(1f, 0f), new Vector2(0f, 0f), new Vector2(0f, 0f));
        }

        void TriangulateRoadAdjacentToRiver(
            HexDirection direction, HexCell cell, Vector3 center, EdgeVertices e)
        {
            bool hasRoadThroughEdge = cell.HasRoadThroughEdge(direction);
            bool previousHasRiver = cell.HasRiverThroughEdge(direction.Previous());
            bool nextHasRiver = cell.HasRiverThroughEdge(direction.Next());
            Vector2 interpolators = GetRoadInterpolators(direction, cell);
            Vector3 roadCenter = center;

            if (cell.HasRiverBeginOrEnd) {
                roadCenter += HexMetrics.GetSolidEdgeMiddle(
                    cell.RiverBeginOrEndDirection.Opposite()
                ) * (1f / 3f);
            }
            else if (cell.IncomingRiver == cell.OutgoingRiver.Opposite()) {
                Vector3 corner;
                if (previousHasRiver) {
                    if (
                        !hasRoadThroughEdge &&
                        !cell.HasRoadThroughEdge(direction.Next())
                    ) {
                        return;
                    }
                    corner = HexMetrics.GetSecondSolidCorner(direction);
                    
                    roadCenter += corner * 0.5f;
                    if (cell.IncomingRiver == direction.Next() && (
                            cell.HasRoadThroughEdge(direction.Next2()) ||
                            cell.HasRoadThroughEdge(direction.Opposite())
                        )) {
                        features.AddBridge(roadCenter, center - corner * 0.5f);
                    }
                    center += corner * 0.25f;
                }
                else {
                    if (
                        !hasRoadThroughEdge &&
                        !cell.HasRoadThroughEdge(direction.Previous())
                    ) {
                        return;
                    }
                    HexMetrics.GetFirstSolidCorner(direction);
                }
            }
            else if (cell.IncomingRiver == cell.OutgoingRiver.Previous()) {
                roadCenter -= HexMetrics.GetSecondCorner(cell.IncomingRiver) * 0.2f;
            }
            else if (cell.IncomingRiver == cell.OutgoingRiver.Next()) {
                roadCenter -= HexMetrics.GetFirstCorner(cell.IncomingRiver) * 0.2f;
            }
            else if (previousHasRiver && nextHasRiver) {
                if (!hasRoadThroughEdge) {
                    return;
                }
                Vector3 offset = HexMetrics.GetSolidEdgeMiddle(direction) *
                                 HexMetrics.InnerToOuter;
                roadCenter += offset * 0.7f;
                center += offset * 0.5f;
            }
            else {
                HexDirection middle;
                if (previousHasRiver) {
                    middle = direction.Next();
                }
                else if (nextHasRiver) {
                    middle = direction.Previous();
                }
                else {
                    middle = direction;
                }
                if (
                    !cell.HasRoadThroughEdge(middle) &&
                    !cell.HasRoadThroughEdge(middle.Previous()) &&
                    !cell.HasRoadThroughEdge(middle.Next())
                ) {
                    return;
                }
                roadCenter += HexMetrics.GetSolidEdgeMiddle(middle) * 0.25f;
            }

            Vector3 mL = Vector3.Lerp(roadCenter, e.V1, interpolators.x);
            Vector3 mR = Vector3.Lerp(roadCenter, e.V5, interpolators.y);
            TriangulateRoad(roadCenter, mL, mR, e, hasRoadThroughEdge);
            if (previousHasRiver) {
                TriangulateRoadEdge(roadCenter, center, mL);
            }
            if (nextHasRiver) {
                TriangulateRoadEdge(roadCenter, mR, center);
            }
        }
        
        Vector2 GetRoadInterpolators (HexDirection direction, HexCell cell) {
            Vector2 interpolators;
            if (cell.HasRoadThroughEdge(direction)) {
                interpolators.x = interpolators.y = 0.5f;
            }
            else {
                interpolators.x =
                    cell.HasRoadThroughEdge(direction.Previous()) ? 0.5f : 0.25f;
                interpolators.y =
                    cell.HasRoadThroughEdge(direction.Next()) ? 0.5f : 0.25f;
            }
            return interpolators;
        }
        
        #endregion

        #region Triangulate Water

        void TriangulateWater(
            HexDirection direction, HexCell cell, Vector3 center)
        {
            center.y = cell.WaterSurfaceY;

            HexCell neighbor = cell.GetNeighbor(direction);
            if (neighbor != null && !neighbor.IsUnderwater) {
                TriangulateWaterShore(direction, cell, neighbor, center);
            }
            else {
                TriangulateOpenWater(direction, cell, neighbor, center);
            }
        }

        void TriangulateOpenWater(
            HexDirection direction, HexCell cell, HexCell neighbor, Vector3 center)
        {
            Vector3 c1 = center + HexMetrics.GetFirstWaterCorner(direction);
            Vector3 c2 = center + HexMetrics.GetSecondWaterCorner(direction);

            water.AddTriangle(center, c1, c2);

            if (direction <= HexDirection.Se && neighbor != null) {
                Vector3 bridge = HexMetrics.GetWaterBridge(direction);
                Vector3 e1 = c1 + bridge;
                Vector3 e2 = c2 + bridge;
                
                water.AddQuad(c1, c2, e1, e2);

                if (direction <= HexDirection.E)
                {
                    HexCell nextNeighbor = cell.GetNeighbor(direction.Next());
                    if (nextNeighbor == null || !nextNeighbor.IsUnderwater) return;
                    water.AddTriangle(c2, e2, c2 + HexMetrics.GetWaterBridge(direction.Next()));
                }
            }
        }

        void TriangulateWaterShore(
            HexDirection direction, HexCell cell, HexCell neighbor, Vector3 center)
        {
            EdgeVertices e1 = new EdgeVertices(
                center + HexMetrics.GetFirstWaterCorner(direction),
                center + HexMetrics.GetSecondWaterCorner(direction)
            );
            water.AddTriangle(center, e1.V1, e1.V2);
            water.AddTriangle(center, e1.V2, e1.V3);
            water.AddTriangle(center, e1.V3, e1.V4);
            water.AddTriangle(center, e1.V4, e1.V5);
		
            Vector3 center2 = neighbor.Position;
            center2.y = center.y;
            EdgeVertices e2 = new EdgeVertices(
                center2 + HexMetrics.GetSecondSolidCorner(direction.Opposite()),
                center2 + HexMetrics.GetFirstSolidCorner(direction.Opposite())
            );
            if (cell.HasRiverThroughEdge(direction)) {
                TriangulateEstuary(e1, e2, cell.IncomingRiver == direction);
            }
            else {
                waterShore.AddQuad(e1.V1, e1.V2, e2.V1, e2.V2);
                waterShore.AddQuad(e1.V2, e1.V3, e2.V2, e2.V3);
                waterShore.AddQuad(e1.V3, e1.V4, e2.V3, e2.V4);
                waterShore.AddQuad(e1.V4, e1.V5, e2.V4, e2.V5);
                waterShore.AddQuadUV(0f, 0f, 0f, 1f);
                waterShore.AddQuadUV(0f, 0f, 0f, 1f);
                waterShore.AddQuadUV(0f, 0f, 0f, 1f);
                waterShore.AddQuadUV(0f, 0f, 0f, 1f);
            }

            HexCell nextNeighbor = cell.GetNeighbor(direction.Next());
            if (nextNeighbor != null) {
                Vector3 v3 = nextNeighbor.Position + (nextNeighbor.IsUnderwater ?
                    HexMetrics.GetFirstWaterCorner(direction.Previous()) :
                    HexMetrics.GetFirstSolidCorner(direction.Previous()));
                v3.y = center.y;
                waterShore.AddTriangle(e1.V5, e2.V5, v3);
                waterShore.AddTriangleUV(
                    new Vector2(0f, 0f),
                    new Vector2(0f, 1f),
                    new Vector2(0f, nextNeighbor.IsUnderwater ? 0f : 1f)
                );
            }
        }
        
        void TriangulateEstuary (EdgeVertices e1, EdgeVertices e2, bool incomingRiver) {
            waterShore.AddTriangle(e2.V1, e1.V2, e1.V1);
            waterShore.AddTriangle(e2.V5, e1.V5, e1.V4);
            waterShore.AddTriangleUV(
                new Vector2(0f, 1f), new Vector2(0f, 0f), new Vector2(0f, 0f)
            );
            waterShore.AddTriangleUV(
                new Vector2(0f, 1f), new Vector2(0f, 0f), new Vector2(0f, 0f)
            );
            
            estuaries.AddQuad(e1.V2, e1.V3, e2.V1, e2.V2);
            estuaries.AddTriangle(e1.V3, e2.V2, e2.V4);
            estuaries.AddQuad(e1.V3, e1.V4, e2.V4, e2.V5);
		
            estuaries.AddQuadUV(
                new Vector2(0f, 1f), new Vector2(0f, 0f),
                new Vector2(1f, 1f), new Vector2(0f, 0f)
            );
            estuaries.AddTriangleUV(
                new Vector2(0f, 0f), new Vector2(1f, 1f), new Vector2(1f, 1f)
            );
            estuaries.AddQuadUV(
                new Vector2(0f, 0f), new Vector2(0f, 0f),
                new Vector2(1f, 1f), new Vector2(0f, 1f)
            );

            if (incomingRiver) {
                estuaries.AddQuadUV2(
                    new Vector2(1.5f, 1f), new Vector2(0.7f, 1.15f),
                    new Vector2(1f, 0.8f), new Vector2(0.5f, 1.1f)
                );
                estuaries.AddTriangleUV2(
                    new Vector2(0.5f, 1.1f),
                    new Vector2(1f, 0.8f),
                    new Vector2(0f, 0.8f)
                );
                estuaries.AddQuadUV2(
                    new Vector2(0.5f, 1.1f), new Vector2(0.3f, 1.15f),
                    new Vector2(0f, 0.8f), new Vector2(-0.5f, 1f)
                );
            }
            else {
                estuaries.AddQuadUV2(
                    new Vector2(-0.5f, -0.2f), new Vector2(0.3f, -0.35f),
                    new Vector2(0f, 0f), new Vector2(0.5f, -0.3f)
                );
                estuaries.AddTriangleUV2(
                    new Vector2(0.5f, -0.3f),
                    new Vector2(0f, 0f),
                    new Vector2(1f, 0f)
                );
                estuaries.AddQuadUV2(
                    new Vector2(0.5f, -0.3f), new Vector2(0.7f, -0.35f),
                    new Vector2(1f, 0f), new Vector2(1.5f, -0.2f)
                );
            }
        }
        
        void TriangulateWaterfallInWater (
            Vector3 v1, Vector3 v2, Vector3 v3, Vector3 v4,
            float y1, float y2, float waterY
        ) {
            v1.y = v2.y = y1;
            v3.y = v4.y = y2;
            v1 = HexMetrics.Perturb(v1);
            v2 = HexMetrics.Perturb(v2);
            v3 = HexMetrics.Perturb(v3);
            v4 = HexMetrics.Perturb(v4);
            float t = (waterY - y2) / (y1 - y2);
            v3 = Vector3.Lerp(v3, v1, t);
            v4 = Vector3.Lerp(v4, v2, t);
            rivers.AddQuadUnperturbed(v1, v2, v3, v4);
            rivers.AddQuadUV(0f, 1f, 0.8f, 1f);
        }
        
        #endregion
    }
}

using System.Collections.Generic;
using System.Numerics;
using UnityEngine;
using Vector3 = UnityEngine.Vector3;
using Vector4 = UnityEngine.Vector4;

namespace LandscapeGenerator
{
    /// <summary>
    /// Generates a mesh for hexagonal grid
    /// </summary>
    [RequireComponent(typeof(MeshFilter), typeof(MeshRenderer))]

    public class HexMesh : MonoBehaviour
    {
        private Mesh hexMesh;
        private List<Vector3> vertices;
        private List<int> triangles;
        private List<Color> colors;

        private MeshCollider _meshCollider;

        private void Awake()
        {
            GetComponent<MeshFilter>().mesh = hexMesh = new Mesh();
            _meshCollider = gameObject.AddComponent<MeshCollider>();
            hexMesh.name = "Hex Mesh";
            vertices = new List<Vector3>();
            colors = new List<Color>();
            triangles = new List<int>();
        }

        /// <summary>
        /// Triangulates an array of HexCells to create the mesh
        /// </summary>
        /// <param name="cells"></param>
        public void Triangulate(HexCell[] cells)
        {
            hexMesh.Clear();
            vertices.Clear();
            triangles.Clear();
            colors.Clear();

            for (int i = 0; i < cells.Length; i++)
            {
                Triangulate(cells[i]);
            }

            hexMesh.vertices = vertices.ToArray();
            hexMesh.colors = colors.ToArray();
            hexMesh.triangles = triangles.ToArray();
            hexMesh.RecalculateNormals();
            _meshCollider.sharedMesh = hexMesh;
        }

        /// <summary>
        /// Triangulates a single HexCell
        /// </summary>
        /// <param name="cell"></param>
        void Triangulate(HexCell cell)
        {
            for (HexDirection d = HexDirection.NE; d <= HexDirection.NW; d++)
            {
                Triangulate(d, cell);
            }
        }

        /// <summary>
        /// Triangulates a specific direction of a hexagonal cells
        /// </summary>
        /// <param name="direction">The direction to be triangulated</param>
        /// <param name="cell"></param>
        void Triangulate(HexDirection direction, HexCell cell)
        {
            Vector3 center = cell.Position;
            Vector3 v1 = center + HexMetrics.GetFirstSolidCorner(direction);
            Vector3 v2 = center + HexMetrics.GetSecondSolidCorner(direction);

            Vector3 e1 = Vector3.Lerp(v1, v2, 1f/3f);
            Vector3 e2 = Vector3.Lerp(v1, v2, 2f / 3f);

            AddTriangle(center, v1, e1);
            AddTriangleColor(cell.color);
            AddTriangle(center, e1, e2);
            AddTriangleColor(cell.color);
            AddTriangle(center, e2, v2);
            AddTriangleColor(cell.color);

            if (direction <= HexDirection.SE) {
                TriangulateConnection(direction, cell, v1, e1, e2, v2);
            }
        }
        
        /// <summary>
        /// Triangulate the connection between two cells
        /// </summary>
        /// <param name="direction"></param>
        /// <param name="cell"></param>
        /// <param name="v1">First vertex of the connection</param>
        /// <param name="v2">Second vertex of the connection</param>
        void TriangulateConnection (
            HexDirection direction, HexCell cell, 
            Vector3 v1,Vector3 e1, Vector3 e2, Vector3 v2
        ) {
            HexCell neighbor = cell.GetNeighbor(direction);
            if (neighbor == null) {
                return;
            }

            Vector3 bridge = HexMetrics.GetBridge(direction);
            Vector3 v3 = v1 + bridge;
            Vector3 v4 = v2 + bridge;
            v3.y = v4.y = neighbor.Position.y;

            Vector3 e3 = Vector3.Lerp(v3, v4, 1f / 3f);
            Vector3 e4 = Vector3.Lerp(v3, v4, 2f / 3f);

            if (cell.GetEdgeType(direction) == HexEdgeType.Slope)
            {
                TriangulateEdgeTerraces(v1, v2, cell, v3, v4, neighbor);
            }
            else
            {
                AddQuad(v1, e1, v3, e3);
                AddQuadColor(cell.color, neighbor.color);
                AddQuad(e1, e2, e3, e4);
                AddQuadColor(cell.color, neighbor.color);
                AddQuad(e2, v2, e4, v4);
                AddQuadColor(cell.color, neighbor.color);
            }
            
            HexCell nextNeighbor = cell.GetNeighbor(direction.Next());
            if (direction <= HexDirection.E && nextNeighbor != null)
            {
                Vector3 v5 = v2 + HexMetrics.GetBridge(direction.Next());
                v5.y = nextNeighbor.Position.y;
                if (cell.Elevation <= neighbor.Elevation)
                {
                    if (cell.Elevation <= nextNeighbor.Elevation)
                    {
                        TriangulateCorner(v2, cell, v4, neighbor, v5, nextNeighbor);
                    }
                    else
                    {
                        TriangulateCorner(v5, nextNeighbor, v2, cell, v4, neighbor);
                    }
                }
                else if (neighbor.Elevation <= nextNeighbor.Elevation)
                {
                    TriangulateCorner(v4, neighbor, v5, nextNeighbor, v2, cell);
                }
                else
                {
                    TriangulateCorner(v5, nextNeighbor, v2, cell, v4, neighbor);
                }
            }
        }

        /// <summary>
        /// Triangulates a slope edge between two cells
        /// </summary>
        /// <param name="beginLeft">The left vertex at the beginning</param>
        /// <param name="beginRight">The right vertex at the beginning</param>
        /// <param name="beginCell">The cell at the beginning</param>
        /// <param name="endLeft">The left vertex at the end</param>
        /// <param name="endRight">The right vertex at the end</param>
        /// <param name="endCell">The cell at the end</param>
        void TriangulateEdgeTerraces(
            Vector3 beginLeft, Vector3 beginRight, HexCell beginCell, Vector3 endLeft,
            Vector3 endRight, HexCell endCell)
        {
            Vector3 v3 = HexMetrics.TerraceLerp(beginLeft, endLeft, 1);
            Vector3 v4 = HexMetrics.TerraceLerp(beginRight, endRight, 1);
            Color c2 = HexMetrics.TerraceLerp(beginCell.color, endCell.color, 1);
            AddQuad(beginLeft, beginRight, v3, v4);
            AddQuadColor(beginCell.color, c2);

            for (int i = 2; i < HexMetrics.terraceSteps; i++)
            {
                Vector3 v1 = v3;
                Vector3 v2 = v4;
                Color c1 = c2;
                v3 = HexMetrics.TerraceLerp(beginLeft, endLeft, i);
                v4 = HexMetrics.TerraceLerp(beginRight, endRight, i);
                c2 = HexMetrics.TerraceLerp(beginCell.color, endCell.color, i);
                AddQuad(v1, v2, v3, v4);
                AddQuadColor(c1, c2);
            }
            
            AddQuad(v3, v4, endLeft, endRight);
            AddQuadColor(c2, endCell.color);
        }

        /// <summary>
        /// Triangulates a corner between three hex cells with terraces
        /// </summary>
        /// <param name="bottom"></param>
        /// <param name="bottomCell"></param>
        /// <param name="left"></param>
        /// <param name="leftCell"></param>
        /// <param name="right"></param>
        /// <param name="rightCell"></param>
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
                AddTriangle(bottom, left, right);
                AddTriangleColor(bottomCell.color, leftCell.color, rightCell.color);
            }
        }
        
        void TriangulateCornerTerrace(
            Vector3 begin, HexCell beginCell,
            Vector3 left, HexCell leftCell,
            Vector3 right, HexCell rightCell)
        {
            Vector3 v3 = HexMetrics.TerraceLerp(begin, left, 1);
            Vector3 v4 = HexMetrics.TerraceLerp(begin, right, 1);
            Color c3 = HexMetrics.TerraceLerp(beginCell.color, leftCell.color, 1);
            Color c4 = HexMetrics.TerraceLerp(beginCell.color, rightCell.color, 1);
            
            AddTriangle(begin, v3, v4);
            AddTriangleColor(beginCell.color, c3, c4);

            for (int i = 2; i < HexMetrics.terraceSteps; i++)
            {
                Vector3 v1 = v3;
                Vector3 v2 = v4;
                Color c1 = c3;
                Color c2 = c4;
                v3 = HexMetrics.TerraceLerp(begin, left, i);
                v4 = HexMetrics.TerraceLerp(begin, right, i);
                c3 = HexMetrics.TerraceLerp(beginCell.color, leftCell.color, i);
                c4 = HexMetrics.TerraceLerp(beginCell.color, rightCell.color, i);
                AddQuad(v1, v2, v3, v4);
                AddQuadColor(c1, c2, c3, c4);
            }
            
            AddQuad(v3, v4, left, right);
            AddQuadColor(c3, c4, leftCell.color, rightCell.color);
        }

        /// <summary>
        /// Triangulates a corner with terraces and cliffs
        /// </summary>
        /// <param name="begin"></param>
        /// <param name="beginCell"></param>
        /// <param name="left"></param>
        /// <param name="leftCell"></param>
        /// <param name="right"></param>
        /// <param name="rightCell"></param>
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
            Vector3 boundary = Vector3.Lerp(begin, right, b);
            Color boundaryColor = Color.Lerp(beginCell.color, rightCell.color, b);

            TriangulateBoundaryTriangle(
                begin, beginCell, left, leftCell, boundary, boundaryColor);

            if (leftCell.GetEdgeType(rightCell) == HexEdgeType.Slope)
            {
                TriangulateBoundaryTriangle(
                    left, leftCell, right, rightCell, boundary, boundaryColor);
            }
            else
            {
                AddTriangle(left, right, boundary);
                AddTriangleColor(leftCell.color, rightCell.color, boundaryColor);
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
            Vector3 boundary = Vector3.Lerp(begin, right, b);
            Color boundaryColor = Color.Lerp(beginCell.color, leftCell.color, b);

            TriangulateBoundaryTriangle(
                right, rightCell, begin, beginCell, boundary, boundaryColor);

            if (leftCell.GetEdgeType(rightCell) == HexEdgeType.Slope)
            {
                TriangulateBoundaryTriangle(
                    left, leftCell, right, rightCell, boundary, boundaryColor);
            }
            else
            {
                AddTriangle(left, right, boundary);
                AddTriangleColor(leftCell.color, rightCell.color, boundaryColor);
            }
        }

        /// <summary>
        /// Triangulates a boundary triangle
        /// </summary>
        /// <param name="begin"></param>
        /// <param name="beginCell"></param>
        /// <param name="left"></param>
        /// <param name="leftCell"></param>
        /// <param name="boundary"></param>
        /// <param name="boundaryColor"></param>
        void TriangulateBoundaryTriangle(
            Vector3 begin, HexCell beginCell,
            Vector3 left, HexCell leftCell,
            Vector3 boundary, Color boundaryColor)
        {
            Vector3 v2 = HexMetrics.TerraceLerp(begin, left, 1);
            Color c2 = HexMetrics.TerraceLerp(beginCell.color, leftCell.color, 1);
            
            AddTriangle(begin, v2, boundary);
            AddTriangleColor(beginCell.color, c2, boundaryColor);

            for (int i = 2; i < HexMetrics.terraceSteps; i++)
            {
                Vector3 v1 = v2;
                Color c1 = c2;
                v2 = HexMetrics.TerraceLerp(begin, left, i);
                c2 = HexMetrics.TerraceLerp(beginCell.color, leftCell.color, i);
                AddTriangle(v1, v2, boundary);
                AddTriangleColor(c1, c2, boundaryColor);
            }
            
            AddTriangle(v2, Vector3.left, boundary);
            AddTriangleColor(c2, leftCell.color, boundaryColor);
        }

        /// <summary>
        /// Adds a triangle to the mesh
        /// </summary>
        /// <param name="v1"></param>
        /// <param name="v2"></param>
        /// <param name="v3"></param>
        void AddTriangle(Vector3 v1, Vector3 v2, Vector3 v3)
        {
            int vertexIndex = vertices.Count;
            vertices.Add(Perturb(v1));
            vertices.Add(Perturb(v2));
            vertices.Add(Perturb(v3));
            triangles.Add(vertexIndex);
            triangles.Add(vertexIndex + 1);
            triangles.Add(vertexIndex + 2);
        }

        /// <summary>
        /// Adds color for a single triangle
        /// </summary>
        /// <param name="color"></param>
        void AddTriangleColor (Color color) {
            colors.Add(color);
            colors.Add(color);
            colors.Add(color);
        }

        void AddTriangleColor (Color c1, Color c2, Color c3) {
            colors.Add(c1);
            colors.Add(c2);
            colors.Add(c3);
        }
        
        void AddQuad (Vector3 v1, Vector3 v2, Vector3 v3, Vector3 v4) {
            int vertexIndex = vertices.Count;
            vertices.Add(Perturb(v1));
            vertices.Add(Perturb(v2));
            vertices.Add(Perturb(v3));
            vertices.Add(Perturb(v4));
            triangles.Add(vertexIndex);
            triangles.Add(vertexIndex + 2);
            triangles.Add(vertexIndex + 1);
            triangles.Add(vertexIndex + 1);
            triangles.Add(vertexIndex + 2);
            triangles.Add(vertexIndex + 3);
        }

        void AddQuadColor (Color c1, Color c2) {
            colors.Add(c1);
            colors.Add(c1);
            colors.Add(c2);
            colors.Add(c2);
        }
        
        void AddQuadColor (Color c1, Color c2, Color c3, Color c4) {
            colors.Add(c1);
            colors.Add(c2);
            colors.Add(c3);
            colors.Add(c4);
        }

        Vector3 Perturb(Vector3 position)
        {
            Vector4 sample = HexMetrics.SampleNoise(position);
            position.x += (sample.x * 2f - 1f) * HexMetrics.cellPerturbStrength;
            //position.y += (sample.y * 2f - 1f) * HexMetrics.cellPerturbStrength;
            position.z += (sample.z * 2f - 1f) * HexMetrics.cellPerturbStrength;
            return position;
        }
    }
}

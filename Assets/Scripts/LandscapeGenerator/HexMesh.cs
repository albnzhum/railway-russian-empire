using System;
using System.Collections.Generic;
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
        [NonSerialized] List<Vector3> vertices;
        [NonSerialized] List<int> triangles;
        [NonSerialized] List<Color> colors;

        private MeshCollider _meshCollider;
        public bool useCollider, useColors, useUVCoordinates;

        [NonSerialized] private List<Vector2> uvs;
        private void Awake()
        {
            GetComponent<MeshFilter>().mesh = hexMesh = new Mesh();
            if (useCollider)
            {
                _meshCollider = gameObject.AddComponent<MeshCollider>();
            }
            hexMesh.name = "Hex Mesh";
        }

        public void Clear()
        {
            hexMesh.Clear();
            vertices = ListPool<Vector3>.Get();
            if (useColors)
            {
                colors = ListPool<Color>.Get();
            }

            if (useUVCoordinates)
            {
                uvs = ListPool<Vector2>.Get();
            }
            triangles = ListPool<int>.Get();
        }

        public void Apply()
        {
            hexMesh.SetVertices(vertices);
            ListPool<Vector3>.Add(vertices);
            if (useColors)
            {
                hexMesh.SetColors(colors);
                ListPool<Color>.Add(colors);
            }

            if (useUVCoordinates)
            {
                hexMesh.SetUVs(0, uvs);
                ListPool<Vector2>.Add(uvs);
            }
            hexMesh.SetTriangles(triangles, 0);
            ListPool<int>.Add(triangles);
            hexMesh.RecalculateNormals();
            if (useCollider)
            {
                _meshCollider.sharedMesh = hexMesh;
            }
        }

        #region Adds methods

        /// <summary>
        /// Adds a triangle to the mesh
        /// </summary>
        /// <param name="v1"></param>
        /// <param name="v2"></param>
        /// <param name="v3"></param>
        public void AddTriangle(Vector3 v1, Vector3 v2, Vector3 v3)
        {
            int vertexIndex = vertices.Count;
            vertices.Add(HexMetrics.Perturb(v1));
            vertices.Add(HexMetrics.Perturb(v2));
            vertices.Add(HexMetrics.Perturb(v3));
            triangles.Add(vertexIndex);
            triangles.Add(vertexIndex + 1);
            triangles.Add(vertexIndex + 2);
        }

        /// <summary>
        /// Adds color for a single triangle
        /// </summary>
        /// <param name="color"></param>
        public void AddTriangleColor (Color color) {
            colors.Add(color);
            colors.Add(color);
            colors.Add(color);
        }

        public void AddTriangleColor (Color c1, Color c2, Color c3) {
            colors.Add(c1);
            colors.Add(c2);
            colors.Add(c3);
        }
        
        public void AddQuad (Vector3 v1, Vector3 v2, Vector3 v3, Vector3 v4) {
            int vertexIndex = vertices.Count;
            vertices.Add(HexMetrics.Perturb(v1));
            vertices.Add(HexMetrics.Perturb(v2));
            vertices.Add(HexMetrics.Perturb(v3));
            vertices.Add(HexMetrics.Perturb(v4));
            triangles.Add(vertexIndex);
            triangles.Add(vertexIndex + 2);
            triangles.Add(vertexIndex + 1);
            triangles.Add(vertexIndex + 1);
            triangles.Add(vertexIndex + 2);
            triangles.Add(vertexIndex + 3);
        }
        
        public void AddQuadColor (Color c1) {
            colors.Add(c1);
            colors.Add(c1);
            colors.Add(c1);
            colors.Add(c1);
        }

        public void AddQuadColor (Color c1, Color c2) {
            colors.Add(c1);
            colors.Add(c1);
            colors.Add(c2);
            colors.Add(c2);
        }
        
        public void AddQuadColor (Color c1, Color c2, Color c3, Color c4) {
            colors.Add(c1);
            colors.Add(c2);
            colors.Add(c3);
            colors.Add(c4);
        }

        public void AddTriangleUnperturbed(Vector3 v1, Vector3 v2, Vector3 v3)
        {
            int vertexindex = vertices.Count;
            vertices.Add(v1);
            vertices.Add(v2);
            vertices.Add(v3);
            triangles.Add(vertexindex);
            triangles.Add(vertexindex + 1);
            triangles.Add(vertexindex + 2);
        }

        public void AddTriangleUV(Vector2 uv1, Vector2 uv2, Vector3 uv3)
        {
            uvs.Add(uv1);
            uvs.Add(uv2);
            uvs.Add(uv3);
        }

        public void AddQuadUV(Vector2 uv1, Vector2 uv2, Vector3 uv3, Vector3 uv4)
        {
            uvs.Add(uv1);
            uvs.Add(uv2);
            uvs.Add(uv3);
            uvs.Add(uv4);
        }

        public void AddQuadUV(float uMin, float uMax, float vMin, float vMax)
        {
            uvs.Add(new Vector2(uMin, vMin));
            uvs.Add(new Vector2(uMax, vMin));
            uvs.Add(new Vector2(uMin, vMax));
            uvs.Add(new Vector2(uMax, vMax));
        }
            #endregion

        /*Vector3 HexMetrics.Perturb(Vector3 position)
        {
            Vector4 sample = HexMetrics.SampleNoise(position);
            position.x += (sample.x * 2f - 1f) * HexMetrics.cellPerturbStrength;
            //position.y += (sample.y * 2f - 1f) * HexMetrics.cellPerturbStrength;
            position.z += (sample.z * 2f - 1f) * HexMetrics.cellPerturbStrength;
            return position;
        }*/
    }
}

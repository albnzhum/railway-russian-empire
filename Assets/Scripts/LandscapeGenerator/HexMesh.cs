using System;
using System.Collections.Generic;
using UnityEngine;
using Vector3 = UnityEngine.Vector3;

namespace LandscapeGenerator
{
    /// <summary>
    /// Generates a mesh for hexagonal grid
    /// </summary>
    [RequireComponent(typeof(MeshFilter), typeof(MeshRenderer))]
    public class HexMesh : MonoBehaviour
    {
        private Mesh _hexMesh;
        [NonSerialized] List<Vector3> _vertices;
        [NonSerialized] List<int> _triangles;
        [NonSerialized] List<Color> _colors;

        private MeshCollider _meshCollider;
        public bool useCollider, useColors, useUVCoordinates, useUV2Coordinates;
        public bool useTerrainTypes;

        [NonSerialized] List<Vector3> vertices, terrainTypes;

        [NonSerialized] private List<Vector2> _uvs, _uv2s;

        private void Awake()
        {
            GetComponent<MeshFilter>().mesh = _hexMesh = new Mesh();
            if (useCollider)
            {
                _meshCollider = gameObject.AddComponent<MeshCollider>();
            }

            _hexMesh.name = "Hex Mesh";
        }

        public void Clear()
        {
            _hexMesh.Clear();
            _vertices = ListPool<Vector3>.Get();
            if (useColors)
            {
                _colors = ListPool<Color>.Get();
            }

            if (useUVCoordinates)
            {
                _uvs = ListPool<Vector2>.Get();
            }

            if (useUV2Coordinates)
            {
                _uv2s = ListPool<Vector2>.Get();
            }

            if (useTerrainTypes)
            {
                terrainTypes = ListPool<Vector3>.Get();
            }

            _triangles = ListPool<int>.Get();
        }

        public void Apply()
        {
            _hexMesh.SetVertices(_vertices);
            ListPool<Vector3>.Add(_vertices);
            if (useColors)
            {
                _hexMesh.SetColors(_colors);
                ListPool<Color>.Add(_colors);
            }

            if (useUVCoordinates)
            {
                _hexMesh.SetUVs(0, _uvs);
                ListPool<Vector2>.Add(_uvs);
            }

            if (useUV2Coordinates)
            {
                _hexMesh.SetUVs(1, _uv2s);
                ListPool<Vector2>.Add(_uv2s);
            }

            if (useTerrainTypes)
            {
                _hexMesh.SetUVs(2, terrainTypes);
                ListPool<Vector3>.Add(terrainTypes);
            }

            _hexMesh.SetTriangles(_triangles, 0);
            ListPool<int>.Add(_triangles);
            _hexMesh.RecalculateNormals();
            if (useCollider)
            {
                _meshCollider.sharedMesh = _hexMesh;
            }
        }

        #region Adds methods

        public void AddTriangle(Vector3 v1, Vector3 v2, Vector3 v3)
        {
            int vertexIndex = _vertices.Count;
            _vertices.Add(HexMetrics.Perturb(v1));
            _vertices.Add(HexMetrics.Perturb(v2));
            _vertices.Add(HexMetrics.Perturb(v3));
            _triangles.Add(vertexIndex);
            _triangles.Add(vertexIndex + 1);
            _triangles.Add(vertexIndex + 2);
        }

        public void AddTriangleColor(Color color)
        {
            _colors.Add(color);
            _colors.Add(color);
            _colors.Add(color);
        }

        public void AddTriangleColor(Color c1, Color c2, Color c3)
        {
            _colors.Add(c1);
            _colors.Add(c2);
            _colors.Add(c3);
        }

        public void AddQuad(Vector3 v1, Vector3 v2, Vector3 v3, Vector3 v4)
        {
            int vertexIndex = _vertices.Count;
            _vertices.Add(HexMetrics.Perturb(v1));
            _vertices.Add(HexMetrics.Perturb(v2));
            _vertices.Add(HexMetrics.Perturb(v3));
            _vertices.Add(HexMetrics.Perturb(v4));
            _triangles.Add(vertexIndex);
            _triangles.Add(vertexIndex + 2);
            _triangles.Add(vertexIndex + 1);
            _triangles.Add(vertexIndex + 1);
            _triangles.Add(vertexIndex + 2);
            _triangles.Add(vertexIndex + 3);
        }

        public void AddQuadColor(Color c1)
        {
            _colors.Add(c1);
            _colors.Add(c1);
            _colors.Add(c1);
            _colors.Add(c1);
        }

        public void AddQuadColor(Color c1, Color c2)
        {
            _colors.Add(c1);
            _colors.Add(c1);
            _colors.Add(c2);
            _colors.Add(c2);
        }

        public void AddQuadColor(Color c1, Color c2, Color c3, Color c4)
        {
            _colors.Add(c1);
            _colors.Add(c2);
            _colors.Add(c3);
            _colors.Add(c4);
        }

        public void AddTriangleUnperturbed(Vector3 v1, Vector3 v2, Vector3 v3)
        {
            var vertexIndex = _vertices.Count;
            _vertices.Add(v1);
            _vertices.Add(v2);
            _vertices.Add(v3);
            _triangles.Add(vertexIndex);
            _triangles.Add(vertexIndex + 1);
            _triangles.Add(vertexIndex + 2);
        }

        public void AddTriangleUV(Vector2 uv1, Vector2 uv2, Vector3 uv3)
        {
            _uvs.Add(uv1);
            _uvs.Add(uv2);
            _uvs.Add(uv3);
        }

        public void AddQuadUV(Vector2 uv1, Vector2 uv2, Vector3 uv3, Vector3 uv4)
        {
            _uvs.Add(uv1);
            _uvs.Add(uv2);
            _uvs.Add(uv3);
            _uvs.Add(uv4);
        }

        public void AddQuadUV(float uMin, float uMax, float vMin, float vMax)
        {
            _uvs.Add(new Vector2(uMin, vMin));
            _uvs.Add(new Vector2(uMax, vMin));
            _uvs.Add(new Vector2(uMin, vMax));
            _uvs.Add(new Vector2(uMax, vMax));
        }

        public void AddQuadUnperturbed(
            Vector3 v1, Vector3 v2, Vector3 v3, Vector3 v4
        )
        {
            int vertexIndex = _vertices.Count;
            _vertices.Add(v1);
            _vertices.Add(v2);
            _vertices.Add(v3);
            _vertices.Add(v4);
            _triangles.Add(vertexIndex);
            _triangles.Add(vertexIndex + 2);
            _triangles.Add(vertexIndex + 1);
            _triangles.Add(vertexIndex + 1);
            _triangles.Add(vertexIndex + 2);
            _triangles.Add(vertexIndex + 3);
        }

        public void AddTriangleUV2(Vector2 uv1, Vector2 uv2, Vector3 uv3)
        {
            _uv2s.Add(uv1);
            _uv2s.Add(uv2);
            _uv2s.Add(uv3);
        }

        public void AddQuadUV2(Vector2 uv1, Vector2 uv2, Vector3 uv3, Vector3 uv4)
        {
            _uv2s.Add(uv1);
            _uv2s.Add(uv2);
            _uv2s.Add(uv3);
            _uv2s.Add(uv4);
        }

        public void AddQuadUV2(float uMin, float uMax, float vMin, float vMax)
        {
            _uv2s.Add(new Vector2(uMin, vMin));
            _uv2s.Add(new Vector2(uMax, vMin));
            _uv2s.Add(new Vector2(uMin, vMax));
            _uv2s.Add(new Vector2(uMax, vMax));
        }

        public void AddTriangleTerrainTypes(Vector3 types)
        {
            terrainTypes.Add(types);
            terrainTypes.Add(types);
            terrainTypes.Add(types);
        }

        public void AddQuadTerrainTypes(Vector3 types)
        {
            terrainTypes.Add(types);
            terrainTypes.Add(types);
            terrainTypes.Add(types);
            terrainTypes.Add(types);
        }

        #endregion
    }
}

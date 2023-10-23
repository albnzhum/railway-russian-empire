using UnityEngine;

namespace LandscapeGenerator
{
    /// <summary>
    /// Represents a set of vertices that define an edge
    /// </summary>
    public struct EdgeVertices
    {
        public Vector3 v1, v2, v3, v4, v5, v6, v7, v8;

        public EdgeVertices(Vector3 corner1, Vector3 corner2)
        {
            v1 = corner1;
            v2 = Vector3.Lerp(corner1, corner2, 0.125f);
            v3 = Vector3.Lerp(corner1, corner2, 0.25f);
            v4 = Vector3.Lerp(corner1, corner2, 0.5f);
            v5 = Vector3.Lerp(corner1, corner2, 0.625f);
            v6 = Vector3.Lerp(corner1, corner2, 0.75f);
            v7 = Vector3.Lerp(corner1, corner2, 0.875f);
            v8 = corner2;
        }

        public EdgeVertices(Vector3 corner1, Vector3 corner2, float outerStep)
        {
            v1 = corner1;
            v2 = Vector3.Lerp(corner1, corner2, outerStep);
            v3 = Vector3.Lerp(corner1, corner2, 0.5f);
            v4 = Vector3.Lerp(corner1, corner2, 1f - outerStep);
            v5 = Vector3.Lerp(corner1, corner2, outerStep);
            v6 = Vector3.Lerp(corner1, corner2, 0.5f);
            v7 = Vector3.Lerp(corner1, corner2, 1f - outerStep);
            v8 = corner2;
        }

        public static EdgeVertices TerraceLerp(EdgeVertices a, EdgeVertices b, int step)
        {
            EdgeVertices result;
            result.v1 = HexMetrics.TerraceLerp(a.v1, b.v1, step);
            result.v2 = HexMetrics.TerraceLerp(a.v2, b.v2, step);
            result.v3 = HexMetrics.TerraceLerp(a.v3, b.v3, step);
            result.v4 = HexMetrics.TerraceLerp(a.v4, b.v4, step);
            result.v5 = HexMetrics.TerraceLerp(a.v5, b.v5, step);
            result.v6 = HexMetrics.TerraceLerp(a.v6, b.v6, step);
            result.v7 = HexMetrics.TerraceLerp(a.v7, b.v7, step);
            result.v8 = HexMetrics.TerraceLerp(a.v8, b.v8, step);
            return result;
        }
    }
}

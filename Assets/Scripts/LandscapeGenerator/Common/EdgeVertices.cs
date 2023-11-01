using UnityEngine;

namespace LandscapeGenerator
{
    /// <summary>
    /// Represents a set of vertices that define an edge
    /// </summary>
    public struct EdgeVertices
    {
        public Vector3 v1, v2;

        public EdgeVertices(Vector3 corner1, Vector3 corner2)
        {
            v1 = corner1;
            v2 = corner2;
        }

        public EdgeVertices(Vector3 corner1, Vector3 corner2, float outerStep)
        {
            v1 = corner1;
            v2 = corner2;
        }

        public static EdgeVertices TerraceLerp(EdgeVertices a, EdgeVertices b, int step)
        {
            EdgeVertices result;
            result.v1 = HexMetrics.TerraceLerp(a.v1, b.v1, step);
            result.v2 = HexMetrics.TerraceLerp(a.v2, b.v2, step);
            return result;
        }
    }
}

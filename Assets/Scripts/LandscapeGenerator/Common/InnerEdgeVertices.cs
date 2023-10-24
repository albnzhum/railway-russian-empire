using System.Collections.Generic;
using UnityEngine;

namespace LandscapeGenerator
{
    public struct InnerEdgeVertices
    {
        public Vector3[] vL;
        public Vector3[] vR;

        public InnerEdgeVertices(Vector3 corner, Vector3 left, Vector3 right)
        {
            vL = new Vector3[10];
            for (int i = 0; i < 9; i++)
            {
                float t = 0.1f * (i + 1);
                vL[i] = Vector3.Lerp(corner, left, t);
            }

            vL[9] = left;

            vR = new Vector3[10];
            for (int i = 0; i < 9; i++)
            {
                float t = 0.1f * (i + 1);
                vR[i] = Vector3.Lerp(corner, right, t);
            }

            vR[9] = right;
        }

        public InnerEdgeVertices(Vector3 corner, Vector3 left, Vector3 right, float angle)
        {
            vL = new Vector3[10];
            for (int i = 0; i < 9; i++)
            {
                float t = 0.1f * (i + 1);
                vL[i] = Vector3.Lerp(corner, left, t);
                vL[i].y += angle;
            }

            vL[9] = left;

            vR = new Vector3[10];
            for (int i = 0; i < 9; i++)
            {
                float t = 0.1f * (i + 1);
                vR[i] = Vector3.Lerp(corner, right, t);
                vR[i].y += angle;
            }

            vR[9] = right;
        }

        static Vector3 RotateVectorAroundY(Vector3 originalVector, float angleInDegrees)
        {
            return Quaternion.Euler(0, angleInDegrees, 0) * originalVector;
        }


    }
}

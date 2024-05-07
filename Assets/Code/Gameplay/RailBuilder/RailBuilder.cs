using System;
using System.Collections;
using System.Collections.Generic;
using Dreamteck.Splines;
using UnityEngine;
using UnityEngine.Serialization;

namespace Railway.Gameplay
{
    public class RailBuilder : MonoBehaviour
    {
        public SplineComputer spline;

        private List<SplinePoint> spritePoints = new List<SplinePoint>();
        public static RailBuilder Instance { get; private set; }

        private void OnEnable()
        {
            Instance = this;
        }

        public void Build(Vector3 pointPosition)
        {
            if (spline == null) return;

            GameObject go = new GameObject();
            go.transform.position = pointPosition;

            SplinePoint newPoint = new SplinePoint(go.transform.position);
            spritePoints.Add(newPoint);

            spline.SetPoints(spritePoints.ToArray());

            spline.Rebuild();
        }
    }
}
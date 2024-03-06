using System;
using System.Collections;
using System.Collections.Generic;
using Dreamteck.Splines;
using UnityEngine;

namespace Railway.Gameplay
{
    public class RailBuilder : MonoBehaviour
    {
        public SplineComputer _spline;
        private SplineRenderer splineRenderer;
        
        private List<SplinePoint> spritePoints = new List<SplinePoint>();
        private List<GameObject> goList = new List<GameObject>();
        
        public Material mat;
        public static RailBuilder Instance { get; set; }

        private void OnEnable()
        {
            Instance = this;
        }
        
        public void Build(Vector3 pointPosition)
        {
            if (_spline == null) return;
            
            GameObject go = new GameObject();
            go.transform.position = pointPosition;
            
            goList.Add(go);
            
            SplinePoint newPoint = new SplinePoint(go.transform.position);
            spritePoints.Add(newPoint);
            
            _spline.SetPoints(spritePoints.ToArray());

            _spline.Rebuild();
        }
    }
}

using System;
using Dreamteck.Splines;
using UnityEngine;

namespace Railway.Gameplay
{
    public class TrainEngine : MonoBehaviour
    {
        private SplineTracer _tracer = null;
        private double _lastPercent = 0.0;
        private Wagon _wagon;

        private void Awake()
        {
            _wagon = GetComponent<Wagon>();
        }

        void Start()
        {
            _tracer = GetComponent<SplineTracer>();
            _tracer.onMotionApplied += OnMotionApplied;

            if (_tracer is SplineFollower)
            {
                SplineFollower follower = (SplineFollower)_tracer;
                follower.onBeginningReached += FollowerOnBeginningReached;
                follower.onEndReached += FollowerOnEndReached;
            }
        }

        private void OnMotionApplied()
        {
            _lastPercent = _tracer.result.percent;
            _wagon.UpdateOffset();
        }

        private void FollowerOnBeginningReached(double lastPercent)
        {
            _lastPercent = lastPercent;
        }

        private void FollowerOnEndReached(double lastPercent)
        {
            _lastPercent = lastPercent;
        }
    }
}
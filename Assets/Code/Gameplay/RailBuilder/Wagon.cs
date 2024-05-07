using System;
using Dreamteck.Splines;
using UnityEngine;

namespace Railway.Gameplay
{
    public class Wagon : MonoBehaviour
    {
        public class SplineSegment
        {
            public SplineComputer spline;
            public int start = -1, end = -1;
            public Spline.Direction direction;

            public SplineSegment(SplineComputer spline, int entryPoint, Spline.Direction direction)
            {
                this.spline = spline;
                start = entryPoint;
                this.direction = direction;
            }

            public double Travel(double percent, float distance, Spline.Direction direction, out float moved, bool loop)
            {
                double max = direction == Spline.Direction.Forward ? 1.0 : 0.0;
                if (start >= 0)
                {
                    max = spline.GetPointPercent(start);
                }

                return TravelClamped(percent, distance, direction, max, out moved, loop);
            }

            public double Travel(float distance, Spline.Direction direction, out float moved, bool loop)
            {
                double startPercent = spline.GetPointPercent(end);
                Debug.Log("Start percent " + startPercent);
                double max = direction == Spline.Direction.Forward ? 1.0 : 0.0;
                if (start >= 0) max = spline.GetPointPercent(start);
                return TravelClamped(startPercent, distance, direction, max, out moved, loop);
            }

            double TravelClamped(double percent, float distance, Spline.Direction direction, double max,
                out float moved, bool loop)
            {
                moved = 0f;
                float traveled = 0f;
                double result = spline.Travel(percent, distance, out traveled, direction);
                moved += traveled;
                if (loop && moved < distance)
                {
                    if (direction == Spline.Direction.Forward && Mathf.Approximately((float)result, 1f))
                    {
                        result = spline.Travel(0.0, distance - moved, out traveled, direction);
                    }
                    else if (direction == Spline.Direction.Backward && Mathf.Approximately((float)result, 0f))
                    {
                        result = spline.Travel(1.0, distance - moved, out traveled, direction);
                    }

                    moved += traveled;
                }

                if (direction == Spline.Direction.Forward && percent <= max)
                {
                    if (result > max)
                    {
                        moved -= spline.CalculateLength(result, max);
                        result = max;
                    }
                }
                else if (direction == Spline.Direction.Backward && percent >= max)
                {
                    if (result < max)
                    {
                        moved -= spline.CalculateLength(max, result);
                        result = max;
                    }
                }

                return result;
            }
        }

        public SplineTracer tracer;
        public bool isEngine;
        public Wagon back;
        public float offset;
        public Wagon front;
        public SplineSegment segment;

        private void Awake()
        {
            tracer = GetComponentInChildren<SplineTracer>();
            tracer.spline = RailBuilder.Instance.spline;

            if (isEngine)
            {
                SetupRecursively(null, new SplineSegment(tracer.spline, -1, tracer.direction));
            }
        }

        private void SetupRecursively(Wagon frontWagon, SplineSegment inputSegment)
        {
            front = frontWagon;
            segment = inputSegment;
            if (back != null) back.SetupRecursively(this, segment);
        }

        public void SetupRecursively(Wagon frontWagon)
        {
            front = frontWagon;
            if (back != null) back.SetupRecursively(this, segment);
        }

        public void UpdateOffset()
        {
            ApplyOffset();
            if (back != null) back.UpdateOffset();
        }

        void ApplyOffset()
        {
            if (isEngine)
            {
                ResetSegments();
                return;
            }

            float totalMoved = 0f, moved = 0f;
            double start = front.tracer.UnclipPercent(front.tracer.result.percent);

            Spline.Direction inverseDirection = front.segment.direction;
            InvertDirection(ref inverseDirection);
            SplineComputer spline = front.segment.spline;

            try
            {
                double percent = front.segment.Travel(start, offset, inverseDirection, out moved,
                    front.segment.spline.isClosed);

                totalMoved += moved;

                if (Mathf.Approximately(totalMoved, offset))
                {
                    if (segment != front.segment)
                    {
                        if (back != null) back.segment = segment;
                    }

                    if (segment != front.segment) segment = front.segment;
                    ApplyTracer(spline, percent, front.tracer.direction);
                    return;
                }

                if (segment != front.segment)
                {
                    inverseDirection = segment.direction;
                    InvertDirection(ref inverseDirection);
                    spline = segment.spline;
                    percent = segment.Travel(offset - totalMoved, inverseDirection, out moved, segment.spline.isClosed);
                    totalMoved += moved;
                }

                ApplyTracer(spline, percent, segment.direction);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        void ResetSegments()
        {
            Wagon current = back;
            bool same = true;
            while (current != null)
            {
                if (current.segment != segment)
                {
                    same = false;
                    break;
                }

                current = current.back;
            }

            if (same) segment.start = -1;
        }

        void ApplyTracer(SplineComputer spline, double percent, Spline.Direction direction)
        {
            bool rebuild = tracer.spline != spline;
            tracer.spline = spline;
            if (rebuild) tracer.RebuildImmediate();
            tracer.direction = direction;
            tracer.SetPercent(tracer.ClipPercent(percent));
        }

        static void InvertDirection(ref Spline.Direction direction)
        {
            if (direction == Spline.Direction.Forward) direction = Spline.Direction.Backward;
            else direction = Spline.Direction.Forward;
        }
    }
}
using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace TGS.Geom
{
    public struct Point : IEqualityComparer<Point>
    {
        public static double Precision = 1e-8;
        public static Point Zero = new Point(0, 0);

        double _x;

        public double X
        {
            get => _x;
            set
            {
                _x = value;
                HashCode = 0;
            }
        }

        double _y;

        public double Y
        {
            get => _y;
            set
            {
                _y = value;
                HashCode = 0;
            }
        }

        private int HashCode;

        public Point(double x, double y)
        {
            this._x = x;
            this._y = y;
            HashCode = 0;
        }

        public Vector3 Vector3
        {
            get
            {
                float xf = (float)Math.Round(X, 7);
                float yf = (float)Math.Round(Y, 7);
                return new Vector3(xf, yf);
            }
        }

        public double Magnitude => Math.Sqrt(X * X + Y * Y);

        public static double Distance(Point p1, Point p2)
        {
            return Math.Sqrt((p2.X - p1.X) * (p2.X - p1.X) + (p2.Y - p1.Y) * (p2.Y - p1.Y));
        }

        public override string ToString()
        {
            return "x:" + X.ToString("F5") + " y:" + Y.ToString("F5");
        }

        public bool Equals(Point p0, Point p1)
        {
            return (p0.X - p1.X) < Precision && (p0.X - p1.X) > -Precision &&
                   (p0.Y - p1.Y) < Precision && (p0.Y - p1.Y) > -Precision;
        }

        public static bool EqualsBoth(Point p0, Point p1)
        {
            return (p0.X - p1.X) < Precision && (p0.X - p1.X) > -Precision &&
                   (p0.Y - p1.Y) < Precision && (p0.Y - p1.Y) > -Precision;
        }


        public override bool Equals(object o)
        {
            if (o is Point)
            {
                Point p = (Point)o;
                return p.X == X && p.Y == Y;
            }

            return false;
        }


        void CalculateHashCode()
        {
            HashCode = (int)(10e7 * Math.Round(X, 7) + 10e9 * Math.Round(Y, 7));
        }

        public override int GetHashCode()
        {
            if (HashCode == 0)
                CalculateHashCode();
            return HashCode;
        }

        public int GetHashCode(Point p)
        {
            return (int)(10e7 * Math.Round(p.X, 7) + 10e9 * Math.Round(p.Y, 7));
        }

        public static bool operator ==(Point p1, Point p2)
        {
            return p1.X == p2.X && p1.Y == p2.Y;
        }

        public static bool operator !=(Point p1, Point p2)
        {
            return p1.X != p2.X || p1.Y != p2.Y;
        }

        public static Point operator -(Point p1, Point p2)
        {
            return new Point(p1.X - p2.X, p1.Y - p2.Y);
        }

        public static Point operator -(Point p)
        {
            return new Point(-p.X, -p.Y);
        }

        public static Point operator +(Point p1, Point p2)
        {
            return new Point(p1.X + p2.X, p1.Y + p2.Y);
        }

        public static Point operator *(Point p, double scalar)
        {
            return new Point(p.X * scalar, p.Y * scalar);
        }

        public static Point operator /(Point p, double scalar)
        {
            return new Point(p.X / scalar, p.Y / scalar);
        }

        public double SqrMagnitude => X * X + Y * Y;

        public static Point operator -(Vector2 p1, Point p2)
        {
            return new Point(p1.x - p2.X, p1.y - p2.Y);
        }


        public static Point Lerp(Point start, Point end, double t)
        {
            return start + (end - start) * t;
        }

        public void Normalize()
        {
            double d = Math.Sqrt(X * X + Y * Y);
            X /= d;
            Y /= d;
        }

        public Point Normalized
        {
            get
            {
                double d = Math.Sqrt(X * X + Y * Y);
                return new Point(X / d, Y / d);
            }
        }

        public Point Offset(double deltax, double deltay)
        {
            return new Point(X + deltax, Y + deltay);
        }

        public void CropBottom()
        {
            if (Y < -0.5)
                Y = -0.5;
        }

        public void CropRight()
        {
            if (X > 0.5)
                X = 0.5;
        }
    }
}
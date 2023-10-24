using System.IO;
using UnityEngine;

namespace LandscapeGenerator
{
    /// <summary>
    /// Handle conversions between different coordinate systems
    /// </summary>
    [System.Serializable]
    public struct HexCoordinates
    {
        [SerializeField] private int x, z;

        public int X => x;

        public int Z => z;

        public int Y => -X - Z;

        public HexCoordinates(int x, int z)
        {
            this.x = x;
            this.z = z;
        }

        public static HexCoordinates FromOffsetCoordinates(int x, int z)
        {
            return new HexCoordinates(x - z / 2, z);
        }

        public static HexCoordinates FromPosition(Vector3 position)
        {
            var x = position.x / (HexMetrics.InnerRadius * 2f);
            var y = -x;
            var offset = position.z / (HexMetrics.OuterRadius * 3f);
            x -= offset;
            y -= offset;
            var iX = Mathf.RoundToInt(x);
            var iY = Mathf.RoundToInt(y);
            var iZ = Mathf.RoundToInt(-x - y);

            if (iX + iY + iZ != 0)
            {
                var dX = Mathf.Abs(x - iX);
                var dY = Mathf.Abs(y - iY);
                var dZ = Mathf.Abs(-x - y - iZ);

                if (dX > dY && dX > dZ)
                {
                    iX = -iY - iZ;
                }
                else if (dZ > dY)
                {
                    iZ = -iX - iY;
                }
            }

            return new HexCoordinates(iX, iZ);
        }

        public override string ToString()
        {
            return "(" + X.ToString() + ", " + Z.ToString() + ")";
        }

        public string ToStringOnSeparateLines()
        {
            return X.ToString() + "\n" + Z.ToString();
        }

        public int DistanceTo (HexCoordinates other) {
            return
                ((x < other.x ? other.x - x : x - other.x) +
                 (Y < other.Y ? other.Y - Y : Y - other.Y) +
                 (z < other.z ? other.z - z : z - other.z)) / 2;
        }

        public void Save(BinaryWriter writer)
        {
            writer.Write(x);
            writer.Write(z);
        }

        public static HexCoordinates Load(BinaryReader reader)
        {
            HexCoordinates c;
            c.x = reader.ReadInt32();
            c.z = reader.ReadInt32();
            return c;
        }
    }
}

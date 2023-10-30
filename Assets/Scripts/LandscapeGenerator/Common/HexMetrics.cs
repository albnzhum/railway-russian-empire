using UnityEngine;

namespace LandscapeGenerator
{
    public static class HexMetrics
    {
        const float OuterToInner = 0.866025404f;
        public const float InnerToOuter = 1f / OuterToInner;
        public const float OuterRadius = 10f;
        public const float InnerRadius = OuterRadius * OuterToInner;

        const float SolidFactor = 0.6f;
        const float BlendFactor = 1f - SolidFactor;

        public const float ElevationStep = 5f;

        const int TerracesPerSlope = 2;
        public const int TerraceSteps = TerracesPerSlope * 2 + 1;
        const float HorizontalTerraceStepSize = 1f / TerraceSteps;
        const float VerticalTerraceStepSize = 1f / (TerracesPerSlope + 1);

        public static Texture2D NoiseSource;
        const float CellPerturbStrength = 1f;
        const float NoiseScale = 0.003f;
       // const float NoiseScale = 125f;
        public const float ElevationPerturbStrength = 1.5f;

        public const int ChunkSizeX = 5, ChunkSizeZ = 5;

        public const float StreamBedElevationOffset = -1.75f;
        public const float WaterElevationOffset = -0.5f;
        const float WaterFactor = 0.6f;
        const float WaterBlendFactor = 1f - WaterFactor;

        const int HashGridSize = 256;

        public const float WallHeight = 4f;
        const float WallThickness = 0.75f;
        const float WallElevationOffset = VerticalTerraceStepSize;
        public const float WallTowerThreshold = 0.5f;
        const float WallYOffset = -1f;

        public const float BridgeDesignLength = 7f;

        static HexHash[] HashGrid;
        const float HashGridScale = 0.25f;

        static readonly Vector3[] Corners =
        {
            new(0f, 0f, OuterRadius),
            new(InnerRadius, 0f, 0.5f * OuterRadius),
            new(InnerRadius, 0f, -0.5f * OuterRadius),
            new(0f, 0f, -OuterRadius),
            new(-InnerRadius, 0f, -0.5f * OuterRadius),
            new(-InnerRadius, 0f, 0.5f * OuterRadius),
            new(0f, 0f, OuterRadius)
        };

        static readonly float[][] FeatureThresholds =
        {
            new[] { 0.0f, 0.0f, 0.4f },
            new[] { 0.0f, 0.4f, 0.6f },
            new[] { 0.4f, 0.6f, 0.8f }
        };

        public static float[] GetFeatureThresholds(int level)
        {
            return FeatureThresholds[level];
        }

        public static Vector3 WallThicknessOffset(Vector3 near, Vector3 far)
        {
            Vector3 offset;
            offset.x = far.x - near.x;
            offset.y = 0f;
            offset.z = far.z - near.z;
            return offset.normalized * (WallThickness * 0.5f);
        }

        public static Vector3 WallLerp(Vector3 near, Vector3 far)
        {
            near.x += (far.x - near.x) * 0.5f;
            near.z += (far.z - near.z) * 0.5f;
            var v =
                near.y < far.y ? WallElevationOffset : (1f - WallElevationOffset);
            near.y += (far.y - near.y) * v + WallYOffset;
            return near;
        }

        #region Corners

        public static Vector3 GetFirstCorner(HexDirection direction)
        {
            return Corners[(int)direction];
        }

        public static Vector3 GetSecondCorner(HexDirection direction)
        {
            return Corners[(int)direction + 1];
        }

        public static Vector3 GetFirstSolidCorner(HexDirection direction)
        {
            return Corners[(int)direction] * SolidFactor;
        }

        public static Vector3 GetSecondSolidCorner(HexDirection direction)
        {
            return Corners[(int)direction + 1] * SolidFactor;
        }

        #endregion

        public static void InitializeHashGrid(int seed)
        {
            HashGrid = new HexHash[HashGridSize * HashGridSize];
            var currentState = Random.state;
            Random.InitState(seed);
            for (var i = 0; i < HashGrid.Length; i++)
            {
                HashGrid[i] = HexHash.Create();
            }

            Random.state = currentState;
        }

        public static HexHash SampleHashGrid(Vector3 position)
        {
            var x = (int)(position.x * HashGridScale) % HashGridSize;
            if (x < 0)
            {
                x += HashGridSize;
            }

            var z = (int)(position.z * HashGridScale) % HashGridSize;
            if (z < 0)
            {
                z += HashGridSize;
            }

            return HashGrid[x + z * HashGridSize];
        }

        public static Vector3 GetBridge(HexDirection direction)
        {
            return (Corners[(int)direction] + Corners[(int)direction + 1]) *
                   BlendFactor;
        }

        public static Vector3 TerraceLerp(Vector3 a, Vector3 b, int step)
        {
            var h = step * HorizontalTerraceStepSize;
            a.x += (b.x - a.x) * h;
            a.z += (b.z - a.z) * h;
            var v = (step ) * VerticalTerraceStepSize;
            a.y += (b.y - a.y) * h;
            return a;
        }

        public static Color TerraceLerp(Color a, Color b, int step)
        {
            var h = step * HorizontalTerraceStepSize;
            return Color.Lerp(a, b, h);
        }

        public static HexEdgeType GetEdgeType(int elevation1, int elevation2)
        {
            if (elevation1 == elevation2)
            {
                return HexEdgeType.Flat;
            }

            var delta = elevation2 - elevation1;
            if (delta == 1 || delta == -1)
            {
                return HexEdgeType.Slope;
            }

            return HexEdgeType.Cliff;
        }

        public static Vector4 SampleNoise(Vector3 position)
        {
            return NoiseSource.GetPixelBilinear(
                position.x * NoiseScale, position.z * NoiseScale);
        }

        public static Vector3 GetSolidEdgeMiddle(HexDirection direction)
        {
            return
                (Corners[(int)direction] + Corners[(int)direction + 1]) *
                (0.5f * SolidFactor);
        }

        public static Vector3 Perturb(Vector3 position)
        {
            var sample = SampleNoise(position);
            position.x += (sample.x * 2f - 1f) * CellPerturbStrength;
            position.y += (sample.y * 2f - 1f) * CellPerturbStrength;
            position.z += (sample.z * 2f - 1f) * CellPerturbStrength;
            return position;
        }

        #region Water

        public static Vector3 GetFirstWaterCorner(HexDirection direction)
        {
            return Corners[(int)direction] * WaterFactor;
        }

        public static Vector3 GetSecondWaterCorner(HexDirection direction)
        {
            return Corners[(int)direction + 1] * WaterFactor;
        }

        public static Vector3 GetWaterBridge(HexDirection direction)
        {
            return (Corners[(int)direction] + Corners[(int)direction + 1]) *
                   WaterBlendFactor;
        }

        #endregion
    }
}

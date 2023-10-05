

namespace LandscapeGenerator
{
    public enum HexDirection 
    {
        NE, E, SE, SW, W, NW
    }

    /// <summary>
    /// Provides extensions methods for HexDirection enum
    /// </summary>
    public static class HexDirectionExtensions
    {
        /// <summary>
        /// Returns opposite direction
        /// </summary>
        /// <param name="direction"></param>
        /// <returns></returns>
        public static HexDirection Opposite(this HexDirection direction)
        {
            return (int)direction < 3 ? (direction + 3) : (direction - 3);
        }

        /// <summary>
        /// Returns the previous direction in a counter-clockwise order
        /// </summary>
        /// <param name="direction"></param>
        /// <returns></returns>
        public static HexDirection Previous(this HexDirection direction)
        {
            return direction == HexDirection.NE ? HexDirection.NW : (direction - 1);
        }

        /// <summary>
        /// Returns the next direction in a counter-clockwise order
        /// </summary>
        /// <param name="direction"></param>
        /// <returns></returns>
        public static HexDirection Next(this HexDirection direction)
        {
            return direction == HexDirection.NW ? HexDirection.NE : (direction + 1);
        }

        public static HexDirection Previous2(this HexDirection direction)
        {
            direction -= 2;
            return direction >= HexDirection.NE ? direction : (direction + 6);
        }

        public static HexDirection Next2(this HexDirection direction)
        {
            direction += 2;
            return direction <= HexDirection.NW ? direction : (direction - 6);
        }
    }
}

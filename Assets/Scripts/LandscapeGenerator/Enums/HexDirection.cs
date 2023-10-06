

namespace LandscapeGenerator
{
    public enum HexDirection 
    {
        Ne, E, Se, SW, W, Nw
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
            return direction == HexDirection.Ne ? HexDirection.Nw : (direction - 1);
        }

        /// <summary>
        /// Returns the next direction in a counter-clockwise order
        /// </summary>
        /// <param name="direction"></param>
        /// <returns></returns>
        public static HexDirection Next(this HexDirection direction)
        {
            return direction == HexDirection.Nw ? HexDirection.Ne : (direction + 1);
        }

        public static HexDirection Previous2(this HexDirection direction)
        {
            direction -= 2;
            return direction >= HexDirection.Ne ? direction : (direction + 6);
        }

        public static HexDirection Next2(this HexDirection direction)
        {
            direction += 2;
            return direction <= HexDirection.Nw ? direction : (direction - 6);
        }
    }
}

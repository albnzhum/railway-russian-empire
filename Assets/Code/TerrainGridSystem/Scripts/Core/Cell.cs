using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using TGS.Geom;

namespace TGS
{
    public partial class Cell : IAdmin
    {
        /// <summary>
        /// Optional cell name.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// The territory to which this cell belongs to. You can change it using CellSetTerritory method.
        /// WARNING: do not change this value directly, use CellSetTerritory instead.
        /// </summary>
        public int TerritoryIndex = -1;

        public Region Region { get; set; }

        public Polygon Polygon { get; set; }

        /// <summary>
        /// Unscaled center. Ranges from -0.5, -0.5 to 0.5, 0.5.
        /// </summary>
        public Vector2 Center;

        /// <summary>
        /// Original cell center with applied scale
        /// </summary>
        public Vector2 ScaledCenter;

        public bool Visible { get; set; }

        /// <summary>
        /// Optional value that can be set with CellSetTag. You can later get the cell quickly using CellGetWithTag method.
        /// </summary>
        public int Tag;

        public int Row, Column;

        /// <summary>
        /// If this cell blocks path finding.
        /// </summary>
        public bool CanCross = true;

        /// <summary>
        /// Group for this cell. A different group can be assigned to use along with FindPath cellGroupMask argument.
        /// </summary>
        public int Group = 1;

        Cell(string name, Vector2 center)
        {
            this.Name = name;
            this.Center = center;
            Visible = true;
        }

        public Cell() : this("", Vector2.zero)
        {
        }

        public Cell(string name) : this(name, Vector2.zero)
        {
        }

        public Cell(Vector2 center) : this("", center)
        {
        }
    }
}

using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using TGS.Geom;

namespace TGS {

	public partial class Cell: IAdmin {
		/// <summary>
		/// Optional cell name.
		/// </summary>
		public string name { get; set; }

		/// <summary>
		/// The territory to which this cell belongs to. You can change it using CellSetTerritory method.
		/// WARNING: do not change this value directly, use CellSetTerritory instead.
		/// </summary>
		public int territoryIndex = -1;

		public Region region { get; set; }

		public Polygon polygon { get; set; }

		/// <summary>
		/// Unscaled center. Ranges from -0.5, -0.5 to 0.5, 0.5.
		/// </summary>
		public Vector2 center;

		/// <summary>
		/// Original cell center with applied scale
		/// </summary>
		public Vector2 scaledCenter;

		public bool visible { get; set; }

		/// <summary>
		/// Optional value that can be set with CellSetTag. You can later get the cell quickly using CellGetWithTag method.
		/// </summary>
		public int tag;


		public int row, column;

		/// <summary>
		/// If this cell blocks path finding.
		/// </summary>
		public bool canCross = true;

		/// <summary>
		/// Group for this cell. A different group can be assigned to use along with FindPath cellGroupMask argument.
		/// </summary>
		public int group = 1;

		public Cell(string name, Vector2 center) {
			this.name = name;
			this.center = center;
			visible = true;
		}

		public Cell() : this("", Vector2.zero) {
		}

		public Cell(string name) : this(name, Vector2.zero) {
		}

		public Cell(Vector2 center) : this("", center) {
		}

	}
}


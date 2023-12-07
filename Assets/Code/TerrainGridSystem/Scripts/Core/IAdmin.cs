using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using TGS.Geom;

namespace TGS {
	public interface IAdmin {

		string Name { get; set; }

		Region Region { get; set; }

		Polygon Polygon { get; set; }

		bool Visible { get; set; }

	}
}

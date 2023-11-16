using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace TGS.Geom {

	public class Rectangle {
		public double minX, minY, width, height;

		public Rectangle(double minX, double minY, double width, double height) {
			this.minX = minX;
			this.minY = minY;
			this.width = width;
			this.height = height;
		}

		public double right {
			get {
				return minX + width;
			}
		}

		public double top {
			get {
				return minY + height;
			}
		}

		public Rectangle Union(Rectangle o) {
			double minX = this.minX < o.minX + Point.Precision ? this.minX: o.minX;
			double maxX = this.right > o.right - Point.Precision ? this.right: o.right;
			double minY = this.minY < o.minY+ Point.Precision ? this.minY: o.minY;
			double maxY = this.top > o.top - Point.Precision ? this.top: o.top;
			return new Rectangle(minX, minY, maxX-minX, maxY-minY);
		}

		public bool Intersects(Rectangle o) {
			if (o.minX>right + Point.Precision) return false;
			if (o.right<minX - Point.Precision) return false;
			if (o.minY>top + Point.Precision) return false;
			if (o.top<minY - Point.Precision) return false;
			return true;
		}

		public override string ToString () {
			return string.Format ("minX:" + minX.ToString("F5") + " minY:" + minY.ToString("F5") + " width:" + width.ToString("F5") + " height:" + height.ToString ("F5"));
		} 
	}

}
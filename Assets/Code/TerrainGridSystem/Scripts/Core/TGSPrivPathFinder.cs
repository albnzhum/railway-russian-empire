using UnityEngine;
using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using TGS.PathFinding;

namespace TGS
{

	public partial class TerrainGridSystem : MonoBehaviour
	{

		int[] routeMatrix;

		IPathFinder finder;
		bool needRefreshRouteMatrix;


		void ComputeRouteMatrix ()
		{

			// prepare matrix
			if (routeMatrix == null) {
				needRefreshRouteMatrix = true;
				routeMatrix = new int[_cellColumnCount * _cellRowCount];
			}

			if (!needRefreshRouteMatrix)
				return;

			needRefreshRouteMatrix = false;

			// Compute route
			for (int j = 0; j < _cellRowCount; j++) {
				int jj = j * _cellColumnCount;
				for (int k = 0; k < _cellColumnCount; k++) {
					int cellIndex = jj + k;
					if (Cells [cellIndex].CanCross && Cells [cellIndex].Visible) {	// set navigation bit
						routeMatrix [cellIndex] = Cells [cellIndex].Group;
					} else {		// clear navigation bit
						routeMatrix [cellIndex] = 0;
					}
				}
			}

			if (finder == null) {
				if ((_cellColumnCount & (_cellColumnCount - 1)) == 0) {	// is power of two?
					finder = new PathFinderFast (routeMatrix, _cellColumnCount, _cellRowCount);
				} else {
					finder = new PathFinderFastNonSQR (routeMatrix, _cellColumnCount, _cellRowCount);
				}
			} else {
				finder.SetCalcMatrix (routeMatrix);
			}
		}

		/// <summary>
		/// Used by FindRoute method to satisfy custom positions check
		/// </summary>
		int FindRoutePositionValidator (int location)
		{
			int cost = 1;
			if (OnPathFindingCrossCell != null) {
				cost = OnPathFindingCrossCell (location);
			}
			return cost;
		}

	}

}
using UnityEngine;
using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using TGS.PathFinding;
using Zenject;

namespace TGS
{
    public partial class TerrainGridSystem
    {
        private int[] _routeMatrix;

        private IPathFinder _finder;
        private bool _needRefreshRouteMatrix;


        private void ComputeRouteMatrix()
        {
            // prepare matrix
            if (_routeMatrix == null)
            {
                _needRefreshRouteMatrix = true;
                _routeMatrix = new int[cellColumnCount * cellRowCount];
            }

            if (!_needRefreshRouteMatrix)
                return;

            _needRefreshRouteMatrix = false;

            // Compute route
            for (int j = 0; j < cellRowCount; j++)
            {
                int jj = j * cellColumnCount;
                for (int k = 0; k < cellColumnCount; k++)
                {
                    int cellIndex = jj + k;
                    if (Cells[cellIndex].canCross && Cells[cellIndex].visible)
                    {
                        // set navigation bit
                        _routeMatrix[cellIndex] = Cells[cellIndex].group;
                    }
                    else
                    {
                        // clear navigation bit
                        _routeMatrix[cellIndex] = 0;
                    }
                }
            }

            if (_finder == null)
            {
                if ((cellColumnCount & (cellColumnCount - 1)) == 0)
                {
                    // is power of two?
                    _finder = new PathFinderFast(_routeMatrix, cellColumnCount, cellRowCount);
                }
                else
                {
                    _finder = new PathFinderFastNonSQR(_routeMatrix, cellColumnCount, cellRowCount);
                }
            }
            else
            {
                _finder.SetCalcMatrix(_routeMatrix);
            }
        }

        /// <summary>
        /// Used by FindRoute method to satisfy custom positions check
        /// </summary>
        private int FindRoutePositionValidator(int location)
        {
            var cost = 1;
            if (OnPathFindingCrossCell != null)
            {
                cost = OnPathFindingCrossCell(location);
            }

            return cost;
        }
    }
}
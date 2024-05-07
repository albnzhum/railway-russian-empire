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


        void ComputeRouteMatrix()
        {
            // prepare matrix
            if (routeMatrix == null)
            {
                needRefreshRouteMatrix = true;
                routeMatrix = new int[cellColumnCount * cellRowCount];
            }

            if (!needRefreshRouteMatrix)
                return;

            needRefreshRouteMatrix = false;

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
                        routeMatrix[cellIndex] = Cells[cellIndex].group;
                    }
                    else
                    {
                        // clear navigation bit
                        routeMatrix[cellIndex] = 0;
                    }
                }
            }

            if (finder == null)
            {
                if ((cellColumnCount & (cellColumnCount - 1)) == 0)
                {
                    // is power of two?
                    finder = new PathFinderFast(routeMatrix, cellColumnCount, cellRowCount);
                }
                else
                {
                    finder = new PathFinderFastNonSQR(routeMatrix, cellColumnCount, cellRowCount);
                }
            }
            else
            {
                finder.SetCalcMatrix(routeMatrix);
            }
        }

        /// <summary>
        /// Used by FindRoute method to satisfy custom positions check
        /// </summary>
        int FindRoutePositionValidator(int location)
        {
            int cost = 1;
            if (OnPathFindingCrossCell != null)
            {
                cost = OnPathFindingCrossCell(location);
            }

            return cost;
        }
    }
}
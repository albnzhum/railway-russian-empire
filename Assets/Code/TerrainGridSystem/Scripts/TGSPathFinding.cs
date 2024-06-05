using UnityEngine;
using System.Collections.Generic;
using TGS.PathFinding;

namespace TGS
{
    /* Event definitions */

    public delegate int PathFindingEvent(int cellIndex);

    public partial class TerrainGridSystem
    {
        /// <summary>
        /// Fired when path finding algorithmn evaluates a cell. Return the increased cost for cell.
        /// </summary>
        public event PathFindingEvent OnPathFindingCrossCell;


        [SerializeField] HeuristicFormula pathFindingHeuristicFormula = HeuristicFormula.EuclideanNoSQR;

        /// <summary>
        /// The path finding heuristic formula to estimate distance from current position to destination
        /// </summary>
        public HeuristicFormula PathFindingHeuristicFormula
        {
            get => pathFindingHeuristicFormula;
            set
            {
                if (value != pathFindingHeuristicFormula)
                {
                    pathFindingHeuristicFormula = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] int pathFindingMaxCost = 200000;

        /// <summary>
        /// The maximum search cost of the path finding execution.
        /// </summary>
        public int PathFindingMaxCost
        {
            get => pathFindingMaxCost;
            set
            {
                if (value != pathFindingMaxCost)
                {
                    pathFindingMaxCost = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] int pathFindingMaxSteps = 2000;

        /// <summary>
        /// The maximum number of steps that a path can return.
        /// </summary>
        public int PathFindingMaxSteps
        {
            get => pathFindingMaxSteps;
            set
            {
                if (value != pathFindingMaxSteps)
                {
                    pathFindingMaxSteps = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] bool pathFindingUseDiagonals = true;

        /// <summary>
        /// If path can include diagonals between cells
        /// </summary>
        public bool PathFindingUseDiagonals
        {
            get => pathFindingUseDiagonals;
            set
            {
                if (value != pathFindingUseDiagonals)
                {
                    pathFindingUseDiagonals = value;
                    isDirty = true;
                }
            }
        }

        [SerializeField] bool pathFindingHeavyDiagonals;

        /// <summary>
        /// If diagonals have extra cost.
        /// </summary>
        public bool PathFindingHeavyDiagonals
        {
            get => pathFindingHeavyDiagonals;
            set
            {
                if (value != pathFindingHeavyDiagonals)
                {
                    pathFindingHeavyDiagonals = value;
                    isDirty = true;
                }
            }
        }


        #region Public Path Finding functions

        /// <summary>
        /// Returns an optimal path from startPosition to endPosition with options.
        /// </summary>
        /// <returns>The route consisting of a list of cell indexes.</returns>
        /// <param name="cellIndexEnd"></param>
        /// <param name="maxSearchCost">Maximum search cost for the path finding algorithm. A value of 0 will use the global default defined by pathFindingMaxCost</param>
        /// <param name="maxSteps">Maximum steps for the path. A value of 0 will use the global default defined by pathFindingMaxSteps</param>
        /// <param name="cellIndexStart"></param>
        /// <param name="cellGroupMask"></param>
        public List<int> FindPath(int cellIndexStart, int cellIndexEnd, int maxSearchCost = 0, int maxSteps = 0,
            int cellGroupMask = -1)
        {
            return FindPath(cellIndexStart, cellIndexEnd, out _, maxSearchCost, maxSteps, cellGroupMask);
        }

        /// <summary>
        /// Returns an optimal path from startPosition to endPosition with options.
        /// </summary>
        /// <returns>The route consisting of a list of cell indexes.</returns>
        /// <param name="cellIndexStart"></param>
        /// <param name="cellIndexEnd"></param>
        /// <param name="totalCost">The total accumulated cost for the path</param>
        /// <param name="maxSearchCost">Maximum search cost for the path finding algorithm. A value of 0 will use the global default defined by pathFindingMaxCost</param>
        /// <param name="maxSteps">Maximum steps for the path. A value of 0 will use the global default defined by pathFindingMaxSteps</param>
        /// <param name="cellGroupMask"></param>
        public List<int> FindPath(int cellIndexStart, int cellIndexEnd, out int totalCost, int maxSearchCost = 0,
            int maxSteps = 0, int cellGroupMask = -1)
        {
            totalCost = 0;
            Cell startCell = Cells[cellIndexStart];
            Cell endCell = Cells[cellIndexEnd];
            if (!startCell.canCross || !endCell.canCross)
                return null;
            List<int> routePoints = null;
            if (cellIndexStart != cellIndexEnd)
            {
                PathFindingPoint startingPoint = new(startCell.column, startCell.row);
                PathFindingPoint endingPoint = new(endCell.column, endCell.row);
                ComputeRouteMatrix();
                _finder.Formula = pathFindingHeuristicFormula;
                _finder.MaxSearchCost = maxSearchCost > 0 ? maxSearchCost : pathFindingMaxCost;
                _finder.MaxSteps = maxSteps > 0 ? maxSteps : pathFindingMaxSteps;
                _finder.Diagonals = pathFindingUseDiagonals;
                _finder.HeavyDiagonals = pathFindingHeavyDiagonals;
                _finder.HexagonalGrid = gridTopology == GRID_TOPOLOGY.Hexagonal;
                _finder.CellGroupMask = cellGroupMask;
                if (OnPathFindingCrossCell != null)
                {
                    _finder.OnCellCross = FindRoutePositionValidator;
                }
                else
                {
                    _finder.OnCellCross = null;
                }

                List<PathFinderNode> route = _finder.FindPath(startingPoint, endingPoint, out totalCost, evenLayout);
                if (route != null)
                {
                    routePoints = new List<int>(route.Count);
                    for (int r = route.Count - 2; r >= 0; r--)
                    {
                        int cellIndex = route[r].PY * cellColumnCount + route[r].PX;
                        routePoints.Add(cellIndex);
                    }

                    routePoints.Add(cellIndexEnd);
                }
                else
                {
                    return null; // no route available
                }
            }

            return routePoints;
        }

        #endregion
    }
}
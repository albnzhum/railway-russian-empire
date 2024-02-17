using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace TGS
{
    public class PathfinderManager : MonoBehaviour
    {
        [SerializeField] private PlacingObject _startPos;
        [SerializeField] private PlacingObject _endPos;

        private TerrainGridSystem _tgs;

        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;
        }

        public void BuildPath()
        {
            List<List<int>> allPaths = FindAllPaths();

            if (allPaths != null)
            {
                foreach (var path in allPaths)
                {
                    for (int i = 0; i < path.Count; i++)
                    {
                        _tgs.CellFadeOut(path[i], Color.green, 10f);
                    }
                }
            }
            
            /*List<int> path = _tgs.FindPath(_startPos.CellIndex, _endPos.CellIndex, 0, 0, 1);
            if (path != null)
            {
                for (int i = 0; i < path.Count; i++)
                {
                    _tgs.CellFadeOut(path[i], Color.green, 10f);
                }
            }*/
        }

        public List<List<int>> FindAllPaths()
        {
            List<List<int>> allPaths = new List<List<int>>();
            Stack<PathfindingIteration> stack = new Stack<PathfindingIteration>();
            int pathCount = 0;

            stack.Push(new PathfindingIteration(_startPos.CellIndex, new List<int>()));

            while (stack.Count > 0 && pathCount < 3)
            {
                PathfindingIteration currentIteration = stack.Pop();
                int currentCell = currentIteration.CurrentCell;
                List<int> currentPath = currentIteration.CurrentPath;

                currentPath.Add(currentCell);

                if (currentCell == _endPos.CellIndex)
                {
                    // Найден один из путей
                    allPaths.Add(new List<int>(currentPath));
                    pathCount++;
                }
                else
                {
                    // Итеративно ищем пути из текущей ячейки
                    List<Cell> neighbors = _tgs.CellGetNeighbours(currentCell);
                    foreach (Cell neighbor in neighbors)
                    {
                        int index = _tgs.CellGetIndex(neighbor);
                        if (neighbor != null && neighbor.canCross && !currentPath.Contains(index))
                        {
                            stack.Push(new PathfindingIteration(index, new List<int>(currentPath)));
                        }
                    }
                }
            }

            return allPaths;
        }
    }
    
    class PathfindingIteration
    {
        public int CurrentCell { get; private set; }
        public List<int> CurrentPath { get; private set; }

        public PathfindingIteration(int currentCell, List<int> currentPath)
        {
            CurrentCell = currentCell;
            CurrentPath = currentPath;
        }
    }
}

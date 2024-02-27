using System.Collections.Generic;
using System.Linq;
using Railway.Gameplay;
using UnityEngine;

namespace TGS
{
    public class PathfinderManager : MonoBehaviour
    {
        [SerializeField] private PlacingObject _startPos;
        [SerializeField] private PlacingObject _endPos;
        
        [SerializeField] private CellEnterEventSO _cellEnterEvent;

        private TerrainGridSystem _tgs;

        private void OnEnable()
        {
            _tgs = TerrainGridSystem.Instance;

            _cellEnterEvent.OnCellEnter += BuildPath;
        }
        
        public void BuildPath(int index)
        {
            List<int> pathToCurrentCell  = _tgs.FindPath(_startPos.CellIndex, index, 0, 0, 1);
            List<int> pathFromCurrentCellToEnd  = _tgs.FindPath(index, _endPos.CellIndex, 0, 0, 1);
            
            if (pathToCurrentCell != null && pathFromCurrentCellToEnd != null)
            {
                List<int> fullPath = pathToCurrentCell.Concat(pathFromCurrentCellToEnd).ToList();

                for (int i = 0; i < fullPath.Count; i++)
                {
                    _tgs.CellFadeOut(fullPath[i], Color.green, 1f);
                }
            }
            else
            {
                Debug.Log("Null");
            }
        }
    }
}

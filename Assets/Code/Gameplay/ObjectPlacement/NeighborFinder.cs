using System.Collections.Generic;
using System.Linq;
using ModestTree;
using Railway.Shop.Data;
using TGS;
using UnityEngine;

namespace Railway.Gameplay
{
    public class NeighborFinder
    {
        private TerrainGridSystem _tgs;

        private static NeighborFinder _instance;

        private NeighborFinder(TerrainGridSystem tgs)
        {
            _tgs = tgs;
        }

        public static NeighborFinder Instance(TerrainGridSystem tgs)
        {
            if (_instance == null)
            {
                _instance = new NeighborFinder(tgs);
            }

            return _instance;
        }

        public Cell[] GetAvailableCell(ShopItem currentItem, Cell startCell,
            Dictionary<ItemType, List<Cell>> _occupiedCells)
        {
            Cell[] availableCells = new Cell[15];

            if (!_occupiedCells.TryGetValue(currentItem.ItemType.Type, out var cells))
            {
                _occupiedCells[currentItem.ItemType.Type] = new List<Cell>();
                cells = _occupiedCells[currentItem.ItemType.Type];
            }

            switch (currentItem.ItemType.Type)
            {
                case ItemType.Locomotive:
                    availableCells = _tgs.Cells
                        .Where(x => _tgs.CellGetTag(_tgs.CellGetIndex(x)) == (int)CellBuildingType.RAILS).ToArray();
                    break;
                case ItemType.Workers:
                    availableCells = _tgs.Cells
                        .Where(x => _tgs.CellGetTag(_tgs.CellGetIndex(x)) == (int)CellBuildingType.BUILD).ToArray();
                    break;
                case ItemType.Carriage:
                    availableCells = _tgs.Cells
                        .Where(x => _tgs.CellGetTag(_tgs.CellGetIndex(x)) == (int)CellBuildingType.RAILS).ToArray();
                    break;
                default:
                    availableCells = cells.Any()
                        ? _tgs.CellGetNeighbours(cells.Last()).Where(cell => cell.canCross).ToArray()
                        : _tgs.CellGetNeighbours(startCell).Where(cell => cell.canCross).ToArray();
                    break;
            }

            HighlightAvailableCells(availableCells);
            
            return availableCells;
        }

        private void HighlightAvailableCells(Cell[] availableCells)
        {
            foreach (var cell in availableCells)
            {
                int index = _tgs.CellGetIndex(cell);
                _tgs.CellToggleRegionSurface(index, true, Color.green);
            }
        }

        public void ClearHighlightedCells(Cell[] availableCells)
        {
            foreach (var cell in availableCells)
            {
                int index = _tgs.CellGetIndex(cell);
                _tgs.CellToggleRegionSurface(index, false, Color.green);
            }
        }
    }
}
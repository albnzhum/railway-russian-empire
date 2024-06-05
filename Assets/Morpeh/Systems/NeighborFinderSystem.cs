using System.Collections.Generic;
using System.Linq;
using Railway.Shop.Data;
using Scellecs.Morpeh;
using Scellecs.Morpeh.Systems;
using TGS;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;

namespace Railway.Morpeh
{
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    [CreateAssetMenu(menuName = "ECS/Systems/" + nameof(NeighborFinderSystem))]
    public sealed class NeighborFinderSystem : UpdateSystem
    {
        private Filter tgsFilter;

        private TerrainGridSystem tgs;

        public override void OnAwake()
        {
            tgsFilter = World.Filter.With<TGSComponent>().Build();

            foreach (var entity in tgsFilter)
            {
                ref var tgsComponent = ref entity.GetComponent<TGSComponent>();

                tgs = tgsComponent.Tgs;
            }
        }

        public override void OnUpdate(float deltaTime)
        {
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
                    availableCells = tgs.Cells
                        .Where(x => tgs.CellGetTag(tgs.CellGetIndex(x)) == (int)CellBuildingType.RAILS).ToArray();
                    break;
                case ItemType.Workers:
                    availableCells = tgs.Cells
                        .Where(x => tgs.CellGetTag(tgs.CellGetIndex(x)) == (int)CellBuildingType.BUILD).ToArray();
                    break;
                case ItemType.Carriage:
                    availableCells = tgs.Cells
                        .Where(x => tgs.CellGetTag(tgs.CellGetIndex(x)) == (int)CellBuildingType.RAILS).ToArray();
                    break;
                default:
                    availableCells = cells.Any()
                        ? tgs.CellGetNeighbours(cells.Last()).Where(cell => cell.canCross).ToArray()
                        : tgs.CellGetNeighbours(startCell).Where(cell => cell.canCross).ToArray();
                    break;
            }

            HighlightAvailableCells(availableCells);

            return availableCells;
        }

        private void HighlightAvailableCells(Cell[] availableCells)
        {
            foreach (var cell in availableCells)
            {
                int index = tgs.CellGetIndex(cell);
                tgs.CellToggleRegionSurface(index, true, Color.green);
            }
        }

        public void ClearHighlightedCells(Cell[] availableCells)
        {
            foreach (var cell in availableCells)
            {
                int index = tgs.CellGetIndex(cell);
                tgs.CellToggleRegionSurface(index, false, Color.green);
            }
        }
    }
}
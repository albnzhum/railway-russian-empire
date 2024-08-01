using System.Collections.Generic;
using Railway.Shop.Data;
using Scellecs.Morpeh;
using TGS;
using Unity.IL2CPP.CompilerServices;

namespace Railway.Morpeh
{
    [System.Serializable]
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    public struct CellSelectionComponent : IComponent
    {
        public Cell CurrentCell;
        public Cell StartCell;
        public List<Cell> AvailableCells;
        public Dictionary<ItemType, List<Cell>> OccupiedCells;
        
        public bool IsPlacing;
    }
}
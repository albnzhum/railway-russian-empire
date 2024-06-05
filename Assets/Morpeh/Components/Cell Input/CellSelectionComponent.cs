using System.Collections.Generic;
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
        
        public bool IsPlacing;
    }
}
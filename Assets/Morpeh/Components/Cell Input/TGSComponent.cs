using Scellecs.Morpeh;
using TGS;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;

namespace Railway.Morpeh
{
    [System.Serializable]
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    public struct TGSComponent : IComponent
    {
        public TerrainGridSystem Tgs;
    }
}
using R3;
using Railway.Input;
using Scellecs.Morpeh;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;

namespace Railway.Morpeh
{
    [System.Serializable]
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    public struct CellInputHandler : IComponent
    {
        public InputReader InputReader;
        public Observable<Vector2> OnChooseItemPositionStream;
        public Observable<Vector2> OnPlaceItemStream;
    }
}
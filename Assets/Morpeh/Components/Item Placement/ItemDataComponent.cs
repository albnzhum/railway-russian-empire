using Railway.Gameplay;
using Railway.Shop.Data;
using Scellecs.Morpeh;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;

[System.Serializable]
[Il2CppSetOption(Option.NullChecks, false)]
[Il2CppSetOption(Option.ArrayBoundsChecks, false)]
[Il2CppSetOption(Option.DivideByZeroChecks, false)]
public struct ItemDataComponent : IComponent
{
    public ShopItem CurrentItem;
    public IPlaceable CurrentPlacer;
}
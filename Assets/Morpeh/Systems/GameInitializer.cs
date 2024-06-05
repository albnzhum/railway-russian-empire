using Scellecs.Morpeh;
using Scellecs.Morpeh.Systems;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;

namespace Railway.Morpeh
{
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    [CreateAssetMenu(menuName = "ECS/Initializers/" + nameof(GameInitializer))]
    public sealed class GameInitializer : Initializer
    {
        public override void OnAwake()
        {
            var entity = World.CreateEntity();
            ref var gameStateComponent = ref entity.AddComponent<GameStateComponent>();
        }

        public override void Dispose()
        {
        }
    }
}
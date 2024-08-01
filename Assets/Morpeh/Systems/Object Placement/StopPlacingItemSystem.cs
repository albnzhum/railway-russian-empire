using Railway.Gameplay;
using Scellecs.Morpeh;
using Scellecs.Morpeh.Globals.Events;
using Scellecs.Morpeh.Systems;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;

namespace Railway.Morpeh
{
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    [CreateAssetMenu(menuName = "ECS/Systems/" + nameof(StopPlacingItemSystem))]
    public sealed class StopPlacingItemSystem : UpdateSystem
    {
        public GlobalEvent stopPlacingEvent;

        private Filter _gameStateFilter;

        public override void OnAwake()
        {
            _gameStateFilter = World.Filter.With<GameStateComponent>().Build();
        }

        public override void OnUpdate(float deltaTime)
        {
            if (stopPlacingEvent.IsPublished)
            {
                foreach (var entity in _gameStateFilter)
                {
                    ref var gameStateComponent = ref entity.GetComponent<GameStateComponent>();
                    
                    gameStateComponent.GameState.UpdateGameState(GameState.Gameplay);
                }
            }
        }
    }
}
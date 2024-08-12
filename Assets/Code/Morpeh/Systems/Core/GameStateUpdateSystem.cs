using Railway.Gameplay;
using Scellecs.Morpeh;
using Scellecs.Morpeh.Systems;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;

namespace Railway.Morpeh
{
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    [CreateAssetMenu(menuName = "ECS/Systems/" + nameof(GameStateUpdateSystem))]
    public sealed class GameStateUpdateSystem : UpdateSystem
    {
        private Filter _filter;

        public override void OnAwake()
        {
            _filter = World.Filter.With<GameStateComponent>().With<CellInputHandler>().Build();
        }

        public override void OnUpdate(float deltaTime)
        {
            foreach (var entity in _filter)
            {
                ref var gameStateComponent = ref entity.GetComponent<GameStateComponent>();

                ref var inputHandlerComponent = ref entity.GetComponent<CellInputHandler>();

                var inputReader = inputHandlerComponent.InputReader;

                switch (gameStateComponent.GameState.CurrentGameState)
                {
                    case GameState.Gameplay:
                        inputReader.EnableGameplayInput();
                        break;
                    case GameState.Edit:
                        inputReader.EnableEditInput();
                        break;
                    case GameState.Tutorial:
                        inputReader.EnableTutorialInput();
                        break;
                    case GameState.Shop:
                        inputReader.EnableMenuInput();
                        break;
                    case GameState.Pause:
                        inputReader.EnableMenuInput();
                        break;
                }
            }
        }
    }
}
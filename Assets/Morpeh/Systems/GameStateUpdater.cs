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
    [CreateAssetMenu(menuName = "ECS/Systems/" + nameof(GameStateUpdater))]
    public sealed class GameStateUpdater : UpdateSystem
    {
        private Filter _gameStateFilter;
        private Filter _inputHandler;
        
        public override void OnAwake()
        {
            _gameStateFilter = World.Filter.With<GameStateComponent>().Build();
            _inputHandler = World.Filter.With<CellInputHandler>().Build();
        }

        public override void OnUpdate(float deltaTime)
        {
            foreach (var gameStateEntity in _gameStateFilter)
            {
                ref var gameStateComponent = ref gameStateEntity.GetComponent<GameStateComponent>();

                foreach (var inputEntity in _inputHandler)
                {
                    ref var inputHandlerComponent = ref inputEntity.GetComponent<CellInputHandler>();

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
}
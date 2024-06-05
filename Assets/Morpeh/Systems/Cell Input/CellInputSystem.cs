using System;
using R3;
using Railway.Input;
using Railway.Morpeh;
using Scellecs.Morpeh;
using Scellecs.Morpeh.Globals.Events;
using Scellecs.Morpeh.Systems;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;
using Zenject;

namespace Railway.Morpeh
{
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    [CreateAssetMenu(menuName = "ECS/Systems/" + nameof(CellInputSystem))]
    public sealed class CellInputSystem : UpdateSystem
    {
        private InputReader _inputReader;
        private CompositeDisposable disposable = new CompositeDisposable();

        private Filter filter;
        private Filter cellFilter;

        public GlobalEvent stopPlacingEvent;

        public override void OnAwake()
        {
            this.filter = this.World.Filter.With<CellInputHandler>().Build();
            this.cellFilter = this.World.Filter.With<CellSelectionComponent>().Build();

            foreach (var entity in filter)
            {
                ref var cellInputHandler = ref entity.GetComponent<CellInputHandler>();
                _inputReader = cellInputHandler.InputReader;

                cellInputHandler.OnChooseItemPositionStream = Observable.FromEvent<Vector2>(
                    handler => _inputReader.PlaceItemEvent += handler,
                    handler => _inputReader.PlaceItemEvent -= handler);

                cellInputHandler.OnPlaceItemStream = Observable.FromEvent<Vector2>(
                        handler => _inputReader.PlaceItemEvent += handler,
                        handler => _inputReader.PlaceItemEvent -= handler)
                    .Where(_ => UnityEngine.Input.GetMouseButtonDown(0));

                cellInputHandler.InputReader.OnCancelEvent += StopPlacing;
            }
        }

        public override void OnUpdate(float deltaTime)
        {
        }

        private void StopPlacing()
        {
            foreach (var entity in cellFilter)
            {
                ref var cellSelectionComponent = ref entity.GetComponent<CellSelectionComponent>();
                cellSelectionComponent.IsPlacing = false;
            }
            
            stopPlacingEvent.Publish();

            _inputReader.EnableGameplayInput();
        }
    }
}
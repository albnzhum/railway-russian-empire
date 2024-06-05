using R3;
using Railway.Gameplay;
using Scellecs.Morpeh;
using Scellecs.Morpeh.Globals.Events;
using Scellecs.Morpeh.Systems;
using TGS;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;
using Zenject;
using CellInputHandler = Railway.Morpeh.CellInputHandler;

namespace Railway.Morpeh
{
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    [CreateAssetMenu(menuName = "ECS/Systems/" + nameof(ItemPlacementSystem))]
    public sealed class ItemPlacementSystem : UpdateSystem
    {
        private Filter inputHandlerFilter;

        private TerrainGridSystem tgs;
        
        public override void OnAwake()
        {
            inputHandlerFilter = World.Filter.With<CellInputHandler>().With<TGSComponent>().Build();
            
            foreach (var entity in inputHandlerFilter)
            {
                ref var inputHandler = ref entity.GetComponent<CellInputHandler>();
                ref var cellComponent = ref entity.AddComponent<CellSelectionComponent>();

                inputHandler.OnChooseItemPositionStream
                    .Subscribe(OnChooseItemPosition);
                inputHandler.OnPlaceItemStream
                    .Subscribe(PlaceItem);
            }
            
            inputHandlerFilter = World.Filter.With<CellInputHandler>().With<CellSelectionComponent>().Build();
            
            foreach (var tgsEntity in inputHandlerFilter)
            {
                ref var tgsComponent = ref tgsEntity.GetComponent<TGSComponent>();

                tgs = tgsComponent.Tgs;
            }
        }

        public override void OnUpdate(float deltaTime) {
        }

        private void PlaceItem(Vector2 mousePosition)
        {
            foreach (var entity in inputHandlerFilter)
            {
                ref var cellComponent = ref entity.GetComponent<CellSelectionComponent>();

                var currentCell = cellComponent.CurrentCell;

                if (currentCell == null) return;

                if (currentCell.tag == (int)CellBuildingType.NON_INTERACTABLE) return;
                
                if (cellComponent.AvailableCells.Contains(currentCell))
                {
                    PlaceItem();
                }
            }
        }

        private void PlaceItem()
        {
            foreach (var entity in inputHandlerFilter)
            {
                ref var cellComponent = ref entity.GetComponent<CellSelectionComponent>();
                
                cellComponent.IsPlacing = true;

                var startCell = cellComponent.StartCell;
                var currentCell = cellComponent.CurrentCell;
                //PlacementManager.Instance(_tgs).PlaceItem(startCell, currentCell, _currentItemData);
                
                var cellPosition = tgs.CellGetPosition(currentCell);
            }


            /* var ps = Instantiate(_particleSystem, cellPosition, Quaternion.identity);

        ps.transform.position = cellPosition;

        _occupiedCells[_currentItemData.CurrentItem.ItemType.Type].Add(_currentCell);

        StopPlacing();*/
        }

        private void OnChooseItemPosition(Vector2 mousePosition)
        {
            foreach (var entity in inputHandlerFilter)
            {
                ref var cellComponent = ref entity.GetComponent<CellSelectionComponent>();

                var currentCell = cellComponent.CurrentCell;

                if (cellComponent.IsPlacing)
                {
                    Ray ray = Camera.main.ScreenPointToRay(mousePosition);

                    RaycastHit hit;
                    if (Physics.Raycast(ray, out hit))
                    {
                        currentCell = DetermineCell(hit.point);
                    }
                }
            }
        }

        private Cell DetermineCell(Vector3 position)
        {
            return tgs.CellGetAtPosition(position, true);
        }
    }
}
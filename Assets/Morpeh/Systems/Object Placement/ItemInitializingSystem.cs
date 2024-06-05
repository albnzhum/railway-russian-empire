using Railway.Gameplay;
using Railway.Shop.Data;
using Scellecs.Morpeh;
using Scellecs.Morpeh.Systems;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;

namespace Railway.Morpeh
{
    [Il2CppSetOption(Option.NullChecks, false)]
    [Il2CppSetOption(Option.ArrayBoundsChecks, false)]
    [Il2CppSetOption(Option.DivideByZeroChecks, false)]
    [CreateAssetMenu(menuName = "ECS/Systems/" + nameof(ItemInitializingSystem))]
    public sealed class ItemInitializingSystem : UpdateSystem
    {
        private Filter itemEventFilter;
        private Filter itemDataFilter;

        public override void OnAwake()
        {
            itemEventFilter = World.Filter.With<UseItemEvent>().Build();

            var entity = World.CreateEntity();
            ref var itemData = ref entity.AddComponent<ItemDataComponent>();

            itemDataFilter = World.Filter.With<ItemDataComponent>().Build();

            foreach (var itemEvent in itemEventFilter)
            {
                ref var useItemEvent = ref itemEvent.GetComponent<UseItemEvent>();
                useItemEvent.UseItemEventChannel.OnEventRaised += SetCurrentItem;
            }
        }

        public override void Dispose()
        {
            foreach (var itemEvent in itemEventFilter)
            {
                ref var useItemEvent = ref itemEvent.GetComponent<UseItemEvent>();
                useItemEvent.UseItemEventChannel.OnEventRaised -= SetCurrentItem;
            }
        }

        private void SetCurrentItem(ShopItem _currentItem)
        {
            foreach (var entity in itemDataFilter)
            {
                ref var itemData = ref entity.GetComponent<ItemDataComponent>();
                itemData.CurrentItem = _currentItem;
                itemData.CurrentPlacer = _currentItem.Prefab.GetComponent<IPlaceable>();
            }
        }

        public override void OnUpdate(float deltaTime)
        {
            
        }
    }
}
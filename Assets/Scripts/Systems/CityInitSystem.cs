using Components;
using Leopotam.EcsLite;
using Leopotam.EcsLite.Di;
using UnityEngine;

public class CityInitSystem : IEcsInitSystem
{
    private EcsWorld _world;
    readonly EcsCustomInject<StaticData> config = default;
    
    public void Init(IEcsSystems systems)
    {
        _world = systems.GetWorld();
        
        //config.Value.City.Resources.Money 
    }
}

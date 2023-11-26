using Leopotam.EcsLite;
using Components;
using UnityEngine;

public class TimeSystem : IEcsInitSystem, IEcsRunSystem
{
    private EcsWorld _world;
    private EcsPool<TimeComponent> Time;

    private int entity;

    public void Init(IEcsSystems systems)
    {
        _world = systems.GetWorld();
        Time = _world.GetPool<TimeComponent>();

        entity = _world.NewEntity();
        
        ref TimeComponent timeComponent = ref Time.Add(entity);
        timeComponent.TimeToUpdate = 120f;
        timeComponent.RealTimeElapsed = 0f;
        timeComponent.GameTime = 1836;
    }

    public void Run(IEcsSystems systems)
    {
        ref var _time = ref Time.Get(entity);

        _time.RealTimeElapsed += UnityEngine.Time.deltaTime;
        if (_time.RealTimeElapsed >= _time.TimeToUpdate)
        {
            _time.GameTime += 1;
            _time.RealTimeElapsed = 0f;
            Debug.Log(_time.GameTime);
        }
    }
}

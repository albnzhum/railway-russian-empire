using System.Collections.Generic;
using JimboA.Plugins.EcsProviders;
using UnityEngine;
using Leopotam.EcsLite;
using Leopotam.EcsLite.Di;
using Leopotam.EcsLite.Unity.Ugui;
using Leopotam.EcsLite.ExtendedSystems;
using UI;

public class Startup : MonoBehaviour
{
    [SerializeField] private EcsUguiEmitter _uguiEmitter;
    private EcsWorld _world;
    private IEcsSystems _systems;
    private void Start()
    {
        _world = new EcsWorld();
        _systems = new EcsSystems(_world);
        _systems
            .AddWorld(_world, "Events")

            .Add(new MainMenuSystem())
            .InjectUgui(_uguiEmitter)
            .Init();
    }
    

    private void Update()
    {
        _systems?.Run();
        //print("working");
    }

    private void OnDestroy()
    {
        if (_systems != null) {
            _systems.GetWorld ("ugui-events").Destroy ();
            _systems.Destroy ();
            _systems.GetWorld ().Destroy ();
            _systems = null;
        }
    }
}

public static class EcsSystemGroupExtensions
{
    public static List<IEcsSystem> AddToGroup(this List<IEcsSystem> systemGroup, IEcsSystem system)
    {
        systemGroup.Add(system);
        return systemGroup;
    }
        
    public static List<IEcsSystem> DelHere<TComponent>(this List<IEcsSystem> systemGroup, EcsWorld world) where TComponent : struct
    {
        systemGroup.Add(new DelHereSystem<TComponent>(world));
        return systemGroup;
    }
}

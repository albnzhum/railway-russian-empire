using System.Collections.Generic;
using UnityEngine;
using Leopotam.EcsLite;
using Leopotam.EcsLite.Di;
using Leopotam.EcsLite.ExtendedSystems;
using Voody.UniLeo.Lite;
using Leopotam.EcsLite.Unity.Ugui;
using UI;

public class Startup : MonoBehaviour
{
    [SerializeField] private EcsUguiEmitter _uguiEmitter;
    private EcsWorld _world;
    private EcsSystems _systems;
    
    public StaticData configuration;

    private void Awake()
    { _world = new EcsWorld();
        _systems = new EcsSystems(_world);
        _systems
            .ConvertScene()
            .AddWorld(_world, "Startup")
            
            .Add(new MainMenuSystem())
#if UNITY_EDITOR
            .Add (new Leopotam.EcsLite.UnityEditor.EcsWorldDebugSystem ())
            .Add (new Leopotam.EcsLite.UnityEditor.EcsSystemsDebugSystem ())
#endif
            .Inject(configuration)
            .InjectUgui(_uguiEmitter)
            .Init();

        DontDestroyOnLoad(this);
    }
    
    private void Update()
    {
        _systems?.Run();
    }

    private void OnDestroy()
    {
        if (_systems != null)
        {
            _systems.Destroy();
            _systems.GetWorld().Destroy();
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

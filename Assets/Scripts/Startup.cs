using System.Collections.Generic;
using UnityEngine;
using Leopotam.EcsLite;
using Leopotam.EcsLite.Unity.Ugui;
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

using UnityEngine;
using Leopotam.EcsLite;
using Leopotam.EcsLite.Di;
using Voody.UniLeo.Lite;
using Leopotam.EcsLite.Unity.Ugui;
using UI;

public class Startup : MonoBehaviour
{
    [SerializeField] private EcsUguiEmitter _uguiEmitter;
    private EcsWorld _world;
    private EcsSystems _systems;
    
    public StaticData configuration;

    private void Start()
    {
        _world = new EcsWorld();
        _systems = new EcsSystems(_world);
        _systems
            .ConvertScene()
            .AddWorld(_world, "Events")
            .Add(new MainMenuSystem())
            .Add(new CellTerrainTypesSystem())
            .Add(new MouseInputSystem())
            .Add(new ChooseBuildingSystem())
            .Add(new TimeSystem())
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
           // _systems.GetWorld("ugui-events").Destroy();
            _systems.Destroy();
            _systems.GetWorld().Destroy();
            _systems = null;
        }
    }
}

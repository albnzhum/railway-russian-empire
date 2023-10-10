using UnityEngine;
using Leopotam.EcsLite;
using Leopotam.EcsLite.Di;
using Leopotam.EcsLite.Unity.Ugui;
using Leopotam.EcsLite.ExtendedSystems;
using UI;

public class Startup : MonoBehaviour
{
    [SerializeField] private EcsUguiEmitter _uguiEmitter;
    [SerializeField] private EcsUGuiMediator _uguiMediator;
    private EcsWorld _world;
    private IEcsSystems _systems;
    private ScreenStorage _screens;

    private void Start()
    {
        _world = new EcsWorld();
        _systems = new EcsSystems(_world);
        //_screens = new ScreenStorage();

        _systems
            .Add(new MainMenuSystem())
            .DelHere<ShowScreenRequest>()
            .DelHere<HideScreenRequest>()
            
            .Inject(_screens)
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

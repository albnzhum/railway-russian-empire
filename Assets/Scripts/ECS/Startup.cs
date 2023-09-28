using System;
using UnityEngine;
using Leopotam.Ecs;
using Voody.UniLeo;

public class Startup : MonoBehaviour
{
    private EcsWorld ecsWorld;
    private EcsSystems systems;

    private void Start()
    {
        ecsWorld = new EcsWorld();
        systems = new EcsSystems(ecsWorld);
        
        /*systems
            .Add()*/
    }

    private void Update()
    {
        systems?.Run();
    }

    private void OnDestroy()
    {
        systems?.Destroy();
        systems = null;
        ecsWorld?.Destroy();
        ecsWorld = null;
    }
}

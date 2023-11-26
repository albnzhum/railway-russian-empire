using Components;
using Leopotam.EcsLite;
using TGS;
using UnityEngine;

public class MouseInputSystem : IEcsRunSystem, IEcsInitSystem
{
    private EcsWorld _world;
    
    EcsPool<CellComponent> _cells;
    private TerrainGridSystem _tgs;

    public void Init(IEcsSystems systems)
    {
        _world = systems.GetWorld();
        _tgs = TerrainGridSystem.Instance;
        
        _cells = _world.GetPool<CellComponent>();
        
        var entity = _world.NewEntity();
        _cells.Add(entity);
    }

    public void Run(IEcsSystems systems)
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit))
            {
                Cell _cell = DetermineCell(hit.point);

                if (_cell != null)
                {
                   // var entity = _world.NewEntity();
                    ref var cell = ref _cells.Get(0);
                    cell.Cell = _cell;
                    Debug.Log(cell.Cell.Tag);
                }
            }
        }
    }

    private Cell DetermineCell(Vector3 position)
    {
        return _tgs.CellGetAtPosition(position, true);
    }
}

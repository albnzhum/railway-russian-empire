using UnityEngine;
using Leopotam.EcsLite;
using Leopotam.EcsLite.Di;
using TGS;
using Components;

/// <summary>
/// Instantiate building
/// </summary>
public class ChooseBuildingSystem : IEcsRunSystem, IEcsInitSystem
{
    private EcsWorld _world;
    private EcsPool<Building> _buildings;

    readonly EcsCustomInject<StaticData> config = default;
    private TerrainGridSystem _tgs;

    public void Init(IEcsSystems systems)
    {
        _world = systems.GetWorld();
        _tgs = TerrainGridSystem.Instance;
        _buildings = _world.GetPool<Building>();
    }

    public void Run(IEcsSystems systems)
    {
        if (GetChosenCell(_world) != null)
        {
            ref var cellChosen = ref _world.GetPool<CellComponent>().Get(0);
            if (cellChosen.Cell.Building.Equals(default(Building)) && cellChosen.Cell.Tag != 2)
            {
                var entity = _world.NewEntity();
                _buildings.Add(entity);
                
                ref Building building = ref _buildings.Get(entity);

                if (building.prefab == null)
                {
                    GameObject buildingPrefab = (GameObject)Object.Instantiate(config.Value.Home,
                        _tgs.CellGetPosition(cellChosen.Cell), Quaternion.identity);
                    
                    building.prefab = buildingPrefab;
                    building.name = buildingPrefab.name;
                    cellChosen.Cell.Building = building;
                }
                else
                {
                    Debug.Log("prefab is not null");
                }
            }
        }
    }

    public Cell GetChosenCell(EcsWorld world)
    {
        ref var cellChosen = ref world.GetPool<CellComponent>().Get(0);
        if (world.IsAlive())
        {
            return cellChosen.Cell;
        }

        return null;
    }
}
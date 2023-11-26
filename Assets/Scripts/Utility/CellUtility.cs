using Leopotam.EcsLite;
using TGS;
using Components;

public static class CellUtility 
{
    public static Cell GetChosenCell(EcsWorld world)
    {
        EcsFilter cellChosenFilter = world.Filter<CellComponent>().End();

        if (cellChosenFilter.GetEntitiesCount() > 0)
        {
            ref var cellChosen = ref world.GetPool<CellComponent>().Get(0);
            if (world.IsAlive())
            {
                return cellChosen.Cell;
            }
        }

        return null;
    }
}


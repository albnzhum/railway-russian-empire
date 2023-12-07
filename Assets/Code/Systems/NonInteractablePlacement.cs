using Scellecs.Morpeh;
using Scellecs.Morpeh.Systems;
using UnityEngine;
using Unity.IL2CPP.CompilerServices;
using TGS;

[Il2CppSetOption(Option.NullChecks, false)]
[Il2CppSetOption(Option.ArrayBoundsChecks, false)]
[Il2CppSetOption(Option.DivideByZeroChecks, false)]
[CreateAssetMenu(menuName = "ECS/Systems/" + nameof(NonInteractablePlacement))]
public sealed class NonInteractablePlacement : UpdateSystem
{
    private Filter filter;

    private TerrainGridSystem _tgs;

    public override void OnAwake()
    {
        _tgs = TerrainGridSystem.Instance;
        this.filter = this.World.Filter.With<NonInteractableObject>().Build();
    }

    public override void OnUpdate(float deltaTime)
    {
        foreach (var entity in filter)
        {
            ref var nonInteractableObject = ref entity.GetComponent<NonInteractableObject>();
            Cell cellUnderGO = _tgs.CellGetAtPosition(nonInteractableObject.Object.transform.position, true);
            Debug.Log(nonInteractableObject.Object.transform.position);

            if (cellUnderGO != null)
            {
                nonInteractableObject.Object.transform.position = _tgs.CellGetPosition(cellUnderGO);
                nonInteractableObject.Cell = _tgs.CellGetIndex(cellUnderGO);
                Debug.Log(nonInteractableObject.Cell);
            }
            else
            {
                Debug.LogWarning("NonInteractable object is not over a valid TGS cell.");
            }
        }
    }
}
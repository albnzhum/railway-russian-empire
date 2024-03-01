using UnityEngine;

public class PlacingObject : MonoBehaviour
{
    [SerializeField] private GameObject _object;
    [SerializeField] private int _cellIndex;

    public GameObject Object => _object;

    public int CellIndex
    {
        get => _cellIndex;
        set => _cellIndex = value;
    }
}

using UnityEngine;
using Components;

public enum LevelDifficulty
{
    Easy,
    Normal,
    Hard
}

[CreateAssetMenu]
public class StaticData : ScriptableObject
{
    public GameObject Home;
    public int Gold;

    public CityComponent City;
    public LevelDifficulty LevelDifficulty;
    public bool isReady;
}

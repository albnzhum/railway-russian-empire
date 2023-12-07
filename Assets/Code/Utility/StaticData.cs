using UnityEngine;
using Components;

public enum LevelDifficulty
{
    Easy,
    Normal,
    Hard
}

public class StaticData
{
    public CityComponent City;
    public LevelDifficulty LevelDifficulty;
}

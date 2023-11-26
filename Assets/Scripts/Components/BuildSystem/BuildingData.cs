using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "NewBuildingData", menuName = "Building Data")]
public class BuildingData : ScriptableObject
{
    public GameObject buildGO;
    public int cost;
}

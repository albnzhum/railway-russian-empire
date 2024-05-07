using System;
using Railway.Events;
using UnityEngine;

namespace Code.Gameplay.ResourceManager
{
    public class BuildingResourceManager : MonoBehaviour
    {
        [SerializeField] private VoidEventChannelSO OnBuildCompleted;

        private void OnEnable()
        {
        }
    }
}
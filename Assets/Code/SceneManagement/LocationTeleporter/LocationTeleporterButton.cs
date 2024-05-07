using System;
using Railway.Components;
using UnityEngine;

namespace Railway.SceneManagement
{
    public class LocationTeleporterButton : MonoBehaviour
    {
        [SerializeField] private LocationSO _location;
        [SerializeField] private MissionInitializer _MissionInitializer;

        private LocationTeleporter _teleporter;

        private void Awake()
        {
            _teleporter = GetComponentInParent<LocationTeleporter>();
        }

        public void ShowMissionInfo()
        {
            _teleporter.locationTeleporterInfo.ShowMissionInfo(_MissionInitializer);

            _teleporter.levelDifficulty.Teleporter = _teleporter;
            _teleporter.levelDifficulty.location = _location;
        }
    }
}
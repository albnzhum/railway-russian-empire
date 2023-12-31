using Railway.Components;
using Railway.Events;
using Railway.Gameplay;
using UnityEngine;

namespace Railway.SceneManagement
{
    public class LevelDifficultyInitializer : MonoBehaviour
    {
        [SerializeField] private VoidEventChannelSO _onChangeLevelDifficulty;
        [SerializeField] private GameSetupEventSO _onGameSetup;
        
        [SerializeField] public MissionInitializer mission;
        [SerializeField] public LocationSO location;
        
        [HideInInspector] public LocationTeleporter Teleporter;
        
        private LevelDifficulty _levelDifficulty;

        private void ScalingFactor(float scaleFactor)
        {
            if (!mission.isOriginalResourcesSaved)
            {
                mission.originalResources = new MissionInitializer.Resources
                {
                    Gold = mission.resources.Gold,
                    Workers = mission.resources.Workers,
                    Church = mission.resources.Church,
                    SpeedBuilding = mission.resources.SpeedBuilding
                };
                mission.isOriginalResourcesSaved = true;
            }

            mission.resources.Gold = mission.originalResources.Gold * scaleFactor;
            mission.resources.Workers = mission.originalResources.Workers * scaleFactor;
            mission.resources.Church = mission.originalResources.Church * scaleFactor;
            mission.resources.SpeedBuilding = mission.originalResources.SpeedBuilding * scaleFactor;
        }
        
        public void NormalLevelDifficulty()
        {
            ScalingFactor(1f);
            _levelDifficulty = LevelDifficulty.Easy;
            _onChangeLevelDifficulty.RaiseEvent();
        }
        
        public void MediumLevelDifficulty()
        {
            ScalingFactor(2f);
            _levelDifficulty = LevelDifficulty.Medium;
            _onChangeLevelDifficulty.RaiseEvent();
        }
        
        public void HardLevelDifficulty()
        {
            ScalingFactor(2.5f);
            _levelDifficulty = LevelDifficulty.Hard;
            _onChangeLevelDifficulty.RaiseEvent();
        }

        public void LoadLocation()
        {
            _onGameSetup.RaiseEvent(mission, _levelDifficulty);

            if (Teleporter!= null) 
            {
                Teleporter.Teleport(location);
            }
        }

    }
}

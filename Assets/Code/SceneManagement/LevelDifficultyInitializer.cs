using R3;
using Railway.Components;
using Railway.Events;
using Railway.Gameplay;
using UnityEngine;

namespace Railway.SceneManagement
{
    public class LevelDifficultyInitializer : MonoBehaviour
    {
        [SerializeField] private VoidEventChannelSO _onChangeLevelDifficulty;
        
        [SerializeField] public MissionInitializer mission;
        [SerializeField] public LocationSO location;
        
        [HideInInspector] public LocationTeleporter Teleporter;
        
        private LevelDifficulty _levelDifficulty;

        private void ScalingFactor(float scaleFactor)
        {
            mission.CurrentResources.Gold.Value = mission.OriginalResources.Gold.Value * scaleFactor;
            mission.CurrentResources.Workers.Value = mission.OriginalResources.Workers.Value * scaleFactor;
            mission.CurrentResources.Church.Value = mission.OriginalResources.Church.Value * scaleFactor;
            mission.CurrentResources.SpeedBuilding.Value = mission.OriginalResources.SpeedBuilding.Value * scaleFactor;
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
            if (Teleporter!= null) 
            {
                Teleporter.Teleport(location);
            }
        }
    }
}

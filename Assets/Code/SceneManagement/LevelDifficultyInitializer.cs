using System;
using System.Collections;
using System.Collections.Generic;
using Railway.Components;
using Railway.Events;
using UnityEngine;

namespace Railway.SceneManagement
{
    public class LevelDifficultyInitializer : MonoBehaviour
    {
        [SerializeField] private VoidEventChannelSO _onChangeLevelDifficulty;
        
        [HideInInspector] public MissionInitializer mission;
        [HideInInspector] public LocationSO location;
        [HideInInspector] public LocationTeleporter Teleporter;

        private void ScalingFactor(float scaleFactor)
        {
            // Проверяем, были ли уже сохранены оригинальные значения
            if (!mission.isOriginalResourcesSaved)
            {
                // Сохраняем оригинальные значения перед первым масштабированием
                mission.originalResources = new MissionInitializer.Resources
                {
                    Gold = mission.resources.Gold,
                    Workers = mission.resources.Workers,
                    Church = mission.resources.Church,
                    SpeedBuilding = mission.resources.SpeedBuilding
                };
                mission.isOriginalResourcesSaved = true;
            }

            // Масштабирование относительно оригинальных значений
            mission.resources.Gold = mission.originalResources.Gold * scaleFactor;
            mission.resources.Workers = mission.originalResources.Workers * scaleFactor;
            mission.resources.Church = mission.originalResources.Church * scaleFactor;
            mission.resources.SpeedBuilding = mission.originalResources.SpeedBuilding * scaleFactor;
        }
        
        public void NormalLevelDifficulty()
        {
            ScalingFactor(1.5f);
            _onChangeLevelDifficulty.RaiseEvent();
        }
        
        public void MediumLevelDifficulty()
        {
            ScalingFactor(2f);
            _onChangeLevelDifficulty.RaiseEvent();
        }
        
        public void HardLevelDifficulty()
        {
            ScalingFactor(2.5f);
            _onChangeLevelDifficulty.RaiseEvent();
        }

        public void LoadLocation()
        {
            Teleporter.Teleport(location);
        }

    }
}

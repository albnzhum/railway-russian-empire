using System.Collections;
using System.Collections.Generic;
using Railway.Components;
using Railway.Gameplay;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Events
{
    [CreateAssetMenu(menuName = "Events/Game Setup Event Channel")]
    public class GameSetupEventSO : ScriptableObject
    {
        public event UnityAction<MissionInitializer, LevelDifficulty> OnGameSetup;

        public void RaiseEvent(MissionInitializer mission, LevelDifficulty levelDifficulty)
        {
            if (OnGameSetup != null)
            {
                OnGameSetup.Invoke(mission, levelDifficulty);
            }
            else
            {
                Debug.LogWarning("Nobody picked it up");
            }
        }
    }
}
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Railway.Tutorials
{
    public class TutorialSystem : MonoBehaviour
    {
        [SerializeField] private List<TutorialStage> _tutorialStages;
        [SerializeField] private Button _skipButton;

        private int currentStageIndex = 0;
        private bool isCompleted;

        public bool IsCompleted => isCompleted;

    }
}

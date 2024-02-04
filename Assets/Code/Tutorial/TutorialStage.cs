using UnityEngine;
using UnityEngine.UI;

namespace Railway.Tutorials
{
    public class TutorialStage : MonoBehaviour
    {
        [Header("UI elements")]
        [SerializeField] private GameObject _tutorialWindow;
        [SerializeField] private Button _closeButton;

        private bool isCompleted;

        public bool IsCompleted => isCompleted;

        public void Show()
        {
            
        }


    }
}

using UnityEngine;

namespace Railway.Gameplay
{
    [CreateAssetMenu(fileName = "New Cell Exit Event", menuName = "Events/Grid/Cell Exit Event")]
    public class CellExitEventSO : ScriptableObject
    {
        public event CellEvent OnCellExit;

        public void RaiseEvent()
        {
            if (OnCellExit != null)
            {
                OnCellExit.Invoke();
            }
        }
    }
}
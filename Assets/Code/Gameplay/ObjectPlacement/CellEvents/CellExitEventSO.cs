using UnityEngine;

namespace Railway.Gameplay
{
    [CreateAssetMenu(fileName = "New Cell Exit Event", menuName = "Events/Grid/Cell Exit Event")]
    public class CellExitEventSO : ScriptableObject
    {
        public event CellEvent OnCellExit;

        public void RaiseEvent(int index)
        {
            if (OnCellExit != null)
            {
                OnCellExit.Invoke(index);
            }
        }
    }
}
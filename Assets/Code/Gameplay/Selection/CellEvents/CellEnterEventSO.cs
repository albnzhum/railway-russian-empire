using UnityEngine;

namespace Railway.Gameplay
{
    [CreateAssetMenu(fileName = "New Cell Enter Event", menuName = "Events/Grid/Cell Enter Event")]
    public class CellEnterEventSO : ScriptableObject
    {
        public event CellEvent OnCellEnter;

        public void RaiseEvent(int index)
        {
            if (OnCellEnter != null)
            {
                OnCellEnter?.Invoke(index);
            }
        }
    }
}
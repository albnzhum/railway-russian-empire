using UnityEngine;

namespace Railway.Gameplay
{
    public delegate void CellEvent(int index);
    
    [CreateAssetMenu(fileName = "New Cell Clicked Event", menuName = "Events/Grid/Cell Click Event")]
    public class CellClickedEventSO : ScriptableObject
    {
        public event CellEvent OnCellClick;

        public void RaiseEvent(int index)
        {
            if (OnCellClick != null)
            {
                OnCellClick.Invoke(index);
            }
        }
    }
}
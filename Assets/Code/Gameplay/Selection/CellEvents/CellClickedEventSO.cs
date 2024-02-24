using UnityEngine;

namespace Railway.Gameplay
{
    public delegate Vector3 CellEvent();
    
    [CreateAssetMenu(fileName = "New Cell Clicked Event", menuName = "Events/Grid/Cell Click Event")]
    public class CellClickedEventSO : ScriptableObject
    {
        public event CellEvent OnCellClick;

        public void RaiseEvent()
        {
            if (OnCellClick != null)
            {
                OnCellClick.Invoke();
            }
        }
    }
}
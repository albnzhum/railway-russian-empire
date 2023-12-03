using TGS;
using UnityEngine;

namespace Components
{
    public class CellComponent : MonoBehaviour
    {
        public Cell Cell;
        public static CellComponent Instance { get; set; }

        void Start()
        {
            if (Instance == null)
            {
                Instance = this;
            }
        }
    }
}

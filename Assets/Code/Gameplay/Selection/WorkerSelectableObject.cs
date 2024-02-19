using System.Collections;
using System.Collections.Generic;
using Railway.Shop.Data;
using UnityEngine;

namespace Railway.Gameplay
{
    public class WorkerSelectableObject : MonoBehaviour, ISelectableObject
    {
        [SerializeField] private ShopItem _item;

        private WorkersControlMode _controlMode;

        public IControlMode GetPlayerControlMode()
        {
            return _controlMode;
        }

        public void OnSelect()
        {
            
        }

        public void OnDeselect()
        {
            
        }
    }
}

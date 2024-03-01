using System;
using System.Collections;
using System.Collections.Generic;
using Railway.Gameplay;
using UnityEngine;

namespace Railway.Gameplay
{
    public class WorkersControlMode : MonoBehaviour, IControlMode
    {
        public event Action SelectionCanceled;

        public void HandleSelection(GameObject selectedObject)
        {
            
        }
    }
}

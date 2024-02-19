using System;
using UnityEngine;

namespace Railway.Gameplay
{
    public interface IControlMode
    {
        public event Action SelectionCanceled;

        public void HandleSelection(GameObject selectedObject);
    }
}

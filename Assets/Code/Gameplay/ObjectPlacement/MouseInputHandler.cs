using System;
using R3;
using UnityEngine;

namespace Code.Gameplay
{
    public class MouseInputHandler : MonoBehaviour
    {
        private readonly Subject<Vector2> mouseClickSubject = new Subject<Vector2>();

        public Observable<Vector2> OnMouseClick => mouseClickSubject;

        private void Update()
        {
            if (Input.GetMouseButtonDown(0))
            {
                mouseClickSubject.OnNext(Input.mousePosition);
            }
        }
    }
}
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.UI
{
    public class UISettingsController : MonoBehaviour
    {
        public UnityAction Closed;

        public void CloseScreen()
        {
            Closed.Invoke();
        }
    }
}
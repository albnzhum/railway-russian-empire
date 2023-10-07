using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace UI
{
    public class Screen : MonoBehaviour
    {
        public virtual void Show(bool state = true)
        {
            gameObject.SetActive(state);
        }
    }
}

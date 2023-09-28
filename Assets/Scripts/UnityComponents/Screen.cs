using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Screen : MonoBehaviour
{
    public virtual void Show(bool state = true)
    {
        gameObject.SetActive(state);
    }
}

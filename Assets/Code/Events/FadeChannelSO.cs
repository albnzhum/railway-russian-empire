using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Events
{
    [CreateAssetMenu(menuName = "Events/UI/Fade Channel")]
    public class FadeChannelSO : ScriptableObject
    {
        public UnityAction<bool, float, Color> OnEventRaised;

        public void FadeIn(float duration)
        {
            Fade(true, duration, Color.clear);
        }

        public void FadeOut(float duration)
        {
            Fade(false, duration, Color.black);
        }

        private void Fade(bool fadeIn, float duration, Color color)
        {
            if (OnEventRaised != null)
                OnEventRaised.Invoke(fadeIn, duration, color);
        }
    }
}
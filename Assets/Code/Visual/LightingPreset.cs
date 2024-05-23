using System;
using UnityEngine;

namespace Railway.Visual
{
    [Serializable]
    [CreateAssetMenu(fileName = "New Lighting Preset", menuName = "Visual/Lighting Preset")]
    public class LightingPreset : ScriptableObject
    {
        public Gradient AmbientColor;
        public Gradient DirectionalColor;
        public Gradient FogColor;
    }
}
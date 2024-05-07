using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Rendering.Universal;

namespace Settings
{
    [Serializable]
    public class ShadowDistanceTier
    {
        public float Distance;
        public string TierDescription;
    }

    public class UIGraphicsSettingsComponent : MonoBehaviour
    {
        [SerializeField] private List<ShadowDistanceTier> _shadowDistanceTiers = new List<ShadowDistanceTier>();
        [SerializeField] private UniversalRenderPipelineAsset _urpAsset = default;

        private int _savedResolutionIndex;
        private int _savedAntiAliasingIndex;
        private int _savedShadowDistanceTier;
        private bool _savedFullscreenState;

        private int _currentResolutionIndex;
        private List<Resolution> _resolutionsList;

        private int _currentAntiAliasingIndex;
        private List<string> _currentAntiAliasingList;

        private int _currentShadowDistanceTier;

        public event UnityAction<int, int, float, bool> Save = delegate(int arg0, int i, float f, bool arg3) { };

        private Resolution _currentResolution;
    }
}
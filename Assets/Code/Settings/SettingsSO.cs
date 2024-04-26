using UnityEngine;

namespace Settings
{
    [CreateAssetMenu(fileName = "Settings", menuName = "Settings")]
    public class SettingsSO : ScriptableObject
    {
        [SerializeField] private float _masterVolume = default;
        [SerializeField] private float _musicVolume = default;
        [SerializeField] private float _sfxVolume = default;
        [SerializeField] private int _resolutionIndex = default;
        [SerializeField] private int _antiAliasingIndex = default;
        [SerializeField] private float _shadowDistance = default;
        [SerializeField] private bool _isFullscreen = default;

        public float MasterVolume => _masterVolume;
        public float MusicVolume => _musicVolume;
        public float SfxVolume => _sfxVolume;
        public int ResolutionIndex => _resolutionIndex;
        public int AntiAliasingIndex => _antiAliasingIndex;
        public float ShadowDistance => _shadowDistance;
        public bool IsFullscreen => _isFullscreen;

        public void SaveAudioSettings(float newMusicVolume, float newSfxVolume, float newMasterVolume)
        {
            _masterVolume = newMasterVolume;
            _musicVolume = newMusicVolume;
            _sfxVolume = newSfxVolume;
        }

        public void SaveGraphicsSettings(int newResolutionIndex, int newAntiAliasingIndex, float newShadowDistance,
            bool isFullscreen)
        {
            _resolutionIndex = newResolutionIndex;
            _antiAliasingIndex = newAntiAliasingIndex;
            _shadowDistance = newShadowDistance;
            _isFullscreen = isFullscreen;
        }
    }
}
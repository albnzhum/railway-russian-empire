using System.Collections;
using System.Collections.Generic;
using Railway.Events;
using UnityEngine;
using UnityEngine.Events;

namespace Settings
{
    public class UIAudioSettingsComponent : MonoBehaviour
    {
        [SerializeField] private FloatEventChannelSO _masterVolumeEvent;
        [SerializeField] private FloatEventChannelSO _musicVolumeEvent;
        [SerializeField] private FloatEventChannelSO _sfxVolumeEvent;

        private float MusicVolume { get; set; }
        private float SfxVolume { get; set; }
        private float MasterVolume { get; set; }

        private float _savedMusicVolume { get; set; }
        private float _savedSfxVolume { get; set; }
        private float _savedMasterVolume { get; set; }

        private int maxVolume = 10;

        public UnityAction<float, float, float> Save = delegate(float music, float sfx, float master) { };

        private void SetMusicVolume()
        {
            _musicVolumeEvent.RaiseEvent(MusicVolume);
        }

        private void SetMasterVolume()
        {
            _masterVolumeEvent.RaiseEvent(MasterVolume);
        }

        private void SetSfxVolume()
        {
            _sfxVolumeEvent.RaiseEvent(SfxVolume);
        }

        private void SaveVolume()
        {
            _savedMusicVolume = MusicVolume;
            _savedMasterVolume = MasterVolume;
            _savedSfxVolume = SfxVolume;

            Save.Invoke(MusicVolume, SfxVolume, MasterVolume);
        }
    }
}
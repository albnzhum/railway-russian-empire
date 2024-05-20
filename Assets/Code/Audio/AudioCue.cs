using UnityEngine;

namespace Railway.Audio
{
    public class AudioCue : MonoBehaviour
    {
        [Header("Sound definition")]
        [SerializeField] private AudioCueSO _audioCue = default;
        [SerializeField] private bool _playOnStart = false;

        [Header("Configuration")]
        [SerializeField] private AudioCueEventChannelSO _audioCueEventChannel = default;
        [SerializeField] private AudioConfigurationSO _audioConfiguration = default;
    }
}
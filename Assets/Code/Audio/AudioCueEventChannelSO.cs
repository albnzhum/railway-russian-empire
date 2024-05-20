using UnityEngine;

namespace Railway.Audio
{
    [CreateAssetMenu(fileName = "New Audio Cue Event", menuName = "Events/Audio Cue Event")]
    public class AudioCueEventChannelSO : ScriptableObject
    {
        public AudioCuePlayAction OnAudioCuePlayRequested;
        public AudioCueStopAction OnAudioCueStopRequested;
        public AudioCueFinishedAction OnAudioCueFinishedRequested;
    }

    public delegate AudioCueKey AudioCuePlayAction(AudioCueSO audio, AudioConfigurationSO audioConfiguration,
        Vector3 positionInSpace);

    public delegate bool AudioCueStopAction(AudioCueKey emitterKey);

    public delegate bool AudioCueFinishedAction(AudioCueKey emitterKey);
}
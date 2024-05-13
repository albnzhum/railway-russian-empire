using System;
using UnityEngine;

namespace Railway.Audio
{
    [CreateAssetMenu(fileName = "New Audio Cue", menuName = "Audio/Audio Cue")]
    public class AudioCueSO : ScriptableObject
    {
        public bool looping = false;
        [SerializeField] private AudioClipsGroup[] _audioClipsGroups;

        public AudioClip[] GetClips()
        {
            int numberOfClips = _audioClipsGroups.Length;
            AudioClip[] resultingClips = new AudioClip[numberOfClips];

            for (int i = 0; i < numberOfClips; i++)
            {
                resultingClips[i] = _audioClipsGroups[i].GetNextClip();
            }

            return resultingClips;
        }
    }

    [Serializable]
    public class AudioClipsGroup
    {
        public SequenceMode SequenceMode = Audio.SequenceMode.RandomNoImmediateRepeat;
        public AudioClip[] audioClips;
        
        private int _nextClipToPlay = -1;
        private int _lastClipPlayed = -1;

        public AudioClip GetNextClip()
        {
            if (audioClips.Length == 1)
            {
                return audioClips[0];
            }

            if (_nextClipToPlay == -1)
            {
                _nextClipToPlay = (SequenceMode == SequenceMode.Sequential)
                    ? 0
                    : UnityEngine.Random.Range(0, audioClips.Length);
            }
            else
            {
                switch (SequenceMode)
                {
                    case SequenceMode.Random:
                        _nextClipToPlay = UnityEngine.Random.Range(0, audioClips.Length);
                        break;
                    case SequenceMode.RandomNoImmediateRepeat:
                        do
                        {
                            _nextClipToPlay = UnityEngine.Random.Range(0, audioClips.Length);
                        } while (_nextClipToPlay == _lastClipPlayed);
                        break;
                    case SequenceMode.Sequential:
                        _nextClipToPlay = (int)Mathf.Repeat(++_nextClipToPlay, audioClips.Length);
                        break;
                }
            }

            _lastClipPlayed = _nextClipToPlay;
            return audioClips[_nextClipToPlay];
        }
    }

    public enum SequenceMode
    {
        Random,
        RandomNoImmediateRepeat,
        Sequential,
    }
}
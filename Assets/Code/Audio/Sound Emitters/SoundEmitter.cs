using System.Collections;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Audio
{
    [RequireComponent(typeof(AudioSource))]
    public class SoundEmitter : MonoBehaviour
    {
        private AudioSource _audioSource;

        public event UnityAction<SoundEmitter> OnSoundFinishedPlaying;

        private void Awake()
        {
            _audioSource = this.GetComponent<AudioSource>();
            _audioSource.playOnAwake = false;
        }

        public void PlayAudioClip(AudioClip clip, AudioConfigurationSO settings, bool hasToLoop, Vector3 position)
        {
            _audioSource.clip = clip;
            settings.ApplyTo(_audioSource);
            _audioSource.transform.position = position;
            _audioSource.loop = hasToLoop;
            _audioSource.time = 0f;
            _audioSource.Play();

            if (!hasToLoop)
            {
                StartCoroutine(FinishedPlaying(clip.length));
            }
        }

        public void Stop()
        {
            _audioSource.Stop();
        }

        public void Finish()
        {
            if (_audioSource.loop)
            {
                _audioSource.loop = false;
                float timeRemaining = _audioSource.clip.length - _audioSource.time;
                StartCoroutine(FinishedPlaying(timeRemaining));
            }
        }

        public bool IsPlaying()
        {
            return _audioSource.isPlaying;
        }

        public bool IsLooping()
        {
            return _audioSource.loop;
        }

        private IEnumerator FinishedPlaying(float clipLength)
        {
            yield return new WaitForSeconds(clipLength);
            
            NotifyBeingDone();
        }

        private void NotifyBeingDone()
        {
            OnSoundFinishedPlaying.Invoke(this);
        }
    }
}
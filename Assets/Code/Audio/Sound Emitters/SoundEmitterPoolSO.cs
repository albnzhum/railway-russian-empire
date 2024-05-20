using Railway.Factory;
using UnityEngine;

namespace Railway.Audio
{
    [CreateAssetMenu(fileName = "NewSoundEmitterPool", menuName = "Pool/SoundEmitter Pool")]
    public class SoundEmitterPoolSO : ComponentPoolSO<SoundEmitter>
    {
        [SerializeField] private SoundEmitterFactorySO _factory;

        public override IFactory<SoundEmitter> Factory
        {
            get => _factory;
            set
            {
                _factory = value as SoundEmitterFactorySO;
            }
        }
    }
}
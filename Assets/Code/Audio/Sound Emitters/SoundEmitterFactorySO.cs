using Code.Factory;
using UnityEngine;

namespace Railway.Audio
{
    [CreateAssetMenu]
    public class SoundEmitterFactorySO : FactorySO<SoundEmitter>
    {
        public SoundEmitter prefab = default;
        
        public override SoundEmitter Create()
        {
            return Instantiate(prefab);
        }
    }
}
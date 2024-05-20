using System;

namespace Railway.Audio
{
    public struct AudioCueKey
    {
        public static AudioCueKey Invalid = new AudioCueKey(-1, null);

        internal int Value;
        internal AudioCueSO AudioCueSo;

        internal AudioCueKey(int value, AudioCueSO audioCueSo)
        {
            Value = value;
            AudioCueSo = audioCueSo;
        }
        
        public override bool Equals(Object obj)
        {
            return obj is AudioCueKey x && Value == x.Value && AudioCueSo == x.AudioCueSo;
        }
        public override int GetHashCode()
        {
            return Value.GetHashCode() ^ AudioCueSo.GetHashCode();
        }
        public static bool operator ==(AudioCueKey x, AudioCueKey y)
        {
            return x.Value == y.Value && x.AudioCueSo == y.AudioCueSo;
        }
        public static bool operator !=(AudioCueKey x, AudioCueKey y)
        {
            return !(x == y);
        }
    }
}
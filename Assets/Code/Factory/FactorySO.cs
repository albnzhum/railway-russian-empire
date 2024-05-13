using Railway.Factory;
using UnityEngine;

namespace Code.Factory
{
    public abstract class FactorySO<T> : ScriptableObject, IFactory<T>
    {
        public abstract T Create();
    }
}
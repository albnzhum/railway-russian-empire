﻿namespace JimboA.Plugins
{
    [System.Serializable]
    public struct MonoLink<TComponent> where TComponent : UnityEngine.Component
    {
        public TComponent Value;
    }
}
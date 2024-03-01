using System;

namespace Railway.Shop.Data
{
    [Serializable]
    public enum Country
    {
        Russia,
        England,
        France
    }

    [Serializable]
    public enum Factory
    {
        SomeFactory1,
        SomeFactory2
    }

    [Serializable]
    public enum TechnicalState
    {
        New,
        Excellent,
        Good,
        Medium,
        Used,
        Old,
        Critical,
        Faulty
    }
}
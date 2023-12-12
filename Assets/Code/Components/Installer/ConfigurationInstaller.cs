using System;
using UnityEngine;
using Zenject;
using Components;

[CreateAssetMenu(fileName = "ConfigurationInstaller", menuName = "Installers/ConfigurationInstaller")]
public class ConfigurationInstaller : ScriptableObjectInstaller<ConfigurationInstaller>
{
    public Configuration Config;

    public override void InstallBindings()
    {
        Container.Bind<Configuration>().AsSingle();
        /*Container.BindInstance(Config.City).AsCached();
        Container.BindInstance(Config.LevelDifficulty).AsSingle();*/
    }
}

[Serializable]
public class Configuration
{
    public CityComponent City;
    public LevelDifficulty LevelDifficulty;
}

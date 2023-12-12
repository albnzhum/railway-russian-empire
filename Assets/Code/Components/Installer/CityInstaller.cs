using Components;
using UnityEngine;
using Zenject;

[CreateAssetMenu(fileName = "CityInstaller", menuName = "Installers/CityInstaller")]
public class CityInstaller : ScriptableObjectInstaller<CityInstaller>
{
    public CityComponent City;
    public override void InstallBindings()
    {
        Container.Bind<CityComponent>().AsCached();
    }
}

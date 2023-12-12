using UnityEngine;
using Zenject;
using Resources = Components.Resources;

[CreateAssetMenu(fileName = "ResourcesInstaller", menuName = "Installers/ResourcesInstaller")]
public class ResourcesInstaller : ScriptableObjectInstaller<ResourcesInstaller>
{
    public Resources Resources;

    public override void InstallBindings()
    {
        Container.Bind<Resources>().AsSingle();
    }
}

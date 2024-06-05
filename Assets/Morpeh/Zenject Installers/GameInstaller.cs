using Railway.Components;
using Railway.Gameplay;
using Railway.Input;
using UnityEngine;
using Zenject;

namespace Railway.Morpeh
{
    [CreateAssetMenu(fileName = "GameInstaller", menuName = "Installers/GameInstaller")]

    public class GameInstaller : ScriptableObjectInstaller<GameInstaller>
    {
        [SerializeField] private MissionInitializer _missionInitializer;
        [SerializeField] private InputReader _inputReader;
        [SerializeField] private GameStateSO _gameState;

        public override void InstallBindings()
        {
            Container.Bind<GameInstaller>().FromInstance(this).AsSingle().IfNotBound();
            Container.Bind<MissionInitializer>().FromInstance(_missionInitializer).AsSingle();
            Container.Bind<InputReader>().FromInstance(_inputReader).AsCached().IfNotBound();
            Container.Bind<GameStateSO>().FromInstance(_gameState).AsSingle();
        }
    }
}
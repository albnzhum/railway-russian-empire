using System.Runtime.CompilerServices;
using Leopotam.EcsLite;
using Leopotam.EcsLite.Di;

namespace UI
{
    public class MainMenuInitSystem : IEcsInitSystem
    {
        private EcsCustomInject<ScreenStorage> _screens = default;
        private EcsCustomInject<EcsUGuiMediator> _mediator = default;

        public void Init(IEcsSystems systems)
        {
            var world = systems.GetWorld();
            var mediator = _mediator.Value;
            var mainMenuScreen = mediator.MainMenuScreen;
            var screens = _screens.Value;

            screens.Add(world, mainMenuScreen);
            screens.Add(world, mediator.SettingsScreen);

            ShowMainMenu(world, screens);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void ShowMainMenu(EcsWorld world, ScreenStorage screens)
        {
            world.ShowScreen<MainMenuScreen>();
        }
    }
}

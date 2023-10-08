using Leopotam.EcsLite;
using Leopotam.EcsLite.Di;

namespace UI
{
    public sealed class HideScreenSystem
    {
        private EcsFilterInject<Inc<HideScreenRequest>> _onHideRequest;
        private EcsCustomInject<ScreenStorage> _screens;
        
        public void Run (IEcsSystems systems) 
        {
            foreach (var _ in _onHideRequest.Value)
            {
                var world = systems.GetWorld();
                var screenStack = _screens.Value.ActiveScreens;
                if (screenStack.Count > 0)
                {
                    var activeScreen = screenStack.Pop();
                    if(activeScreen != null)
                        activeScreen.Hide(world);
                }
                if (screenStack.Count > 0)
                {
                    var nextScreen = screenStack.Peek();
                    if(nextScreen != null)
                        nextScreen.Activate(world);
                }
            }
        }
    }
}

namespace Railway.Gameplay
{
    public interface ISelectableObject
    {
        public IControlMode GetPlayerControlMode();
        public void OnSelect();

        public void OnDeselect();
    }
}

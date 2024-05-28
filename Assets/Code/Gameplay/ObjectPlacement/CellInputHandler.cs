using R3;
using Railway.Input;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Gameplay
{
    public class CellInputHandler : MonoBehaviour
    {
        [SerializeField] private InputReader _inputReader;
        
        public UnityAction OnStopItemPlacing;

        public Observable<Vector2> OnChooseItemPositionStream => Observable.FromEvent<Vector2>(
            handler => _inputReader.PlaceItemEvent += handler,
            handler => _inputReader.PlaceItemEvent -= handler);

        public Observable<Vector2> OnPlaceItemStream => Observable.FromEvent<Vector2>(
                handler => _inputReader.PlaceItemEvent += handler,
                handler => _inputReader.PlaceItemEvent -= handler)
            .Where(_ => UnityEngine.Input.GetMouseButtonDown(0));

        private void OnEnable()
        {
            _inputReader.OnCancelEvent += StopPlacing;
        }

        private void StopPlacing()
        {
            OnStopItemPlacing.Invoke();
            
            _inputReader.EnableGameplayInput();
        }
    }
}
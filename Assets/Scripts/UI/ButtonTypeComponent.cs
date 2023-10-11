using Observers;
using UnityEngine;
using UnityEngine.EventSystems;

namespace UI
{
    public interface IButtonAction
    {
        void OnButtonClickHandler(PointerEventData eventData);
    }

    /// <summary>
    /// Component that defines a button action and handles its click event
    /// </summary>
    public class ButtonTypeComponent : MonoBehaviour, IButtonAction
    {
        [SerializeField] protected PointerObserver pointerObserver;
        protected void OnEnable()
        {
            pointerObserver.PointerClicked += OnButtonClickHandler;
        }

        protected void OnDisable()
        {
            pointerObserver.PointerClicked -= OnButtonClickHandler;
        }

        public virtual void OnButtonClickHandler(PointerEventData eventData) { }
    }
}
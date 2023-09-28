using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Observers
{
    public class PointerObserver : MonoBehaviour, IPointerClickHandler, IPointerEnterHandler, IPointerExitHandler
    {
        public event Action<PointerEventData> PointerClicked;
        public event Action<PointerEventData> PointerEntered;
        public event Action<PointerEventData> PointerExited;

        public void OnPointerClick(PointerEventData eventData) => PointerClicked?.Invoke(eventData);

        public void OnPointerEnter(PointerEventData eventData) => PointerEntered?.Invoke(eventData);

        public void OnPointerExit(PointerEventData eventData) => PointerExited?.Invoke(eventData);



    }
}

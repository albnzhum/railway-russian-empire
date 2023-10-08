using UnityEngine;
using UnityEngine.EventSystems;

namespace UI
{
    public class QuitButton : ButtonTypeComponent
    {
        public override void OnButtonClickHandler(PointerEventData eventData) => Application.Quit();
    }
}
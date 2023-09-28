using UnityEngine;
using UnityEngine.EventSystems;

namespace UI.Button.Menu
{
    public class QuitButton : ButtonTypeComponent
    {
        public override void OnButtonClickHandler(PointerEventData eventData) => Application.Quit();
    }
}
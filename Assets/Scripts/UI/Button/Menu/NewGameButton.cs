using UnityEngine.Device;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

namespace UI
{
    public class NewGameButton : ButtonTypeComponent
    {
        public override void OnButtonClickHandler(PointerEventData eventData) => SceneManager.LoadScene("LoadScreen");
    }
}

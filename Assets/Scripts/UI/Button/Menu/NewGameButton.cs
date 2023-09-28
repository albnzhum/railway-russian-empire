using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

namespace UI.Button.Menu
{
    public class NewGameButton : ButtonTypeComponent
    {
        public override void OnButtonClickHandler(PointerEventData eventData)
        {
            SceneManager.LoadScene("LoadScreen");
        }
    }
}

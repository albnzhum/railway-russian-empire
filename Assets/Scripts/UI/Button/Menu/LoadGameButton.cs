using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

namespace UI
{
    public class LoadGameButton : ButtonTypeComponent
    {
        public override void OnButtonClickHandler(PointerEventData eventData) => SceneManager.LoadScene("LoadScreen");
    }
}
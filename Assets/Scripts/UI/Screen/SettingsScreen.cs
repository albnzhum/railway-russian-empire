using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace UI
{
    public class SettingsScreen : View
    {
        public override void Initialize()
        {
            
        }

        private void Update()
        {
            if (Input.GetKeyDown(KeyCode.Escape))
            {
                ViewManager.Show<MainMenuScreen>();
            }
        }
    }
}

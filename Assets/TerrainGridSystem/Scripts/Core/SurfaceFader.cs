using UnityEngine;
using System.Collections;

namespace TGS
{
    public enum FADER_STYLE
    {
        FadeOut = 0,
        Blink = 1,
        Flash = 2,
        ColorTemp = 3
    }

    public class SurfaceFader : MonoBehaviour
    {
        Material FadeMaterial;
        float StartTime, Duration;
        TerrainGridSystem Grid;
        Color Color, InitialColor;
        Region Region;
        Renderer Renderer;
        FADER_STYLE Style;

        public static void Animate(FADER_STYLE style, TerrainGridSystem grid, GameObject surface, Region region,
            Material fadeMaterial, Color color, float duration)
        {
            SurfaceFader fader = surface.GetComponent<SurfaceFader>();
            if (fader != null)
            {
                fader.Finish();
                DestroyImmediate(fader);
            }

            fader = surface.AddComponent<SurfaceFader>();
            fader.Grid = grid;
            fader.StartTime = Time.time;
            fader.Duration = duration + 0.0001f;
            fader.Color = color;
            fader.Region = region;
            fader.FadeMaterial = fadeMaterial;
            fader.Style = style;
            fader.InitialColor = fadeMaterial.color;
        }

        void Start()
        {
            Renderer = GetComponent<Renderer>();
            Renderer.sharedMaterial = FadeMaterial;
        }

        void Update()
        {
            float elapsed = Time.time - StartTime;
            switch (Style)
            {
                case FADER_STYLE.FadeOut:
                    UpdateFadeOut(elapsed);
                    break;
                case FADER_STYLE.Blink:
                    UpdateBlink(elapsed);
                    break;
                case FADER_STYLE.Flash:
                    UpdateFlash(elapsed);
                    break;
                case FADER_STYLE.ColorTemp:
                    UpdateColorTemp(elapsed);
                    break;
            }
        }

        #region Fade Out effect

        public void Finish()
        {
            StartTime = float.MinValue;
            Update();
        }

        void UpdateFadeOut(float elapsed)
        {
            float newAlpha = Mathf.Clamp01(1.0f - elapsed / Duration);
            SetAlpha(newAlpha);
            if (elapsed >= Duration)
            {
                SetAlpha(0);
                Region.customMaterial = null;
                DestroyImmediate(this);
            }
        }

        void SetAlpha(float newAlpha)
        {
            if (Grid.HighlightedObj == gameObject || Renderer == null)
                return;
            Color newColor = new Color(Color.r, Color.g, Color.b, newAlpha);
            FadeMaterial.color = newColor;
            if (Renderer.sharedMaterial != FadeMaterial)
            {
                FadeMaterial.mainTexture = Renderer.sharedMaterial.mainTexture;
                Renderer.sharedMaterial = FadeMaterial;
            }
        }

        #endregion

        #region Flash effect

        void UpdateFlash(float elapsed)
        {
            SetFlashColor(elapsed / Duration);
            if (elapsed >= Duration)
            {
                SetFlashColor(1f);
                if (Region.customMaterial != null && Renderer != null)
                    Renderer.sharedMaterial = Region.customMaterial;
                DestroyImmediate(this);
            }
        }


        void SetFlashColor(float t)
        {
            if (Renderer == null)
                return;
            Color newColor = Color.Lerp(Color, InitialColor, t);
            FadeMaterial.color = newColor;
            if (Renderer.sharedMaterial != FadeMaterial)
            {
                FadeMaterial.mainTexture = Renderer.sharedMaterial.mainTexture;
                Renderer.sharedMaterial = FadeMaterial;
            }
        }

        #endregion

        #region Blink effect

        void UpdateBlink(float elapsed)
        {
            SetBlinkColor(elapsed / Duration);
            if (elapsed >= Duration)
            {
                SetBlinkColor(0);
                if (Region.customMaterial != null && Renderer != null)
                    Renderer.sharedMaterial = Region.customMaterial;
                DestroyImmediate(this);
            }
        }

        void SetBlinkColor(float t)
        {
            if (Renderer == null)
                return;
            Color newColor;
            if (t < 0.5f)
            {
                newColor = Color.Lerp(InitialColor, Color, t * 2f);
            }
            else
            {
                newColor = Color.Lerp(Color, InitialColor, (t - 0.5f) * 2f);
            }

            FadeMaterial.color = newColor;
            if (Renderer.sharedMaterial != FadeMaterial)
            {
                FadeMaterial.mainTexture = Renderer.sharedMaterial.mainTexture;
                Renderer.sharedMaterial = FadeMaterial;
            }
        }

        #endregion

        #region Color Temp effect

        void UpdateColorTemp(float elapsed)
        {
            SetColorTemp(1);
            if (elapsed >= Duration)
            {
                SetColorTemp(0);
                if (Region.customMaterial != null && Renderer != null)
                    Renderer.sharedMaterial = Region.customMaterial;
                DestroyImmediate(this);
            }
        }


        void SetColorTemp(float t)
        {
            if (Renderer == null)
                return;
            FadeMaterial.color = t == 0 ? InitialColor : Color;
            if (Renderer.sharedMaterial != FadeMaterial)
            {
                FadeMaterial.mainTexture = Renderer.sharedMaterial.mainTexture;
                Renderer.sharedMaterial = FadeMaterial;
            }
        }

        #endregion
    }
}

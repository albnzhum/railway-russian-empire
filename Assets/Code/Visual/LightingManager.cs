using System;
using UnityEngine;

namespace Railway.Visual
{
    [ExecuteAlways]
    public class LightingManager : MonoBehaviour
    {
        [SerializeField] private Light _directionalLight;
        [SerializeField] private LightingPreset _preset;

        [SerializeField, Range(0, 24)] private float _timeOfDay;

        private float time;

        private void OnValidate()
        {
            if (_directionalLight != null) return;

            if (RenderSettings.sun != null)
            {
                _directionalLight = RenderSettings.sun;
            }
            else
            {
                Light[] lights = GameObject.FindObjectsOfType<Light>();

                foreach (var light in lights)
                {
                    if (light.type == LightType.Directional)
                    {
                        _directionalLight = light;
                        return;
                    }
                }
            }
        }

        private void Update()
        {
            if (_preset == null) return;

            if (Application.isPlaying)
            {
                _timeOfDay += Time.deltaTime / 3f;
                _timeOfDay %= 24;

                time = _timeOfDay / 24f;

                UpdateLighting(time);
            }
            else
            {
                time = _timeOfDay / 24f;
                UpdateLighting(time);
            }
        }

        private void UpdateLighting(float timePercent)
        {
            RenderSettings.ambientLight = _preset.AmbientColor.Evaluate(timePercent);
            RenderSettings.fogColor = _preset.FogColor.Evaluate(timePercent);
                
            if (_directionalLight != null)
            {
                _directionalLight.color = _preset.DirectionalColor.Evaluate(timePercent);

                float angle = Mathf.Sin(timePercent * Mathf.PI) * 90f;
                
                Vector3 rotation = new Vector3(angle, (timePercent * 20f) - 20f,
                    _directionalLight.transform.localRotation.z);
                _directionalLight.transform.localRotation = Quaternion.Euler(rotation);
            }
        }
    }
}
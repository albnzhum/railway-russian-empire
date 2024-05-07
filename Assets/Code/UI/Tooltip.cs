using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class Tooltip : MonoBehaviour
{
    [SerializeField] private TMP_Text _tooltipText;
    [SerializeField] private RectTransform backgroundRectTransform;

    private static Tooltip Instance;

    private void Awake()
    {
        Instance = this;
        HideTooltip();
    }

    private void ShowTooltip(string tooltipString, Vector2 mousePosition)
    {
        gameObject.SetActive(true);

        _tooltipText.text = tooltipString;
        float textPaddingSize = 4f;
        Vector2 backgroundSize = new Vector2
            (_tooltipText.preferredWidth + textPaddingSize * 2f, _tooltipText.preferredHeight + textPaddingSize * 2f);
        backgroundRectTransform.sizeDelta = backgroundSize;

        transform.position = mousePosition;
    }

    public static void ShowTooltip_Static(string tooltipString, Vector2 mousePosition)
    {
        Instance.ShowTooltip(tooltipString, mousePosition);
    }

    public static void HideTooltip_Static()
    {
        Instance.HideTooltip();
    }

    private void HideTooltip()
    {
        gameObject.SetActive(false);
    }
}
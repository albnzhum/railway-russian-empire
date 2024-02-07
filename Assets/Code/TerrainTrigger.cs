using System;
using Railway.Input;
using TGS;
using UnityEngine;

public class TerrainTrigger : MonoBehaviour
{
    public InputReader _inputReader;

    private TerrainGridSystem[] _tgs;
    private RaycastHit[] hits;

    private void OnEnable()
    {
        hits = new RaycastHit[20];

        _inputReader.ChooseCellEvent += ChooseCell;
    }

    private void OnDisable()
    {
        _inputReader.ChooseCellEvent -= ChooseCell;
    }

    private void Start()
    {
        if (GetComponent<TerrainCollider>() == null)
        {
            gameObject.AddComponent<TerrainCollider>();
        }

        _tgs = transform.GetComponentsInChildren<TerrainGridSystem>();
        if (_tgs == null || _tgs.Length == 0)
        {
            Debug.LogError("Missing Terrain Highlight System reference in Terrain Trigger script");
            DestroyImmediate(this);
        }
    }

    private void ChooseCell(Vector2 mousePosition)
    {
        Ray ray = Camera.main.ScreenPointToRay(mousePosition);
        
        int hitCount = Physics.RaycastNonAlloc(Camera.main.transform.position, ray.direction, hits);
        if (hitCount > 0) {
            for (int k = 0; k < hitCount; k++) {
                if (_tgs[0] == null || hits[k].collider.gameObject == this._tgs[0].Terrain.gameObject)
                    return; 
            }
        }
        
        for (int k = 0; k < _tgs.Length; k++) {
            if (_tgs[k] != null) {
                _tgs[k].mouseIsOver = false;
            }
        }
        
        Debug.Log("Cell chosen");
    }
}

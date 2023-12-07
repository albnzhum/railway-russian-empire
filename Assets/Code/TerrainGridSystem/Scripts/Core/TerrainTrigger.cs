using UnityEngine;
using System.Collections;

namespace TGS {
	public class TerrainTrigger : MonoBehaviour {

		// Use this for initialization
		TerrainGridSystem[] _ths;
		RaycastHit[] _hits;

		void OnEnable() {
			_hits = new RaycastHit[20];
		}

		void Start() {
			if (GetComponent<TerrainCollider>() == null) {
				gameObject.AddComponent<TerrainCollider>();
			}
			_ths = transform.GetComponentsInChildren<TerrainGridSystem>();
			if (_ths == null || _ths.Length == 0) {
				Debug.LogError("Missing Terrain Highlight System reference in Terrain Trigger script.");
				DestroyImmediate(this);
			}
		}

		void OnMouseEnter() {
			for (int k = 0; k < _ths.Length; k++) {
				if (_ths[k] != null) {
					_ths[k].mouseIsOver = true;
				}
			}
		}

		void OnMouseExit() {
			// Make sure it's outside of grid
			Vector3 mousePos = Input.mousePosition;
			Ray ray = Camera.main.ScreenPointToRay(mousePos);
			int hitCount = Physics.RaycastNonAlloc(Camera.main.transform.position, ray.direction, _hits);
			if (hitCount > 0) {
				for (int k = 0; k < hitCount; k++) {
					if (_ths[0] == null || _hits[k].collider.gameObject == this._ths[0].Terrain.gameObject)
						return; 
				}
			}
			for (int k = 0; k < _ths.Length; k++) {
				if (_ths[k] != null) {
					_ths[k].mouseIsOver = false;
				}
			}
		}

	}

}
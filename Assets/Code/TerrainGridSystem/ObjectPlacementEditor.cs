
using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace TGS
{
    [CustomEditor(typeof(ObjectPlacement))]
    public class ObjectPlacementEditor : Editor
    {
        private ObjectPlacement _objectPlacement;

        private void OnEnable()
        {
            _objectPlacement = (ObjectPlacement)target;
        }

        /*private void OnSceneGUI()
        {
            if (_objectPlacement.TerrainGridSystem == null)
            {
                return;
            }

            GameObject obj = Selection.activeGameObject;
            Debug.Log(obj.name);

            Event currentEvent = Event.current;
            Ray ray = HandleUtility.GUIPointToWorldRay(obj.transform.position);
            
            RaycastHit hit;
            if (Physics.Raycast(obj.transform.position, Vector3.down, out hit, Mathf.Infinity))
            {
                currentEvent.Use();
                // Вызываем метод для перемещения объектов к точке попадания луча
                _objectPlacement.MoveSelectedObjects(hit.point, obj);
            }
        }*/
    }
}
using System;
using UnityEngine;
using UnityEngine.Events;

namespace Railway.Gameplay
{
    public class DragAndDropItem : MonoBehaviour
    {
        private bool isDragging;
        
        private GameObject _currentItem;
        
        private MouseInputSystem _mouseInputSystem;

        public static event UnityAction<GameObject, bool> OnDragEvent;
        public static DragAndDropItem Instance { get; set; }

        private void Awake()
        {
            Instance = this;
        }

        private void OnEnable()
        {
            _mouseInputSystem = MouseInputSystem.Instance;
            OnDragEvent += StartDragging;
        }

        private void OnDisable()
        {
            OnDragEvent -= StartDragging;
        }

        private void Update()
        {
            if (isDragging)
            {
                _currentItem.transform.position = _mouseInputSystem.CellGetPosition();
            }
        }

        public void StartDragging(GameObject _itemToDrag, bool _isDragging)
        {
            _currentItem = _itemToDrag;
            isDragging = _isDragging;

            if (!_isDragging)
            {
                _currentItem = null;
            }
        }

        public static void RaiseEvent(GameObject _itemToDrag, bool _isDragging)
        {
            OnDragEvent.Invoke(_itemToDrag, _isDragging);
        }
    }
}

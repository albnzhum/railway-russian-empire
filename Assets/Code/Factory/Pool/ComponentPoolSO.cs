using UnityEngine;

namespace Railway.Factory
{
    public abstract class ComponentPoolSO<T> : PoolSO<T> where T : Component
    {
        private Transform _poolRoot;

        private Transform PoolRoot
        {
            get
            {
                if (_poolRoot == null)
                {
                    _poolRoot = new GameObject(name).transform;
                    _poolRoot.SetParent(_parent);
                }

                return _poolRoot;
            }
        }

        private Transform _parent;

        public void SetParent(Transform t)
        {
            _parent = t;
            PoolRoot.SetParent(_parent);
        }

        public override T Request()
        {
            T member = base.Request();
            member.gameObject.SetActive(true);
            return member;
        }

        public override void Return(T member)
        {
            member.transform.SetParent(PoolRoot.transform);
            member.gameObject.SetActive(false);

            base.Return(member);
        }

        protected override T Create()
        {
            T newMember = base.Create();
            newMember.transform.SetParent(PoolRoot.transform);
            newMember.gameObject.SetActive(false);
            return newMember;
        }

        public override void OnDisable()
        {
            base.OnDisable();
            if (_poolRoot != null)
            {
#if UNITY_EDITOR

                DestroyImmediate(_poolRoot.gameObject);
#else
                Destroy(_poolRoot.gameobject);
#endif
            }
        }
    }
}
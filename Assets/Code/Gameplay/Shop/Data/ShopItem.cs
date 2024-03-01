using UnityEngine;

namespace Railway.Shop.Data
{
    /// <summary>
    /// Object for storage shop's item data
    /// </summary>
    public class ShopItem : ScriptableObject
    {
        [SerializeField] private string _name;
        [SerializeField] private float _price;
        [SerializeField] private GameObject _prefab;
        [SerializeField] private ItemTypeSO _itemType;
        [SerializeField] private int _amount;
        
        public string Name => _name;
        public float Price => _price;
        public GameObject Prefab => _prefab;
        public ItemTypeSO ItemType => _itemType;
        public int Amount => _amount;

    }
}

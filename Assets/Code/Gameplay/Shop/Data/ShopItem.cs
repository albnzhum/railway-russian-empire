using UnityEngine;
using UnityEngine.Serialization;

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
        [FormerlySerializedAs("_itemType")] [SerializeField] private ItemTypeSO tabType;
        [SerializeField] private int _amount;
        [SerializeField] private Sprite _sprite;
        
        public string Name => _name;
        public float Price => _price;
        public GameObject Prefab => _prefab;
        public ItemTypeSO TabType => tabType;
        public int Amount => _amount;
        public Sprite Sprite => _sprite;

    }
}

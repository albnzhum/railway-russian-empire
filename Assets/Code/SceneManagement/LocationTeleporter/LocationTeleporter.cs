using Railway.Events;
using UnityEngine;

namespace Railway.SceneManagement
{
    public class LocationTeleporter : MonoBehaviour
    {
        [Header("Broadcast on")] 
        [SerializeField] private LoadEventChannelSO _loadLocationRequest;
        [SerializeField] private VoidEventChannelSO _onSceneReady;
        
        public LocationTeleporterInfo locationTeleporterInfo;
        public LevelDifficultyInitializer levelDifficulty;

        private LocationSO _lastLocationTeleportedTo = default;

        public void Teleport(LocationSO where)
        {
            if (where == _lastLocationTeleportedTo) return;
            
            _lastLocationTeleportedTo = where;
            _loadLocationRequest.RaiseEvent(where);
            _onSceneReady.RaiseEvent();
        }
    }
}
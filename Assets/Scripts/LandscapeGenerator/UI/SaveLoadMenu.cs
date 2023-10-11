using System.IO;
using UnityEngine;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    public class SaveLoadMenu : MonoBehaviour
    {
        public Text menuLabel, actionButtonLabel;
        public InputField nameInput;
        public HexGrid hexGrid;

        public void Open () {
            gameObject.SetActive(true);
            HexMapCamera.Locked = true;
        }

        public void Close () {
            gameObject.SetActive(false);
            HexMapCamera.Locked = false;
        }
        
        public void Action () {
            string path = GetSelectedPath();
            if (path == null) {
                return;
            }
            if (saveMode) {
                Save(path);
            }
            else {
                Load(path);
            }
            Close();
        }
        
        bool saveMode;
        
        public void SelectItem (string name) {
            nameInput.text = name;
        }

        public void Open (bool saveMode) {
            this.saveMode = saveMode;
            if (saveMode) {
                menuLabel.text = "Save Map";
                actionButtonLabel.text = "Save";
            }
            else {
                menuLabel.text = "Load Map";
                actionButtonLabel.text = "Load";
            }
            gameObject.SetActive(true);
            HexMapCamera.Locked = true;
        }
        
        string GetSelectedPath () {
            string mapName = nameInput.text;
            if (mapName.Length == 0) {
                return null;
            }
            return Path.Combine(Application.persistentDataPath, mapName + ".map");
        }
        
        public void Save(string path)
        {
            using (
                BinaryWriter writer =
                new BinaryWriter(File.Open(path, FileMode.Create))
            ) {
                writer.Write(1);
                hexGrid.Save(writer);
            }
        }

        public void Load(string path) {
            if (!File.Exists(path)) {
                Debug.LogError("File does not exist " + path);
                return;
            }
            using (BinaryReader reader = new BinaryReader(File.OpenRead(path))) {
                int header = reader.ReadInt32();
                if (header <= 1) {
                    hexGrid.Load(reader, header);
                    HexMapCamera.ValidatePosition();
                }
                else {
                    Debug.LogWarning("Unknown map format " + header);
                }
            }
        }
    }
}

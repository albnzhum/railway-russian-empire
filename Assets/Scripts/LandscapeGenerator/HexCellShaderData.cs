using UnityEngine;

namespace LandscapeGenerator
{
    public class HexCellShaderData : MonoBehaviour
    {
        Texture2D CellTexture;
        Color32[] CellTextureData;

        public void Initialize (int x, int z) {
            if (CellTexture) {
                CellTexture.Reinitialize(x, z);
            }
            else {
                CellTexture = new Texture2D(
                    x, z, TextureFormat.RGBA32, false, true
                )
                {
                    filterMode = FilterMode.Point,
                    wrapMode = TextureWrapMode.Clamp
                };
                Shader.SetGlobalTexture("_HexCellData", CellTexture);
            }
            Shader.SetGlobalVector(
                "_HexCellData_TexelSize",
                new Vector4(1f / x, 1f / z, x, z)
            );

            if (CellTextureData == null || CellTextureData.Length != x * z) {
                CellTextureData = new Color32[x * z];
            }
            else {
                for (var i = 0; i < CellTextureData.Length; i++) {
                    CellTextureData[i] = new Color32(0, 0, 0, 0);
                }
            }
            enabled = true;
        }

        public void RefreshTerrain (HexCell cell) {
            CellTextureData[cell.Index].a = (byte)cell.TerrainTypeIndex;
            enabled = true;
        }


        void LateUpdate () {
            CellTexture.SetPixels32(CellTextureData);
            CellTexture.Apply();
            enabled = false;
        }
    }
}

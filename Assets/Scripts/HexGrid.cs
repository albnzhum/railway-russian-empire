using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HexGrid : MonoBehaviour
{
    public GameObject hexPrefab; // Префаб для гексагона
    public int width = 6;
    public int height = 6;
    public float maxHeight = 10f;

    private float xOffset = 1.732f;
    private float zOffset = 1.5f;

    void Start()
    {
        Texture2D heightMapTexture = Resources.Load<Texture2D>("1"); // Загрузка height map
        GenerateHeightFromHeightMap(heightMapTexture);
    }

    void GenerateHeightFromHeightMap(Texture2D heightMap)
    {
        for (int x = 0; x < width; x++)
        {
            for (int z = 0; z < height; z++)
            {
                float xPos = x * xOffset;
                if (z % 2 == 1)
                {
                    xPos += xOffset / 2f;
                }
                float zPos = z * zOffset;

                // Определение высоты на основе пикселя в height map
                float normalizedX = Mathf.InverseLerp(0f, heightMap.width - 1, xPos);
                float normalizedZ = Mathf.InverseLerp(0f, heightMap.height - 1, zPos);
                Color pixelColor = heightMap.GetPixel(Mathf.FloorToInt(normalizedX * heightMap.width), Mathf.FloorToInt(normalizedZ * heightMap.height));
                float heightValue = pixelColor.r; // Используйте красный канал для яркости

                // Присвоение высоты гексагону
                GameObject hex = Instantiate(hexPrefab);
                hex.transform.position = new Vector3(xPos, heightValue * maxHeight, zPos); // Умножение на maxHeight, чтобы масштабировать высоту
                hex.transform.SetParent(transform);
            }
        }
    }
}

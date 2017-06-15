using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

[ExecuteInEditMode]
public class CreateCubemapArray : MonoBehaviour
{
    public Texture[] textureList;
    public int resolution = 256;
    public string savePath = "Assets/Textures/CubemapArray.asset";
    public bool export = false;



    void Update()
    {
        if(export && textureList != null)
        {
            if(textureList.Length > 0)
            {
                Create();
            }
            export = false;
        }
    }

    void Create()
    {
#if UNITY_EDITOR
        CubemapArray textureArray = new CubemapArray(6,textureList.Length, TextureFormat.RGB24, false);
        for (int i = 0; i < textureList.Length; i++)
        {
            Texture2D tex = (Texture2D)textureList[i];
            textureArray.SetPixels(tex.GetPixels(0), CubemapFace.PositiveX, 0);
        }
        textureArray.Apply();

        AssetDatabase.CreateAsset(textureArray, savePath);
        Debug.Log("Saved asset to " + savePath);
#endif
    }
}
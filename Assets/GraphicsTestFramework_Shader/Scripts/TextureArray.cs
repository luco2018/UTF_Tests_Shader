using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

[ExecuteInEditMode]
public class TextureArray : MonoBehaviour
{
    public Texture[] textureList;
    public int resolution = 256;
    public string savePath = "Assets/Textures/2DTextureArray.asset";
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
        Texture2DArray textureArray = new Texture2DArray(resolution, resolution, textureList.Length, TextureFormat.RGB24, false);
        for (int i = 0; i < textureList.Length; i++)
        {
            Texture2D tex = (Texture2D)textureList[i];
            textureArray.SetPixels(tex.GetPixels(0), i, 0);
        }
        textureArray.Apply();

        AssetDatabase.CreateAsset(textureArray, savePath);
        Debug.Log("Saved asset to " + savePath);
#endif
    }
}
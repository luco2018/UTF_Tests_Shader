using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColourCycleStatic : MonoBehaviour
{

	//public bool hueCycle = false;
	//public Vector2 offsetAnim = Vector2.zero;
	private Material mat;
	private MeshRenderer mr;
	public string property = "_Color";
	//private Color curCol = Color.white;
    public Color color;

	// Use this for initialization
	void Start ()
	{
		mr = this.GetComponent<MeshRenderer> ();
		mat = mr.material;
        //curCol = color;

        //if (hueCycle)
        //curCol = Color.green;
        colorUpdate();

    }
	
	// Update is called once per frame
	public void colorUpdate ()
	{
        /*
		if (hueCycle) {
			mat.SetColor (property, Color.HSVToRGB (Mathf.Repeat (Time.time / 10f, 1f), 1f, 1f));
		}*/
        /*if (offsetAnim != Vector2.zero)
			mat.mainTextureOffset += offsetAnim * Time.deltaTime;*/
        mat.SetColor(property, color);
        RendererExtensions.UpdateGIMaterials (mr);

	}
}

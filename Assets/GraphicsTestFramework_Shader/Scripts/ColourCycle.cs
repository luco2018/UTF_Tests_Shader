using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColourCycle : MonoBehaviour
{

	public bool hueCycle = false;
	public Vector2 offsetAnim = Vector2.zero;
	private Material mat;
	private MeshRenderer mr;
	public string property = "_Color";
	private Color curCol = Color.white;

	// Use this for initialization
	void Start ()
	{
		mr = this.GetComponent<MeshRenderer> ();
		mat = mr.material;
		if (hueCycle)
			curCol = Color.green;
	}
	
	// Update is called once per frame
	void Update ()
	{

		if (hueCycle) {
			mat.SetColor (property, Color.HSVToRGB (Mathf.Repeat (Time.time / 10f, 1f), 1f, 1f));
		}
		if (offsetAnim != Vector2.zero)
			mat.mainTextureOffset += offsetAnim * Time.deltaTime;

		RendererExtensions.UpdateGIMaterials (mr);

	}
}

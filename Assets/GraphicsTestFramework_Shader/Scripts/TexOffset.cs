using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent (typeof(MeshRenderer))]
public class TexOffset : MonoBehaviour
{

	Material mat;
	public bool detailTexture = true;

	// Use this for initialization
	void Start ()
	{

		mat = GetComponent<Renderer> ().material;

	}
	
	// Update is called once per frame
	void Update ()
	{
		Vector2 vect = new Vector2 (Mathf.Repeat (Time.time * 0.25f, 1f), 0f);
		mat.mainTextureOffset = vect;
		mat.SetTextureOffset ("_DetailAlbedoMap", vect);
	}
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TessellationMaterial : MonoBehaviour 
{
	private Material mat;
	public string name = "_Displacement";
	public float disp = 0;
	// Use this for initialization
	void Start () 
	{
		mat = GetComponent<MeshRenderer> ().material;
	}
	
	// Update is called once per frame
	void Update () 
	{
		mat.SetFloat (name, disp);
	}
}

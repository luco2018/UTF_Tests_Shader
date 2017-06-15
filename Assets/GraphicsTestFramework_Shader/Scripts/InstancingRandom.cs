using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstancingRandom : MonoBehaviour 
{
	public MeshRenderer[] renderers;
	public string propertyName = "_Color";

	public enum TypeEnum{Float, Color};
	public TypeEnum propertyType;


	private MaterialPropertyBlock props;
	private float r, g, b, a;

	void Start () 
	{
		props = new MaterialPropertyBlock();
	}

	void Update () 
	{
		for(int i=0; i<renderers.Length; i++)
		{
			if(propertyType == TypeEnum.Color) props.SetColor(propertyName,InstanceColor());
			if(propertyType == TypeEnum.Float) props.SetFloat(propertyName,InstanceFloat());
			renderers[i].SetPropertyBlock(props);
		}
	}

	private Color InstanceColor()
	{
		r = Random.Range(0.0f, 1.0f);
		g = Random.Range(0.0f, 1.0f);
		b = Random.Range(0.0f, 1.0f);
		a = Random.Range(0.0f, 1.0f);

		return new Color (r, g, b, a);
	}

	private float InstanceFloat()
	{
		return Random.Range(0.0f, 1.0f);
	}
}

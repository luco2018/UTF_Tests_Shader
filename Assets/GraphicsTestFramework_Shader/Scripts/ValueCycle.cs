using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ValueCycle : MonoBehaviour
{

	private Material mat;
	public string property = "_Glossiness";
	public float minVal = 0f;
	public float maxVal = 1f;
	public bool pingPong = true;

	void Start ()
	{
		mat = this.GetComponent<MeshRenderer> ().material;
	}

	void Update ()
	{

		if (pingPong) {
			mat.SetFloat (property, Mathf.PingPong (Time.time * 0.25f, maxVal - minVal) + minVal);
		} else {
			mat.SetFloat (property, Mathf.Repeat (Time.time * 0.25f, maxVal - minVal) + minVal);

		}

	}
}

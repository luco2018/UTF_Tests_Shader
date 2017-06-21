using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MetallicGlossBalls : MonoBehaviour
{
    public bool isSpecular = false;
	public float min = -0.6f;
	public float max = 0.6f;

	void Start ()
	{
		float scale = max - min;

		foreach (Transform t in transform)
        {
			Material mat = t.GetComponent<MeshRenderer> ().material;
            if(isSpecular)
            {
                mat.SetColor("_SpecColor", Color.white * ((t.localPosition.x - min) / scale));
                mat.SetFloat("_GlossMapScale", (t.localPosition.y - min) / scale);
            }
            else
            {
                mat.SetFloat("_Metallic", (t.localPosition.x - min) / scale);
                mat.SetFloat("_Glossiness", (t.localPosition.y - min) / scale);
            }

		}
	}
}

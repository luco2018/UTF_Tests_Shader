using UnityEngine;

public class MetallicGlossBalls : MonoBehaviour
{
    public bool isSpecular = false;
	public float min = -0.6f;
	public float max = 0.6f;

    public GameObject[] Column1;
    public GameObject[] Column2;
    public GameObject[] Column3;

    void Start ()
	{
		float scale = max - min;

        //Column 1
        float step1 = scale / Column1.Length;
        for (int i=0; i< Column1.Length;i++)
        {
            float factor = step1 * i;
            Transform t = Column1[i].transform;
            Material mat = t.GetComponent<MeshRenderer>().material;
            if (isSpecular)
            {
                mat.SetColor("_SpecColor", Color.black);
                mat.SetFloat("_GlossMapScale", factor);
            }
            else
            {
                mat.SetFloat("_Glossiness", factor);
                mat.SetFloat("_Metallic", 0);
            }
        }

        //Column 2
        float step2 = scale / Column2.Length;
        for (int i = 0; i < Column2.Length; i++)
        {
            float factor = step2 * i;
            Transform t = Column2[i].transform;
            Material mat = t.GetComponent<MeshRenderer>().material;
            if (isSpecular)
            {
                mat.SetColor("_SpecColor", Color.grey);
                mat.SetFloat("_GlossMapScale", factor);
            }
            else
            {
                mat.SetFloat("_Metallic", 0.5f);
                mat.SetFloat("_Glossiness", factor);
            }
        }

        //Column 3
        float step3 = scale / Column3.Length;
        for (int i = 0; i < Column3.Length; i++)
        {
            float factor = step3 * i;
            Transform t = Column3[i].transform;
            Material mat = t.GetComponent<MeshRenderer>().material;
            if (isSpecular)
            {
                mat.SetColor("_SpecColor", Color.white);
                mat.SetFloat("_GlossMapScale", factor);
            }
            else
            {
                mat.SetFloat("_Glossiness", factor);
                mat.SetFloat("_Metallic", 1f);
            }
        }



        /*
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
        */
    }
}

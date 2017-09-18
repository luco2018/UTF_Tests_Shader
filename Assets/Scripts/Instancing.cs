using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Instancing : MonoBehaviour 
{
	public MeshRenderer[] renderers;
	public string propertyName = "_Color";

	public enum TypeEnum{Float, Float2, Float3, Float4x4, Color, FloatArray4, Mixed};
	public TypeEnum propertyType;


	private MaterialPropertyBlock props;

	void Start () 
	{
		props = new MaterialPropertyBlock();

		for(int i=0; i<renderers.Length; i++)
		{
			if(propertyType == TypeEnum.Color) props.SetColor(propertyName,InstanceColor(i));
			if(propertyType == TypeEnum.Float) props.SetFloat(propertyName,InstanceFloat(i));
            if (propertyType == TypeEnum.Float2) props.SetVector(propertyName, InstanceFloat2(i));
            if (propertyType == TypeEnum.Float3) props.SetVector(propertyName, InstanceFloat3(i));
            if (propertyType == TypeEnum.Float4x4) props.SetMatrix(propertyName, InstanceFloat4x4(i));
            if (propertyType == TypeEnum.FloatArray4) props.SetFloatArray(propertyName, InstanceFloatArray(i));
            if (propertyType == TypeEnum.Mixed)
            {
                props.SetVector("_Fixed2", InstanceFloat2(i));
                props.SetVector("_Float3", InstanceFloat3(i));
                props.SetMatrix("_Half4x4", InstanceFloat4x4(i));
            }
            
            renderers[i].SetPropertyBlock(props);
		}
	}

	private Color InstanceColor(int id)
	{
        Color result;
        switch(id)
        {
            case 0:
                result = new Color(1, 0, 0, 1); //Red
                break;
            case 1:
                result = new Color(0, 1, 0, 1); //Yellow
                break;
            case 2:
                result = new Color(0, 0, 1, 1); //Green
                break;
            case 3:
                result = new Color(0.5f, 0.5f, 0.5f, 1); //Grey
                break;
            default:
                result = new Color(1, 1, 1, 1); //White
                break;
        }
        return result;
		//return HSBColor.ToColor (new HSBColor ( (float)id / (float)renderers.Length, 1, 1));
	}

	private float InstanceFloat(int id)
	{
        return InstanceColor(id).r;
    }

    private Vector2 InstanceFloat2(int id)
    {
        return new Vector2(InstanceColor(id).r, InstanceColor(id).g);
    }

    private Vector3 InstanceFloat3(int id)
    {
        return new Vector3(InstanceColor(id).r, InstanceColor(id).g, InstanceColor(id).b);
    }

    private Matrix4x4 InstanceFloat4x4(int id)
    {
        Matrix4x4 m44 = new Matrix4x4();
        Color c = InstanceColor(id);

        for (int i=0; i<4; i++)
        {
            m44[i, 0] = c.r;
            m44[i, 1] = c.g;
            m44[i, 2] = c.b;
            m44[i, 3] = c.a;
        }
        return m44;
    }

    private float[] InstanceFloatArray(int id)
    {
        float[] color = new float[4];

        Color c = InstanceColor(id);
        
        color[0] = c.r;
        color[1] = c.g;
        color[2] = c.b;
        color[3] = c.a;
        

        /*
        color[0] = 0.1f;
        color[1] = 0.5f;
        color[2] = 0.5f;
        color[3] = 0.5f;
        */

        return color;
    }
}
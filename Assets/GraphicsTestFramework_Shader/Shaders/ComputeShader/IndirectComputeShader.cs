using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IndirectComputeShader : MonoBehaviour 
{
	private ComputeBuffer cbDrawArgs;
	public ComputeShader shader;
	public int argsSize = 12;

	private int _kernel;
	private Material _mat;

	void Start () 
	{
		if (cbDrawArgs == null)
		{
			cbDrawArgs = new ComputeBuffer (1, argsSize, ComputeBufferType.IndirectArguments);
			var args = new int[3];
			args[0] = 512/8;
			args[1] = 512/8;
			args[2] = 1;
			cbDrawArgs.SetData (args);
		}

		_kernel = shader.FindKernel ("CSMainIndirect");
		_mat = GetComponent<Renderer> ().material;
		RunShader ();
	}
		
	public void RunShader()
	{
		RenderTexture tex = new RenderTexture (512, 512, 24);
		tex.enableRandomWrite = true;
		tex.Create ();

		shader.SetTexture (_kernel, "ResultIndirect", tex);
		//shader.Dispatch (_kernel, 512 / 8, 512 / 8, 1);
		shader.DispatchIndirect(_kernel,cbDrawArgs,0);

		_mat.SetTexture ("_MainTex", tex);

	}

	void OnDestroy()
	{
		if (cbDrawArgs != null) 
		{
			cbDrawArgs.Release (); 
			cbDrawArgs = null;
			Debug.Log ("OnDestroy - Release args compute buffer");
		}

	}

	void OnApplicationQuit()
	{
		if (cbDrawArgs != null) 
		{
			cbDrawArgs.Release (); 
			cbDrawArgs = null;
			Debug.Log ("OnApplicationQuit - Release args compute buffer");
		}
	}

}

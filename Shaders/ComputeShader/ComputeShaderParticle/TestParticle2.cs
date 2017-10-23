using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class TestParticle2 : MonoBehaviour 
{
	// The same particle data structure used by both the compute shader and the shader.
	struct Particle
	{
		public Vector3 position;
	};
	
	public static List<TestParticle2> list;	// Static list, just to call Render() from the camera.
	
	public int warpCount = 5;				// The number particle /32.

	public Material material;				// Use "particle" shader.
	public ComputeShader computeShader;		// Use "moveParticle" compute shader.
	
	const int warpSize = 32; 				// GPUs process data by warp, 32 for every modern ones.
	public int particleCount; 	// = warpSize * warpCount.
	
	ComputeBuffer particleBuffer;			// The GPU buffer holding the particules.
	
	void Start () 
	{
		// Just init the static list 
		if (list == null)
			list = new List<TestParticle2>();
		list.Add(this);

		particleCount = warpCount * warpSize;
		
		// Init particles
		Particle[] particleArray = new Particle[particleCount];
		for (int i = 0; i < particleCount; ++i)
		{
            //particleArray[i].position = Random.insideUnitSphere * 5;
            particleArray[i].position = transform.position;
        }
		
		// Instanciate and initialise the GPU buffer.
		particleBuffer = new ComputeBuffer(particleCount, 12); // 12 = sizeof(Particle)
		particleBuffer.SetData(particleArray);
		
		// bind the buffer to both the compute shader and the shader.
		computeShader.SetBuffer(0, "particleBuffer", particleBuffer);
		material.SetBuffer ("particleBuffer", particleBuffer);
	}
	
	void Update () 
	{
		// Start the compute shader (move every particle for this frame).
		computeShader.Dispatch(0, warpCount, 1, 1);
	}
	
	// Called by the camera in OnRender
	public void Render () 
	{
		// Bind the pass to the pipeline then call a draw (this use the buffer bound in Start() instead of a VBO).
		material.SetPass (0);
		Graphics.DrawProcedural (MeshTopology.Points, 1, particleCount);
	}
	
	
	void OnDestroy()
	{
		list.Remove(this);
		
		// Unity cry if the GPU buffer isn't manually cleaned
		particleBuffer.Release();
	}
}

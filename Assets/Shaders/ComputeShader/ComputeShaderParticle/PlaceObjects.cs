using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PlaceObjects : MonoBehaviour
{
    // The same particle data structure used by both the compute shader and the shader.
    struct Particle
    {
        public Vector3 position;
    };

    public int warpCount = 5;               // The number particle /32.

    public ComputeShader computeShader;     // Use "moveParticle" compute shader.

    const int warpSize = 32;                // GPUs process data by warp, 32 for every modern ones.
    public int particleCount;   // = warpSize * warpCount.

    ComputeBuffer cBuffer;           // The GPU buffer holding the particules.

    public GameObject refObj;
    

    void Start()
    {
        particleCount = warpCount * warpSize;

        // Init particles
        Particle[] particleArray = new Particle[particleCount];
        for (int i = 0; i < particleCount; ++i)
        {
            particleArray[i].position = transform.position;
        }

        // Instanciate and initialise the GPU buffer.
        cBuffer = new ComputeBuffer(particleCount, 12); // 12 = sizeof(Particle)
        cBuffer.SetData(particleArray);

        // bind the buffer to both the compute shader and the shader.
        computeShader.SetBuffer(0, "particleBuffer", cBuffer);

        // Start the compute shader (move every particle for this frame).
        computeShader.Dispatch(0, warpCount, 1, 1);

        // Get data back from compute buffer in compute shader
        cBuffer.GetData(particleArray);
        for (int i = 0; i < particleArray.Length; ++i)
        {
            GameObject go = Instantiate(refObj, this.transform);
            go.transform.position = particleArray[i].position;
        }
    }



    void OnDestroy()
    {
        // Unity cry if the GPU buffer isn't manually cleaned
        cBuffer.Release();
    }
}

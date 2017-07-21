// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "FTPCustom/ComputeShader/SimplifiedParticle"
{
	// Bound with the inspector.
 	Properties 
 	{
        _Color ("Main Color", Color) = (0, 1, 1,0.3)
        _SpeedColor ("Speed Color", Color) = (1, 0, 0, 0.3)
    }

	SubShader 
	{
		Pass 
		{
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			//#pragma target 5.0
			
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			
			// The same particle data structure used by both the compute shader and the shader.
			struct Particle
			{
				float3 position;
			};
			
			// structure linking the data between the vertex and the fragment shader
			struct FragInput
			{
				float4 color : COLOR;
				float4 position : SV_POSITION;
			};
			
			// The buffer holding the particles shared with the compute shader.
			StructuredBuffer<Particle> particleBuffer;
			
			// Variables from the properties.
			float4 _Color;
			float4 _SpeedColor;

			// DX11 vertex shader these 2 parameters come from the draw call: "1" and "particleCount", 
			// SV_VertexID: "1" is the number of vertex to draw peer particle, we could easily make quad or sphere particles with this.
			// SV_InstanceID: "particleCount", number of particles...
			FragInput vert (uint id : SV_VertexID, uint inst : SV_InstanceID)
			{
				FragInput fragInput;

				// position computation
				fragInput.position = UnityObjectToClipPos (float4(particleBuffer[inst].position, 1));

				// color computation
				//fragInput.color = lerp(_Color, _SpeedColor, fragInput.position);
				fragInput.color = lerp(_Color, _SpeedColor, fmod(inst , 2) ); //Odd and even will show different color

				return fragInput;
			}
			
			// this just pass through the color computed in the vertex program
			float4 frag (FragInput fragInput) : COLOR
			{
				return fragInput.color;
			}
			
			ENDCG
		
		}
	}
}

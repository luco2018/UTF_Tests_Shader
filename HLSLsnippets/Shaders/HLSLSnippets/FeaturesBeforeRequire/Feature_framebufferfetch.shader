// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//https://github.com/Elringus/BlendModeExample/blob/master/Assets/Shaders/FramebufferDarken.shader
//http://elringus.me/blend-modes-in-unity/

Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/framebufferfetch"
{
	Properties
	{
		_MainTex("Sprite Texture", 2D) = "white" {}
		_Color("Tint", Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
		}

		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex ComputeVertex
			#pragma fragment ComputeFragment
			//#pragma require framebufferfetch

			sampler2D _MainTex;
			fixed4 _Color;

			struct VertexInput
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct VertexOutput
			{
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
				half2 texcoord : TEXCOORD0;
			};

			VertexOutput ComputeVertex(VertexInput vertexInput)
			{
				VertexOutput vertexOutput;

				vertexOutput.vertex = UnityObjectToClipPos(vertexInput.vertex);
				vertexOutput.texcoord = vertexInput.texcoord;
				vertexOutput.color = vertexInput.color * _Color;

				return vertexOutput;
			}

			fixed4 Darken(fixed4 a, fixed4 b)
			{
				fixed4 r = min(a, b);
				r.a = b.a;
				return r;
			}

			fixed4 ComputeFragment(VertexOutput vertexOutput
			//#ifdef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
				, inout fixed4 fetchColor : COLOR0
			//#endif
			) : SV_Target
			{
				half4 color = tex2D(_MainTex, vertexOutput.texcoord) * vertexOutput.color;

				//#ifdef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
						fixed4 grabColor = 1-fetchColor;
				//#else
				//		fixed4 grabColor = fixed4(1, 1, 0, 1); //fallback yellow
				//#endif

				return Darken(grabColor, color);
			}

			ENDCG
		}
	}
}



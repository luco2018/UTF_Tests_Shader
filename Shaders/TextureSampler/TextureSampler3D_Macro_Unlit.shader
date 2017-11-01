Shader "TextureSampler3D/Macro Unlit"
{
	Properties
	{
		_MainTex ("_MainTex (RGBA)", 3D) = "white" {}
		[NoScaleOffset] _SamplerTex ("_SamplerTex (RGBA)", 3D) = "white" {}
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha //Alpha Blend
		Cull Back Lighting Off ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float3 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			UNITY_DECLARE_TEX3D(_SamplerTex);
			UNITY_DECLARE_TEX3D_NOSAMPLER(_MainTex);


			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = mul(unity_ObjectToWorld, v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(1,0,0,1); //Fallback Color

				float3 uv = (i.uv + fixed3(0, 0.5, 0.5)) * 2;

					fixed4 blah = UNITY_SAMPLE_TEX3D(_SamplerTex,uv);
					col = UNITY_SAMPLE_TEX3D_SAMPLER(_MainTex,_SamplerTex,uv);
					col += blah * 0.0001f; // You must use the point sampler!

				return col;
			}
			ENDCG
		}
	}
}

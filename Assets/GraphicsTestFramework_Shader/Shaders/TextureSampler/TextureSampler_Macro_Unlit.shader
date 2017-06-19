Shader "TextureSampler/Macro Unlit"
{
	Properties
	{
		_MainTex ("_MainTex (RGBA)", 2D) = "white" {}
		[NoScaleOffset] _SamplerTex ("_SamplerTex (RGBA)", 2D) = "white" {}
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
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			float4 _MainTex_ST;


				UNITY_DECLARE_TEX2D(_SamplerTex);
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);


			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(1,0,0,1); //Fallback Color

					fixed4 blah = UNITY_SAMPLE_TEX2D(_SamplerTex,i.uv);
					col = UNITY_SAMPLE_TEX2D_SAMPLER(_MainTex,_SamplerTex,i.uv);
					col += blah * 0.0001f; // You must use the point sampler!

				return col;
			}
			ENDCG
		}
	}
}

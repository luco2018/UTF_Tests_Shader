Shader "TextureSamplerCube/Macro Unlit"
{
	Properties
	{
		_MainTex ("_MainTex (RGBA)", CUBE) = "white" {}
		[NoScaleOffset] _SamplerTex ("_SamplerTex (RGBA)", CUBE) = "white" {}
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
				float4 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float4 normal : NORMAL;
			};

			UNITY_DECLARE_TEXCUBE(_SamplerTex);
			UNITY_DECLARE_TEXCUBE_NOSAMPLER(_MainTex);


			v2f vert (appdata v)
			{
				v2f o;
				o.normal = v.normal;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(1,0,0,1); //Fallback Color

				float4 uv = fixed4(i.normal.xyz, 0);

					fixed4 blah = UNITY_SAMPLE_TEXCUBE(_SamplerTex,uv);
					col = UNITY_SAMPLE_TEXCUBE_SAMPLER(_MainTex,_SamplerTex,uv);
					col += blah * 0.0001f; // You must use the point sampler!

				return col;
			}
			ENDCG
		}
	}
}

Shader "TextureSampler3D/Inline Unlit"
{
	Properties
	{
		_MainTex ("_MainTex (RGBA)", 3D) = "white" {}
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
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			float4 _MainTex_ST;

			#if SHADER_API_D3D11
				Texture3D _MainTex;
				SamplerState my_point_repeat_sampler;
			#endif

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

				#if SHADER_API_D3D11
					col = _MainTex.Sample(my_point_repeat_sampler, uv);
				#endif


				return col;
			}
			ENDCG
		}
	}
}

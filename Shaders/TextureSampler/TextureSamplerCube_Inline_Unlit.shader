Shader "TextureSamplerCube/Inline Unlit"
{
	Properties
	{
		_MainTex ("_MainTex (RGBA)", CUBE) = "white" {}
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

			float4 _MainTex_ST;

			//#if SHADER_API_D3D11
				TextureCube _MainTex;
				SamplerState my_point_repeat_sampler;
			//#endif

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.normal = v.normal;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(1,0,0,1); //Fallback Color
				
				float4 uv = fixed4(i.normal.xyz, 0);

				//#if SHADER_API_D3D11
					col = _MainTex.Sample(my_point_repeat_sampler, uv);
				//#endif


				return col;
			}
			ENDCG
		}
	}
}

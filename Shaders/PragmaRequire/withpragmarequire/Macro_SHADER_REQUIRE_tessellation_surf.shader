Shader "FTPCustom/HLSLSnippets/Require Macro SHADER_REQUIRE tessellation with pragma require"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGPROGRAM
		#pragma require tessellation
		#pragma surface surf BlinnPhong vertex:dispNone tessellate:tessEdge tessphong:0.5 nolightmap
		#include "Tessellation.cginc"

		struct appdata
		{
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
		};

		void dispNone(inout appdata v) { }

		float4 tessEdge(appdata v0, appdata v1, appdata v2)
		{
			return UnityEdgeLengthBasedTess(v0.vertex, v1.vertex, v2.vertex, 20.0f);
		}

		struct Input
		{
			float2 uv_MainTex;
		};

		fixed4 _Color;
		sampler2D _MainTex;

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 col = fixed4(1,0,0,1);

			#if defined(SHADER_REQUIRE_TESSELLATION)
				col = fixed4(0, 1, 0, 1);
			#endif

			o.Albedo = 0;
			o.Emission = col;
			o.Alpha = 1;
		}

		ENDCG
	}
}

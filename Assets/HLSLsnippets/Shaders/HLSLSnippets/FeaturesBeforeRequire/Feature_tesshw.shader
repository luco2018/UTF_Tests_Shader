//GPU support for hardware tessellation, but not necessarily tessellation shader stages(e.g.Metal supports tessellation, but not via shader stages).
Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/tesshw"
{
	Properties
	{
		_EdgeLength("Edge length", Range(0,50)) = 5
		_Phong("Phong Strengh", Range(0,1)) = 0.5
		_MainTex("Base (RGB)", 2D) = "white" {}
		_Color("Color", color) = (1,1,1,0)
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 300

		CGPROGRAM
	#pragma target 4.6
	#pragma surface surf BlinnPhong vertex:dispNone tessellate:tessEdge tessphong:_Phong nolightmap addshadow fullforwardshadows 
	#include "Tessellation.cginc"

		struct appdata
	{
		float4 vertex : POSITION;
		float3 normal : NORMAL;
		float2 texcoord : TEXCOORD0;
	};

	void dispNone(inout appdata v) { }

	float _Phong;
	float _EdgeLength;

	float4 tessEdge(appdata v0, appdata v1, appdata v2)
	{
		return UnityEdgeLengthBasedTess(v0.vertex, v1.vertex, v2.vertex, (_EdgeLength*100.0f) + 20.0f);
	}

	struct Input
	{
		float2 uv_MainTex;
	};

	fixed4 _Color;
	sampler2D _MainTex;

	void surf(Input IN, inout SurfaceOutput o)
	{
		half4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
		o.Albedo = 1 * pow((c.rgb / 1),(1 / 2.2));
		// o.Albedo = c.rgb;
		o.Alpha = c.a;
	}

	ENDCG
	}
}
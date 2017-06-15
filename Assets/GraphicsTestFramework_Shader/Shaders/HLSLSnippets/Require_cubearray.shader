// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "FTPCustom/HLSLSnippets/Require cubearray"
{
	Properties
	{
		_MyArr("Tex", CubeArray) = "" {}
		_SliceRange("Slices", Range(0,16)) = 6
		_UVScale("UVScale", Float) = 1.0
	}
		SubShader
	{
		Pass
	{
		CGPROGRAM

#pragma require cubearray
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

		struct v2f
	{
		float4 uv : TEXCOORD0;
		float4 vertex : SV_POSITION;
	};

	float _SliceRange;
	float _UVScale;

	v2f vert(float4 vertex : POSITION)
	{
		v2f o;
		o.vertex = UnityObjectToClipPos(vertex);
		o.uv.xy = (vertex.xy + 0.5) * _UVScale;
		o.uv.zw = (vertex.z + 0.5) * _SliceRange;
		return o;
	}

	TextureCubeArray <float4> _MyArr;

	half4 frag(v2f i) : SV_Target
	{
		float4 col = _MyArr[0];

		return col;
	}
		ENDCG
	}
	}
}
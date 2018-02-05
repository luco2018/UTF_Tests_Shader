// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "FTPCustom/HLSLSnippets/Combine cubearray 2darray"
{
	Properties
	{
		_MyArr("Tex", 2DArray) = "" {}
	_SliceRange("Slices", Range(0,16)) = 6
		_UVScale("UVScale", Float) = 1.0

		_CubeMyArr("Tex", CubeArray) = "" {}
	}
		SubShader
	{
		Pass
	{
		CGPROGRAM
#pragma require 2darray cubearray
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

	UNITY_DECLARE_TEX2DARRAY(_MyArr);
	UNITY_DECLARE_TEXCUBEARRAY(_CubeMyArr);

	half4 frag(v2f i) : SV_Target
	{
		float4 cube = UNITY_SAMPLE_TEXCUBEARRAY(_CubeMyArr, i.uv);
		float4 td = UNITY_SAMPLE_TEX2DARRAY(_MyArr, i.uv);
		float4 col =  fixed4(1,0,0,1);
		col = cube * td;
		return col;
	}
		ENDCG
	}
	}
}
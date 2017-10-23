Shader "FTPCustom/HLSLSnippets/Require fragdepth"
{
	Properties
	{
		_MainTex("_MainTex (RGBA)", 2D) = "white" {}
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		Pass
	{
		CGPROGRAM
#pragma require fragdepth
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
		float4 screenPos : TEXCOORD0;
		float4 vertex : SV_POSITION;
	};

	sampler2D _MainTex;
	float4 _MainTex_ST;

	inline float4 UnityObjectToClipPosRespectW(in float4 pos)
	{
		// More efficient than computing M*VP matrix product
		return mul(UNITY_MATRIX_VP, mul(unity_ObjectToWorld, pos));
	}

	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = UnityObjectToClipPosRespectW(v.vertex);
		o.screenPos = ComputeScreenPos(o.vertex);

		return o;
	}

	fixed4 frag(v2f i) : SV_Target
	{

		float fragDepth = 0;
		i.screenPos.xyz /= i.screenPos.w;

		//#ifdef SHADER_API_D3D11
			fragDepth = i.screenPos.z;
		//#else
		//	fragDepth = (i.screenPos.z + 1) / 2;
		//#endif

		fixed4 col = fragDepth;
		return col;

	}
		ENDCG
	}
	}
}

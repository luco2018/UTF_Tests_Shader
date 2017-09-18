Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/fragcoord"
{
	Properties
	{
		_MainTex("_MainTex (RGBA)", 2D) = "white" {}
		_Contrast("_Contrast", Range(0,1)) = 0

		[Header(ColorOperation (SELECT ONLY 1))]
		[Toggle(SHOW_X)] _useX ("X", Float) = 1
		[Toggle(SHOW_Y)] _useY ("Y", Float) = 1
		[Toggle(SHOW_Z)] _useZ ("Z", Float) = 1
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		Pass
	{
		CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag
#pragma shader_feature SHOW_X SHOW_Y SHOW_Z


#include "UnityCG.cginc"

		struct appdata
	{
		float4 vertex : POSITION;
		float2 uv : TEXCOORD0;
	};

	struct v2f
	{
		float3 pos : TEXCOORD0;
		float4 vertex : SV_POSITION;
	};

	sampler2D _MainTex;
	float4 _MainTex_ST;
	fixed _Contrast;

	inline float4 UnityObjectToClipPosRespectW(in float4 pos)
	{
		// More efficient than computing M*VP matrix product
		return mul(UNITY_MATRIX_VP, mul(unity_ObjectToWorld, pos));
	}

	inline float Contrast(float a, float contrast)
	{
		float factor = (259.0f * (contrast + 255.0f)) / (255.0f * (259.0f - contrast));
		a *= 255.0f;
		a = floor(factor * (a - 128.0f) + 128.0f);
		a /= 255.0f;
		return a;
	}

	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = UnityObjectToClipPosRespectW(v.vertex);
		o.pos = o.vertex.xyz / o.vertex.w;//ComputeScreenPos(o.vertex);
		//o.screenPos = ComputeScreenPos(o.vertex);

		return o;
	}

	fixed4 frag(v2f i) : SV_Target
	{

		//float fragDepth = 0;
		//i.screenPos.xyz /= i.screenPos.w;

		//#ifdef SHADER_API_D3D11
			//fragDepth = i.screenPos.z;
		//#else
		//	fragDepth = (i.screenPos.z + 1) / 2;
		//#endif

		//fixed4 col = fragDepth;

		fixed4 col;
		col.r = i.pos.x;
		col.g = i.pos.y;
		col.b = Contrast(i.pos.z, _Contrast*255.0f);
		col.a = 1;

#ifdef SHOW_X
		return col.r;
#endif

#ifdef SHOW_Y
		return col.g;
#endif

#ifdef SHOW_Z
		return col.b;
#endif

	}
		ENDCG
	}
	}
}

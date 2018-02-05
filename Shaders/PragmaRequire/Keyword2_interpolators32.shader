Shader "FTPCustom/HLSLSnippets/Keyword 2 interpolators32"
{
	Properties
	{
		[Toggle(ENABLE_INP32A)] _Fancy("interpolators32?", Float) = 1
		[Toggle(ENABLE_INP32B)] _Fancy2("interpolators32?", Float) = 1
		_MainTex("_MainTex (RGBA)", 2D) = "white" {}
		_FalseColor("_WrongColor",Color) = (1,0,0,1)
		_TrueColor("_TrueColor",Color) = (0,1,0,1)
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		Pass
	{
		CGPROGRAM
		//#pragma target 4.5
		#pragma require interpolators32 : ENABLE_INP32A ENABLE_INP32B
		#pragma shader_feature __ ENABLE_INP32A
		#pragma shader_feature __ ENABLE_INP32B
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
		float2 uv1 : TEXCOORD0;
		#if defined(SHADER_REQUIRE_INTERPOLATORS32)
			/*float2 uv2 : TEXCOORD1;
			float2 uv3 : TEXCOORD2;
			float2 uv4 : TEXCOORD3;
			float2 uv5 : TEXCOORD4;

			float2 uv6 : TEXCOORD5;
			float2 uv7 : TEXCOORD6;
			float2 uv8 : TEXCOORD7;
			float2 uv9 : TEXCOORD8;
			float2 uv10 : TEXCOORD9;

			float2 uv11 : TEXCOORD10;
			float2 uv12 : TEXCOORD11;
			float2 uv13 : TEXCOORD12;
			float2 uv14 : TEXCOORD13;
			float2 uv15 : TEXCOORD14;

			float2 uv16 : TEXCOORD15;
			float2 uv17 : TEXCOORD16;
			float2 uv18 : TEXCOORD17;
			float2 uv19 : TEXCOORD18;
			float2 uv20 : TEXCOORD19;

			float2 uv21 : TEXCOORD20;
			float2 uv22 : TEXCOORD21;
			float2 uv23 : TEXCOORD22;
			float2 uv24 : TEXCOORD23;
			float2 uv25 : TEXCOORD24;

			float2 uv26 : TEXCOORD25;
			float2 uv27 : TEXCOORD26;
			float2 uv28 : TEXCOORD27;
			float2 uv29 : TEXCOORD28;
			float2 uv30 : TEXCOORD29;

			float2 uv31 : TEXCOORD30;*/
			float2 uv32 : TEXCOORD31;
		#endif
		/*
		float2 uv33 : TEXCOORD32;
		float2 uv34 : TEXCOORD33;
		*/
		float4 vertex : SV_POSITION;
	};

	sampler2D _MainTex;
	float4 _MainTex_ST;
	float4 _FalseColor, _TrueColor;

	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = UnityObjectToClipPos(v.vertex);
		o.uv1 = TRANSFORM_TEX(v.uv, _MainTex);
		#if defined (SHADER_REQUIRE_INTERPOLATORS32)
			o.uv32 = o.uv1;
		#endif
		return o;
	}

	fixed4 frag(v2f i) : SV_Target
	{
		fixed4 col = fixed4(1,0,0,1);
		#if defined (SHADER_REQUIRE_INTERPOLATORS32)
			col = tex2D(_MainTex, i.uv32) * _TrueColor;
		#else
			col = _FalseColor;
		#endif
		return col;
	}
		ENDCG
	}
	}
}
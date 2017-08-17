Shader "FTPCustom/RenderState/All"
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0

		[Header(Blend State)]
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("Source", Int) = 1.0
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("Destination", Int) = 1.0
		[Enum(UnityEngine.Rendering.BlendOp)] _BlendOp("BlendOp", Int) = 1.0
		[Enum(Off,0,On,1)] _AlphaToMask("AlphaToMask", int) = 0

		[Header(Depth State)]
		[Enum(Off,0,On,1)] _ZWrite("ZWrite", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", Float) = 8

		[Header(Raster State)]
		[Enum(Off,0,Front,1,Back,2)] _CullMode("Culling Mode", int) = 0
		_OffsetFactor("OffsetFactor", Range(-100,100)) = 0.0
		_OffsetUnit("OffsetUnit", Range(-100,100)) = 0.0

		[Header(Stencil State)]
		_StencilRef("Stencil Ref", Float) = 0
		_StencilReadMask("Stencil Read Mask", Float) = 255
		_StencilWriteMask("Stencil Write Mask", Float) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Stencil Comparison", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilPass("Stencil Pass Operation", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilFail("Stencil Fail Operation", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilZfail("Stencil ZFail Operation", Float) = 0
	}
	SubShader 
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }

		Blend[_SrcBlend][_DstBlend]
		BlendOp[_BlendOp]
		AlphaToMask [_AlphaToMask]
		//--
		ZWrite[_ZWrite]
		ZTest[_ZTest]
		//--
		Cull[_CullMode]
		Offset[_OffsetFactor],[_OffsetUnit]
		//--
		Stencil
		{
			Ref[_StencilRef]
			Comp[_StencilComp]
			Pass[_StencilPass]
			ReadMask[_StencilReadMask]
			WriteMask[_StencilWriteMask]
			Fail[_StencilFail]
			ZFail[_StencilZfail]
		}

		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows keepalpha
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input 
		{
			float2 uv_MainTex;
			float4 color : COLOR;
		};

		half _Glossiness;
		half _Metallic;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * IN.color;

			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
}

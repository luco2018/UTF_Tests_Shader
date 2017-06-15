Shader "FTPCustom/MaterialPropertyDrawer"
{
	Properties
	{
	_MainTex("Texture", 2D) = "white" {}

	[HideInInspector] _MainTex2("Hide Texture", 2D) = "white" {}

	[NoScaleOffset] _MainTex3("No Scale/Offset Texture", 2D) = "white" {}

	[PerRendererData] _MainTex4("PerRenderer Texture", 2D) = "white" {}

	[Normal] _MainTex5("Normal Texture", 2D) = "white" {}

	_Color("Color", Color) = (1,0,0,1)

	[HDR] _HDRColor("HDR Color", Color) = (1,0,0,1)

	_Vector("Vector", Vector) = (0,0,0,0)

	//Can't go below zero
	[Gamma] _GVector("Gamma Vector", Vector) = (0,0,0,0)

	// Header creates a header text before the shader property.
	[Header(A group of things)]

	// Will set "_INVERT_ON" shader keyword when set
	[Toggle] _Invert("Auto keyword toggle", Float) = 0

	// Will set "ENABLE_FANCY" shader keyword when set.
	[Toggle(ENABLE_FANCY)] _Fancy("Keyword toggle", Float) = 0

		// Will show when ENABLE_FANCY is true //Feature request
		[HideIfDisabled(ENABLE_FANCY)] _ShowIf("Show If", Float) = 0

	// Blend mode values
	[Enum(UnityEngine.Rendering.BlendMode)] _Blend("Blend mode Enum", Float) = 1

	// A subset of blend mode values, just "One" (value 1) and "SrcAlpha" (value 5).
	[Enum(One,1,SrcAlpha,5)] _Blend2("Blend mode subset", Float) = 1

	// Each option will set _OVERLAY_NONE, _OVERLAY_ADD, _OVERLAY_MULTIPLY shader keywords.
	[KeywordEnum(None, Add, Multiply)] _Overlay("Keyword Enum", Float) = 0
	// ...later on in CGPROGRAM code:
	//#pragma multi_compile _OVERLAY_NONE, _OVERLAY_ADD, _OVERLAY_MULTIPLY
	// ...

	// A slider with 3.0 response curve
	[PowerSlider(3.0)] _Shininess("Power Slider", Range(0.01, 1)) = 0.08

	// An integer slider for specified range (0 to 255)
	[IntRange] _Alpha("Int Range", Range(0, 255)) = 100

	// Default small amount of space.
	[Space] _Prop1("Small amount of space", Float) = 0

	// Large amount of space.
	[Space(50)] _Prop2("Large amount of space", Float) = 0



	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		Pass
	{
		CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile _INVERT_ON _INVERT_OFF

#include "UnityCG.cginc"

		struct appdata
	{
		float4 vertex : POSITION;
		float2 uv : TEXCOORD0;
	};

	struct v2f
	{
		float2 uv : TEXCOORD0;
		float4 vertex : SV_POSITION;
	};

	sampler2D _MainTex;
	float4 _MainTex_ST;
	bool _Fancy;

	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = UnityObjectToClipPos(v.vertex);
		o.uv = TRANSFORM_TEX(v.uv, _MainTex);
		return o;
	}

	fixed4 frag(v2f i) : SV_Target
	{
		fixed4 col = tex2D(_MainTex, i.uv);
	return col;
	}
		ENDCG
	}
	}
}

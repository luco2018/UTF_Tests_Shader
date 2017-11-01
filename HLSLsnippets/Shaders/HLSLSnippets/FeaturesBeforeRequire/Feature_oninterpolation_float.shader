﻿Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/interpolation float"
{
	Properties
	{
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
			#include "UnityCG.cginc"

		struct appdata
		{
			float4 vertex : POSITION;
		};

		struct v2f
		{
			float4 vertex : SV_POSITION;
			nointerpolation float4 color : COLOR;
		};

		v2f vert(appdata v)
		{
			v2f o;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.color = v.vertex;

			return o;
		}

		fixed4 frag(v2f i) : SV_Target
		{
			return i.color;
		}
		ENDCG
	}
	}
}

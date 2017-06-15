﻿Shader "FTPCustom/Surface/Input worldRefl INTERNAL"
{
	Properties
	{
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
#pragma surface surf Standard fullforwardshadows
#pragma target 3.0

		struct Input
	{
		float3 worldRefl;
		INTERNAL_DATA
	};

	void surf(Input IN, inout SurfaceOutputStandard o)
	{
		fixed4 final = fixed4(IN.worldRefl,1);

		o.Albedo = final.rgb;
		o.Alpha = final.a;
		o.Normal = UnpackNormal(1);
	}
	ENDCG
	}
}

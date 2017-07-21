Shader "FTPCustom/Surface/Input worldNormal"
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
		float3 worldNormal;
	};

	void surf(Input IN, inout SurfaceOutputStandard o)
	{
		fixed4 final = fixed4(IN.worldNormal,1);

		o.Albedo = final.rgb;
		o.Alpha = final.a;
	}
	ENDCG
	}
}

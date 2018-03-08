Shader "FTPCustom/Surface/Input worldNormal INTERNAL"
{
	Properties
	{
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
#pragma surface surf Unlit fullforwardshadows
#pragma target 3.0

	struct Input
	{
		float3 worldNormal;
		INTERNAL_DATA
	};

         half4 LightingUnlit (SurfaceOutput s, half3 lightDir, half atten) 
		 {
           half4 c;
           c.rgb = s.Albedo;
           c.a = s.Alpha;
           return c;
         }

	void surf(Input IN, inout SurfaceOutput o)
	{
		float3 final = IN.worldNormal;

		o.Albedo = 0;
		o.Alpha = 1;
		o.Normal = final;
		o.Emission = final;
	}
	ENDCG
	}
}

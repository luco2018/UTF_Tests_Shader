Shader "FTPCustom/Surface/Input worldRefl INTERNAL"
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
		float3 worldRefl;
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
		fixed4 final = fixed4(IN.worldRefl,1);

		o.Albedo = 0;
		o.Alpha = final.a;
		o.Normal = UnpackNormal(1);
		o.Emission = final.rgb;
	}
	ENDCG
	}
}

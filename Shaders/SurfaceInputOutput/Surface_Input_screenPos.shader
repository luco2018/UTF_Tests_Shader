﻿Shader "FTPCustom/Surface/Input screenPos"
{
	Properties 
	{
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Unlit fullforwardshadows
		#pragma target 3.0

		struct Input 
		{
			float4 screenPos;
		};

         half4 LightingUnlit (SurfaceOutput s, half3 lightDir, half atten) 
		 {
           half4 c;
           c.rgb = s.Albedo;
           c.a = s.Alpha;
           return c;
         }

		void surf (Input IN, inout SurfaceOutput o) 
		{
			fixed4 final = IN.screenPos;

			o.Albedo = 0;
			o.Alpha = final.a;
			o.Emission = final.rgb;
		}
		ENDCG
	}
}

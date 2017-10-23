Shader "FTPCustom/Surface/Input screenPos"
{
	Properties 
	{
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		struct Input 
		{
			float4 screenPos;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 final = IN.screenPos;

			o.Albedo = final.rgb;
			o.Alpha = final.a;
		}
		ENDCG
	}
}

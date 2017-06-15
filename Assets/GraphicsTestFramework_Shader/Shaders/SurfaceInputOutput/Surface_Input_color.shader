Shader "FTPCustom/Surface/Input color"
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
			float4 color : COLOR;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 final = IN.color;

			o.Albedo = final.rgb;
			o.Alpha = final.a;
		}
		ENDCG
	}
}

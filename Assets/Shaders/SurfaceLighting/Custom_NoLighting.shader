Shader "FTPCustom/Lighting/Custom NoLighting"
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf NoLighting fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;


        fixed4 LightingNoLighting(SurfaceOutput s, fixed3 lightDir, fixed atten)
         {
             fixed4 c;
             c.rgb = s.Albedo; 
             c.a = s.Alpha;
             return c;
         }

		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
}

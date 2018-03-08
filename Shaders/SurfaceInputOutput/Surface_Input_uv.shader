Shader "FTPCustom/Surface/Input uv"
{
	Properties 
	{
		_Color2 ("Color2", Color) = (1,1,1,1)
		_MainTex2 ("Albedo2 (RGB)", 2D) = "white" {}

		_Color3("Color3", Color) = (1,1,1,1)
		_MainTex3 ("Albedo3 (RGB)", 2D) = "white" {}

		_Color4("Color4", Color) = (1,1,1,1)
		_MainTex4 ("Albedo4 (RGB)", 2D) = "white" {}
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Unlit fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex2;
		sampler2D _MainTex3;
		sampler2D _MainTex4;

		struct Input 
		{
			float2 uv2_MainTex2;
			float2 uv3_MainTex3;
			float2 uv4_MainTex4;
		};

         half4 LightingUnlit (SurfaceOutput s, half3 lightDir, half atten) 
		 {
           half4 c;
           c.rgb = s.Albedo;
           c.a = s.Alpha;
           return c;
         }

		half _Glossiness;
		half _Metallic;
		fixed4 _Color2;
		fixed4 _Color3;
		fixed4 _Color4;

		void surf (Input IN, inout SurfaceOutput o) 
		{
			fixed4 c2 = tex2D(_MainTex2, IN.uv2_MainTex2) + _Color2;
			fixed4 c3 = tex2D(_MainTex3, IN.uv3_MainTex3) + _Color3;
			fixed4 c4 = tex2D(_MainTex4, IN.uv4_MainTex4) + _Color4;

			fixed4 final = c2  * c3  * c4 ;

			o.Albedo = final.rgb;
			o.Alpha = final.a;
		}
		ENDCG
	}
}

Shader "FTPCustom/Surface/Output"
{
	Properties 
	{
		
		_MainTex ("Albedo Alpha", 2D) = "white" {}
		_NormalTex("Normal", 2D) = "white" {}
		_EmissionColor("Emission", Color) = (1,1,1,1)
		_Glossiness ("Gloss", Range(0,1)) = 0.5
		_Specular ("Specular", Range(0,1)) = 0.0
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf BlinnPhong fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NormalTex;

		struct Input 
		{
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Specular;
		fixed4 _EmissionColor;

		void surf (Input IN, inout SurfaceOutput o) 
		{
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

			o.Albedo = c.rgb; //float3
			o.Normal = UnpackNormal(tex2D (_NormalTex, IN.uv_MainTex)); //float3
			o.Gloss = _Glossiness; //float
			o.Specular = _Specular; //half
			o.Alpha = c.a; //float
			o.Emission = _EmissionColor; //half3
		}
		ENDCG
	}
}

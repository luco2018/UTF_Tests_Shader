Shader "TextureSampler3D/Macro Surf"
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 3D) = "white" {}
		[NoScaleOffset]_SamplerTex ("_SamplerTex (RGBA)", 3D) = "white" {}

		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0


	}
	SubShader 
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		ZWrite Off LOD 200 Cull Back
		Blend SrcAlpha OneMinusSrcAlpha //Alpha Blend
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows keepalpha vertex:vert
		#pragma target 5.0

		UNITY_DECLARE_TEX3D(_SamplerTex);
		UNITY_DECLARE_TEX3D_NOSAMPLER(_MainTex);

		struct Input 
		{
			float3 uvVol;
		};

		half _Glossiness;
		half _Metallic;

		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.uvVol = mul(unity_ObjectToWorld, v.vertex);
		}

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = fixed4(0,0,1,1); //Fallback Color

			float3 uv = (IN.uvVol + fixed3(0, 0.5, 0.5)) * 2;

				fixed4 blah = UNITY_SAMPLE_TEX3D(_SamplerTex, uv);
				c = UNITY_SAMPLE_TEX3D_SAMPLER(_MainTex, _SamplerTex, uv);
				c += blah * 0.0001f; // You must use the point sampler!

			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
}

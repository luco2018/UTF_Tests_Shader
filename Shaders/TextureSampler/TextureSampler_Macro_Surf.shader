Shader "TextureSampler/Macro Surf"
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		//
	[NoScaleOffset]_SamplerTex ("_SamplerTex (RGBA)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0


	}
	SubShader 
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		ZWrite Off LOD 200 Cull Back
		Blend SrcAlpha OneMinusSrcAlpha //Alpha Blend
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows keepalpha
		#pragma target 3.0

			UNITY_DECLARE_TEX2D(_SamplerTex);
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);



		struct Input 
		{
			float2 uv_MainTex;
		};




		half _Glossiness;
		half _Metallic;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = fixed4(0,0,1,1); //Fallback Color

				fixed4 blah = UNITY_SAMPLE_TEX2D(_SamplerTex,IN.uv_MainTex);
				c = UNITY_SAMPLE_TEX2D_SAMPLER(_MainTex,_SamplerTex,IN.uv_MainTex);
				c += blah * 0.0001f; // You must use the point sampler!


			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
}

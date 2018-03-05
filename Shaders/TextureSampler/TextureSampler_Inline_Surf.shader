Shader "TextureSampler/Inline Surf"
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
	}
		SubShader
		{
			Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
			ZWrite Off LOD 200 Cull Back
			Blend SrcAlpha OneMinusSrcAlpha //Alpha Blend

			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows keepalpha
			#pragma target 3.0

			//Surface shader doesn't recognise some of DX11 HLSL syntax
			#if defined (UNITY_COMPILER_HLSL) //&& SHADER_API_D3D11
				Texture2D _MainTex;
				SamplerState my_point_repeat_sampler;
			#else
				sampler2D _MainTex;
			#endif


		struct Input 
		{
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = fixed4(0,0,1,1); //Fallback Color

			#if defined (UNITY_COMPILER_HLSL) // && SHADER_API_D3D11
				//c = _MainTex.Sample(my_point_clamp_sampler, IN.uv_MainTex);
				SamplerState temp_sampler;
				temp_sampler = my_point_repeat_sampler;
				c = _MainTex.Sample(temp_sampler, IN.uv_MainTex);
			#else
				c = tex2D(_MainTex, IN.uv_MainTex);
			#endif

			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
}

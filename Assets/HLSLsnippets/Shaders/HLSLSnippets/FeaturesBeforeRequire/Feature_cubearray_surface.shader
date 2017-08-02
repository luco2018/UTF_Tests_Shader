Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/cubearray surface"
{
	Properties
	{
		//_Amount("Extrusion Amount", Range(-1,1)) = 0.5
		//_Color("Color", Color) = (1,1,1,1)
		//_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0

		[Header(CubeArray)]
		_MyArr("Tex", CubeArray) = "" {}
		_SliceRange("Slices", Range(0,16)) = 6
		_UVScale("UVScale", Float) = 1.0
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows vertex:vert
			//#pragma require cubearray
			#pragma target 4.6

			struct Input
			{
				float2 uv_MainTex;
				float4 uv_cubearray;
				float3 normal;
			};

			//sampler2D _MainTex;
			half _Glossiness;
			half _Metallic;
			//fixed4 _Color;
			float _Amount;
			float _SliceRange;
			float _UVScale;

			

			#if defined(UNITY_COMPILER_HLSL) && SHADER_API_D3D11
				UNITY_DECLARE_TEXCUBEARRAY(_MyArr);
			//#else
				//sampler2D _MainTex;
			#endif

			void vert(inout appdata_full v, out Input o)
			{
				UNITY_INITIALIZE_OUTPUT(Input,o);

				UNITY_SETUP_INSTANCE_ID(v);

				float4 wvertex = UnityObjectToClipPos(v.vertex);

				o.uv_cubearray.xy = (wvertex.xy + 0.5) * _UVScale;
				o.uv_cubearray.zw = (wvertex.zw + 0.5) * _SliceRange;
				//v.vertex.xyz += v.normal * _Amount;
				o.normal = v.normal;

			}

			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				fixed4 c = fixed4(1, 0, 0, 1);
				o.Normal = IN.normal;
				//fixed4 blah = UNITY_SAMPLE_TEX2D(_MainTex, IN.uv_MainTex);

				#if defined(UNITY_COMPILER_HLSL) && SHADER_API_D3D11
					c = UNITY_SAMPLE_TEXCUBEARRAY(_MyArr, IN.uv_cubearray);
					//c += blah * 0.0001f;
				//#else
					//c = tex2D(_MainTex, IN.uv_MainTex);
				#endif

				o.Albedo = c.rgb;
				o.Metallic = _Metallic;
				o.Smoothness = _Glossiness;
				o.Alpha = c.a;
				//o.Emission = 0;
				//o.Normal fixed3
				//o.Occlusion = 1;
			}
		ENDCG
	}
}

Shader "FTPCustom/HLSLSnippets/Require Macro SHADER_REQUIRE"
{
	Properties
	{
		//[Toggle(ENABLE_TOG1)] _Fancy1("enable both 1", Float) = 0
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//#pragma require geometry
			#pragma require geometry// : ENABLE_TOG1 //ENABLE_TOG2
			//#pragma shader_feature __ ENABLE_TOG1
			//#if defined(SHADER_REQUIRE_GEOMETRY)
				//#pragma geometry geom
			//#else
						//
			//#endif

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(1,0,0,1);

				#if defined(SHADER_REQUIRE_geometry)
					col = fixed4(0, 1, 0, 1);
				#endif

				return col;
			}
			ENDCG
		}
	}
}

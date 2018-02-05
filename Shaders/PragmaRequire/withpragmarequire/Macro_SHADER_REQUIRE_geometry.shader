Shader "FTPCustom/HLSLSnippets/Require Macro SHADER_REQUIRE geometry with pragma require"
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
			#pragma require geometry
			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry geom
			#include "UnityCG.cginc"

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
			
			[maxvertexcount(3)]
			void geom(triangle v2f i[3], inout TriangleStream<v2f> triangleStream)
			{
				v2f o;

				o.vertex = i[0].vertex;
				triangleStream.Append(o);

				o.vertex = i[1].vertex;
				triangleStream.Append(o);

				o.vertex = i[2].vertex;
				triangleStream.Append(o);
			}

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(1,0,0,1);

				#if defined(SHADER_REQUIRE_GEOMETRY)
					col = fixed4(0, 1, 0, 1);
				#endif

				return col;
			}
			ENDCG
		}
	}
}

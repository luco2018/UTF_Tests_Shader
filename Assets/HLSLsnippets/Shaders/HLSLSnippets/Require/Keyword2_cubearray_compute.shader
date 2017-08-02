//////////////////////////////////////////////////////////////////////////////
Shader "FTPCustom/HLSLSnippets/Keyword 2 cubearray compute"
{
	Properties
	{
		[Toggle(ENABLE_TOG1)] _Fancy1("enable either 1", Float) = 0
		[Toggle(ENABLE_TOG2)] _Fancy2("enable either 2", Float) = 0
		
		[Header(Compute)]
		_EmissionDistance("_Emission Distance", Float) = 2.0
		_EmissionColor("Emission Color", Color) = (0,0,0)

		[Header(Cubearray)]
		_MyArr("Tex", CubeArray) = "" {}
		_SliceRange("Slices", Range(0,16)) = 6
		_UVScale("UVScale", Float) = 1.0
	}

	SubShader
	{
		Pass
		{

		CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma require compute cubearray : ENABLE_TOG1 ENABLE_TOG2
			#pragma shader_feature __ ENABLE_TOG1
			#pragma shader_feature __ ENABLE_TOG2

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;


				float4 emissionPower : COLOR;
			};

			float _SliceRange;
			float _UVScale;

			#if defined(SHADER_REQUIRE_COMPUTE)
				struct myObjectStruct
				{
					float3 objPosition;
				};
				StructuredBuffer<myObjectStruct> myObjectBuffer;
				float _EmissionDistance;
				float4 _EmissionColor;
			#endif

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv.xy = (v.vertex.xy + 0.5) * _UVScale;
				o.uv.zw = (v.vertex.z + 0.5) * _SliceRange;

				#if defined(SHADER_REQUIRE_COMPUTE)
					o.emissionPower = 0;

					float4 wvertex = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1));
					float dist = abs(distance(myObjectBuffer[0].objPosition, wvertex.xyz));
					float power = 1 - clamp(dist / _EmissionDistance, 0.0f, 1.0f);
					o.emissionPower.r += power;

					dist = abs(distance(myObjectBuffer[1].objPosition, wvertex.xyz));
					power = 1 - clamp(dist / _EmissionDistance, 0.0f, 1.0f);
					o.emissionPower.r += power;
				#endif

				return o;
			}

			#if defined(SHADER_REQUIRE_CUBEARRAY)
				UNITY_DECLARE_TEXCUBEARRAY(_MyArr);
			#endif



			half4 frag(v2f i) : SV_Target
			{
				float4 col = fixed4(0,0,1,1);

				#if defined(SHADER_REQUIRE_CUBEARRAY)
					col = UNITY_SAMPLE_TEXCUBEARRAY(_MyArr, i.uv);
				#endif


				#if defined(SHADER_REQUIRE_COMPUTE)
					col = lerp(col, col*_EmissionColor, i.emissionPower.r);
				#endif

				return col;
			}

		ENDCG

		}
	}
}



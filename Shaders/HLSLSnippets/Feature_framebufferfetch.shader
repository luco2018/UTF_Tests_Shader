//https://gist.github.com/aras-p/ca86e6dddc46def4d1a8

Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/framebufferfetch"
{
	Properties
	{
	}

	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue"="Transparent"}
		LOD 100
		ZWrite Off

		Pass
		{
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert
			#pragma fragment frag
			

			struct appdata_t 
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f 
			{
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}

			void frag (v2f i, inout fixed4 ocol : SV_Target)
			{
				ocol = 1-ocol;
			}
			ENDCG
		}
	}
}



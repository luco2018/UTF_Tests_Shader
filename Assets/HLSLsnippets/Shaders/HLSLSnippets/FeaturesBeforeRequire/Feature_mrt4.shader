Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/mrt4"
{
	Properties
	{
		_MainTex("_MainTex (RGBA)", 2D) = "white" {}
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		Pass
		{
			CGPROGRAM
			#pragma target 3.5
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			struct frag_Out
			{
				fixed4 color0 : SV_Target0;
				fixed4 color1 : SV_Target1;
				fixed4 color2 : SV_Target2;
				fixed4 color3 : SV_Target3;
				//fixed4 color4 : SV_Target4;
				//fixed4 color5 : SV_Target5;
				//fixed4 color6 : SV_Target6;
				//fixed4 color7 : SV_Target7;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}

			frag_Out frag(v2f i)
			{
				frag_Out o;

				fixed4 col = tex2D(_MainTex, i.uv);

				o.color0 = col * fixed4(1, 0, 0, 1);
				o.color1 = col * fixed4(0, 1, 0, 1);
				o.color2 = col * fixed4(0, 0, 1, 1);
				o.color3 = col * fixed4(1, 1, 0, 1);
				//o.color4 = col * fixed4(0, 1, 1, 1);
				//o.color5 = col * fixed4(1, 0, 1, 1);
				//o.color6 = col * fixed4(0, 0, 0, 1);
				//o.color7 = col * fixed4(1, 1, 1, 1);

				return o;
			}
			ENDCG
		}
	}
}

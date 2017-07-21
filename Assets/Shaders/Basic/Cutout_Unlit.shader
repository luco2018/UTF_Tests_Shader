Shader "FTPCustom/Basic/Cutout/Unlit"
{
	Properties
	{
		[Enum(Off,0,Front,1,Back,2)] _CullMode ("Culling Mode", int) = 0
		_Cutoff ("Alpha Cutoff", Range(0,1)) = 0.5
		_MainTex ("_MainTex (RGBA)", 2D) = "white" {}
	}
	SubShader
	{
		Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
		Cull [_CullMode] Lighting Off ZWrite On

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				fixed4 color : COLOR;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed _Cutoff;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv) * i.color;

				clip (col.a - _Cutoff);

				return col;
			}
			ENDCG
		}
	}
}

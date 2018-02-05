Shader "FTPCustom/tex2dms"
{
	Properties
	{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		[IntRange] _Size("Size",Range(0,1024)) = 256
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			//#pragma target 4.5
			#pragma require msaatex
			#pragma vertex vert
			#pragma fragment frag

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			Texture2DMS<float4> _MainTex;
			int _Size;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//Reads texel data without any filtering or sampling
				fixed4 col = _MainTex.Load(int2(i.uv * _Size), 0);
				return col;
			}
			ENDCG
		}
	}
}

Shader "FTPCustom/HLSLSnippets/Require Macro SHADER_AVAILABLE compute"
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

				#if defined(SHADER_AVAILABLE_COMPUTE)
					col = fixed4(0, 1, 0, 1);
				#endif

				return col;
			}
			ENDCG
		}
	}
}

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "FTPCustom/Feature/Variant MultiCompile"
{
Properties 
{
	_MainTex ("_MainTex RGBA", 2D) = "white" {}

	[Header(BlendModes)]
	//[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Source", Int) = 1.0
	[Enum(Additive,1,AlphaBlend,10)] _DstBlend ("Desination Blend Options", Int) = 0
	//[Enum(UnityEngine.Rendering.BlendOp)] _BlendOpFactor ("Blend Operation", Int) = 0

    _Color ("Color", Color) = (1,1,1,1)

    [Header(ColorOperation (SELECT ONLY 1))]
	[Toggle(INPUT_COLOR_CHANGE)] _UseChangeColor ("Change Color", Float) = 1
	[Toggle(INPUT_COLOR_MULTIPLY)] _UseInputColorMul ("Multiply Color", Float) = 1
	[Toggle(INPUT_COLOR_ADDITIVE)] _UseInputColorAdd ("Additive Color", Float) = 0
	[Toggle(INPUT_COLOR_BLEND)] _UseInputColorBld ("Blend Color", Float) = 0
}

Category 
{
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha [_DstBlend]
	//BlendOp [_BlendOpFactor]
	Cull Off Lighting Off ZWrite Off
	Lighting Off
	
	SubShader 
	{
		Pass 
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile __ INPUT_COLOR_CHANGE
			#pragma multi_compile __ INPUT_COLOR_MULTIPLY
			#pragma multi_compile __ INPUT_COLOR_ADDITIVE
			#pragma multi_compile __ INPUT_COLOR_BLEND

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			fixed4 _MainTex_ST;
            fixed4 _Color;

			struct appdata_t 
			{
				fixed4 vertex : POSITION;
				fixed2 texcoord : TEXCOORD0;
			};

			struct v2f 
			{
				fixed4 vertex : SV_POSITION;
				fixed2 texcoord : TEXCOORD0;
			};

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord =  TRANSFORM_TEX(v.texcoord, _MainTex);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 color = tex2D(_MainTex,i.texcoord);

				//Color Change
				#ifdef INPUT_COLOR_CHANGE
					color.rgb = lerp(1,_Color.rgb,color.r);
				#endif

				//Multiply
				#ifdef INPUT_COLOR_MULTIPLY
					color.rgb *= _Color.rgb;
				#endif

				//Additive
				#ifdef INPUT_COLOR_ADDITIVE
					color.rgb += _Color.rgb;
				#endif

				//Blend
				#ifdef INPUT_COLOR_BLEND
					color.rgb = lerp(color.rgb,_Color.rgb,_Color.a);
				#endif
				//

				color.a *= _Color.a;

				return color;
			}
			ENDCG 
		}
	}	
}
}

Shader "FTPCustom/Transparent/Surface decal blend"
{
	Properties 
	{
		//[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("Source", Int) = 1.0
		//[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("Destination", Int) = 1.0
		//[Enum(UnityEngine.Rendering.BlendOp)] _BlendOp("BlendOp", Int) = 1.0
		_Color("Main Color", Color) = (1,1,1,1)
		_TintColor("Tint Color", Color) = (0,0,0,0)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader 
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		ZWrite Off
		LOD 200

		//Blend [_SrcBlend] [_DstBlend] //Additive
		//BlendOp [_BlendOp]
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows decal:blend
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input 
		{
			float2 uv_MainTex;
			//float4 color : COLOR;
		};

		half _Glossiness;
		half _Metallic;
		float4 _Color;
		float4 _TintColor;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color + _TintColor;

			c *= c.a; //premultiplied

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

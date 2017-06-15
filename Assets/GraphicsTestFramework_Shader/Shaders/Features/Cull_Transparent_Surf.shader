Shader "FTPCustom/Feature/Cull Surf"
{
	Properties 
	{
        [Enum(Off,0,Front,1,Back,2)] _CullMode ("Culling Mode", int) = 0
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader 
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		ZWrite Off Cull [_CullMode]
		LOD 200
		Blend SrcAlpha OneMinusSrcAlpha //Alpha Blend
		//Blend SrcAlpha One //Additive
		//Blend SrcAlpha One BlendOp RevSub //Multiply c.rgb = 1-c.rgb;
		//Blend OneMinusDstColor OneMinusSrcAlpha //Invert c *= c.a;
		//Blend One OneMinusSrcAlpha //Additive + Alpha Blend c *= c.a;
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows keepalpha
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input 
		{
			float2 uv_MainTex;
			float4 color : COLOR;
		};

		half _Glossiness;
		half _Metallic;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * IN.color;

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

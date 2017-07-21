Shader "FTPCustom/Instancing/Surface"
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows addshadow
		#pragma multi_compile_instancing
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input 
		{
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;

		//D3D 64KB * 500 Objects OPENGL 16KB * 125 Objects
		UNITY_INSTANCING_CBUFFER_START(Props)
		UNITY_DEFINE_INSTANCED_PROP(fixed4, _Color)
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * UNITY_ACCESS_INSTANCED_PROP(_Color);

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

//MaterialPropertyBlock props = new MaterialPropertyBlock();
//MeshRenderer renderer;

//foreach (GameObject obj in objects)
//{
  // float r = Random.Range(0.0f, 1.0f);
  // float g = Random.Range(0.0f, 1.0f);
  // float b = Random.Range(0.0f, 1.0f);
  // props.SetColor("_Color", new Color(r, g, b));
   
  // renderer = obj.GetComponent<MeshRenderer>();
  // renderer.SetPropertyBlock(props);
//}
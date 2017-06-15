// Upgrade NOTE: replaced 'UNITY_INSTANCE_ID' with 'UNITY_VERTEX_INPUT_INSTANCE_ID'

Shader "FTPCustom/Instancing/Unlit half2"
{
	Properties
	{
		//_Color ("Color", Color) = (1, 1, 1, 1)
		_MainTex ("_MainTex (RGBA)", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 200

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			//D3D 64KB * 500 Objects OPENGL 16KB * 125 Objects
			UNITY_INSTANCING_CBUFFER_START (MyProperties)

			//UNITY_DEFINE_INSTANCED_PROP(fixed, _Fixed)
			//UNITY_DEFINE_INSTANCED_PROP(fixed2, _Fixed2)
			//UNITY_DEFINE_INSTANCED_PROP(fixed3, _Fixed3)
			//UNITY_DEFINE_INSTANCED_PROP(fixed4, _Fixed4)
			//UNITY_DEFINE_INSTANCED_PROP(fixed4x4, _Fixed4x4)

			//UNITY_DEFINE_INSTANCED_PROP(half, _Half)
			UNITY_DEFINE_INSTANCED_PROP(half2, _Half2)
			//UNITY_DEFINE_INSTANCED_PROP(half3, _Half3)
			//UNITY_DEFINE_INSTANCED_PROP(half4, _Half4)
			//UNITY_DEFINE_INSTANCED_PROP(half4x4, _Half4x4)

			//UNITY_DEFINE_INSTANCED_PROP(float, _Float)
			//UNITY_DEFINE_INSTANCED_PROP(float2, _Float2)
			//UNITY_DEFINE_INSTANCED_PROP(float3, _Float3)
			//UNITY_DEFINE_INSTANCED_PROP(float4, _Float4)
			//UNITY_DEFINE_INSTANCED_PROP(float4x4, _Float4x4)

			//UNITY_DEFINE_INSTANCED_PROP(int, _Int)
			//UNITY_DEFINE_INSTANCED_PROP(int2, _Int2)
			//UNITY_DEFINE_INSTANCED_PROP(int3, _Int3)
			//UNITY_DEFINE_INSTANCED_PROP(int4, _Int4)
			//UNITY_DEFINE_INSTANCED_PROP(int4x4, _Int4x4)

            //UNITY_DEFINE_INSTANCED_PROP (float4, _Color)
            UNITY_INSTANCING_CBUFFER_END
			
			v2f vert (appdata v)
			{
				v2f o;

				UNITY_SETUP_INSTANCE_ID (v);
                UNITY_TRANSFER_INSTANCE_ID (v, o); //if need to use instance in frag

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID (i); //optional for frag

				fixed4 col = tex2D(_MainTex, i.uv) * half4(UNITY_ACCESS_INSTANCED_PROP (_Half2),0,1);
			
				return col;
			}
			ENDCG
		}
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
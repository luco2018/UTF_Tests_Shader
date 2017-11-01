// Upgrade NOTE: replaced 'UNITY_INSTANCE_ID' with 'UNITY_VERTEX_INPUT_INSTANCE_ID'

Shader "FTPCustom/Instancing/Unlit FloatArray"
{
	Properties
	{
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
			//#pragma multi_compile_instancing

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				//UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				//UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;


			//D3D 64KB * 500 Objects OPENGL 16KB * 125 Objects
			//UNITY_INSTANCING_CBUFFER_START (MyProperties)
			//UNITY_DEFINE_INSTANCED_PROP(float, _ColorArr[4])
            //UNITY_INSTANCING_CBUFFER_END
			
			v2f vert (appdata v)
			{
				v2f o;

				//UNITY_SETUP_INSTANCE_ID (v);
                //UNITY_TRANSFER_INSTANCE_ID (v, o); //if need to use instance in frag

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//UNITY_SETUP_INSTANCE_ID (i); //optional for frag

				fixed4 col = tex2D(_MainTex, i.uv);

				//float ca[4];
				/*
				ca[0] = 1;
				ca[1] = 1;
				ca[2] = 0;
				ca[3] = 0;
				*/
				
				//ca[0] = UNITY_ACCESS_INSTANCED_PROP(_ColorArr[0]);
				//ca[1] = UNITY_ACCESS_INSTANCED_PROP(_ColorArr[1]);
				//ca[2] = UNITY_ACCESS_INSTANCED_PROP(_ColorArr[2]);
				//ca[3] = UNITY_ACCESS_INSTANCED_PROP(_ColorArr[3]);

				//col = float4(ca[0], ca[1], ca[2], ca[3]);

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
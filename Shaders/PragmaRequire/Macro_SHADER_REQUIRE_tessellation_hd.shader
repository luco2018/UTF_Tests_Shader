Shader "FTPCustom/HLSLSnippets/Require Macro SHADER_REQUIRE tessellation"
{
	Properties
	{
		_TessEdge ("Edge Tess", Range(1,64)) = 2
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
			#pragma hull HS
    		#pragma domain DS

			float _TessEdge;

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

    		struct HS_ConstantOut
    		{
       			float TessFactor[3]    : SV_TessFactor;
        		float InsideTessFactor : SV_InsideTessFactor;
    		};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = v.vertex;
				return o;
			}

    		HS_ConstantOut HSConstant( InputPatch<v2f, 3> i )
    		{
        		HS_ConstantOut o = (HS_ConstantOut)0;
        		o.TessFactor[0] = o.TessFactor[1] = o.TessFactor[2] = _TessEdge;
        		o.InsideTessFactor = _TessEdge;    
        		return o;
    		}

    		[domain("tri")]
    		[partitioning("integer")]
    		[outputtopology("triangle_cw")]
    		[patchconstantfunc("HSConstant")]
    		[outputcontrolpoints(3)]
    		v2f HS( InputPatch<v2f, 3> i, uint uCPID : SV_OutputControlPointID )
    		{
        		v2f o = (v2f)0;
        		o.vertex = i[uCPID].vertex;
        		return o;
    		}
    
    		[domain("tri")]
    		v2f DS( HS_ConstantOut HSConstantData, 
    					const OutputPatch<v2f, 3> i, 
    					float3 BarycentricCoords : SV_DomainLocation)
    		{
        		v2f o = (v2f)0;

				float fU = BarycentricCoords.x;
        		float fV = BarycentricCoords.y;
        		float fW = BarycentricCoords.z;

        		float4 vertex = i[0].vertex * fU + i[1].vertex * fV + i[2].vertex * fW;
				o.vertex = UnityObjectToClipPos(float4(vertex.xyz,1));

        		return o;
    		}

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(1,0,0,1);

				#if defined(SHADER_REQUIRE_TESSELLATION)
					col = fixed4(0, 1, 0, 1);
				#endif

				return col;
			}
			ENDCG
		}
	}
}

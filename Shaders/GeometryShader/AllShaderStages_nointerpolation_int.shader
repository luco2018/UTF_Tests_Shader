// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "FTPCustom/ShaderStages/All nointerpolation int" 
{
    Properties 
	{
		[Header(VertexDisplace)]
		_VDist("Vert Distplace", Range(0,1)) = 0.1

		[Header(Color)]
		_FillColor("FillColor", Color) = (0,0,0,0)
        _TessEdge ("Edge Tess", Range(1,64)) = 2

		[Header(Extra)]
		[IntRange] _Steps("_Steps", Range(1,10)) = 1
		_Length("_Length", Range(0,5)) = 1
		_Width("_Width", Range(0,5)) = 1
		_Gravity("_Gravity", Range(0,5)) = 1

    }
    SubShader 
	{
    	Pass 
		{
     
    		CGPROGRAM
    		#pragma target 5.0
     
    		#pragma vertex VS
    		#pragma fragment PS
    		#pragma hull HS
    		#pragma domain DS
			#pragma geometry GS
    		
    		#pragma enable_d3d11_debug_symbols
     
    		//#include "UnityCG.cginc"
			float _VDist;
    		float _TessEdge;
			uniform fixed4 _FillColor;
			//Extra
			float _Length;
			float _Width;
			float _Gravity;
			int _Steps;

    		struct VS_In
    		{
        		float3 vertex : POSITION;
				float4 nor : NORMAL;
    		};
     
    		struct HS_In
    		{
        		float4 pos   : POS;
				float4 nor : NORMAL;
				int4 color : COLOR;
    		};
     
    		struct HS_ConstantOut
    		{
       			float TessFactor[3]    : SV_TessFactor;
        		float InsideTessFactor : SV_InsideTessFactor;
    		};
     
    		struct HS_Out
    		{
        		float3 pos    : POS;
				float4 nor : NORMAL;
				int4 color : COLOR;
    		};
     
    		struct DS_Out
    		{
        		float4 pos   : SV_Position;
				float4 nor : NORMAL;
				float4 lpos : TEXCOORD1;
				int4 color : COLOR;
    		};
     
			struct GS_Out
			{
				float4 pos   : SV_Position;
				int4 color : COLOR;
			};

    		struct FS_Out
    		{		
        		fixed4 color      : SV_Target0;
    		};     
     
    		HS_In VS( VS_In i )
    		{
        		HS_In o;
				o.pos = float4(i.vertex, 1);
				o.pos += i.nor * _VDist; //Vertex Displacement
				o.nor = i.nor;
				o.color = ceil(o.pos * 255);
        		return o;
    		}
    
    		HS_ConstantOut HSConstant( InputPatch<HS_In, 3> i )
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
    		HS_Out HS( InputPatch<HS_In, 3> i, uint uCPID : SV_OutputControlPointID )
    		{
        		HS_Out o = (HS_Out)0;
        		o.pos = i[uCPID].pos.xyz;
				o.nor = i[uCPID].nor;
				o.color = i[uCPID].color;
        		return o;
    		}
    
    		[domain("tri")]
    		DS_Out DS( HS_ConstantOut HSConstantData, 
    					const OutputPatch<HS_Out, 3> i, 
    					float3 BarycentricCoords : SV_DomainLocation)
    		{
        		DS_Out o = (DS_Out)0;
     
        		float fU = BarycentricCoords.x;
        		float fV = BarycentricCoords.y;
        		float fW = BarycentricCoords.z;

				float3 nor = i[0].nor * fU + i[1].nor * fV + i[2].nor * fW;
				o.nor = float4(nor.xyz, 0.0);

        		float3 pos = i[0].pos * fU + i[1].pos * fV + i[2].pos * fW;
				o.lpos = float4(pos, 1); // local position
        		o.pos = UnityObjectToClipPos (float4(pos.xyz,1.0));
				
				o.color = i[0].color * fU + i[1].color * fV + i[2].color * fW;

        		return o;
    		}

			[maxvertexcount(20)] //original is 3, now is _Steps*4+3
			void GS(triangle DS_Out i[3], inout TriangleStream<GS_Out> triangleStream)
			{
				float2 p0 = i[0].pos.xy / i[0].pos.w;
				float2 p1 = i[1].pos.xy / i[1].pos.w;
				float2 p2 = i[2].pos.xy / i[2].pos.w;

				GS_Out o;
				o.pos = i[0].pos;
				o.color = i[0].color;
				triangleStream.Append(o);

				o.pos = i[1].pos;
				o.color = i[1].color;
				triangleStream.Append(o);

				o.pos = i[2].pos;
				o.color = i[2].color;
				triangleStream.Append(o);

				//=========================================Extra
				float4 P0 = i[0].lpos;
				float4 P1 = i[1].lpos;
				float4 P2 = i[2].lpos;

				float4 N0 = i[0].nor;
				float4 N1 = i[1].nor;
				float4 N2 = i[2].nor;


				float4 P = (P0 + P1 + P2) / 3.0f;
				float4 N = (N0 + N1 + N2) / 3.0f;
				float4 T = float4(normalize((P1 - P0).xyz), 0.0f);

				for (int j = 0; j < _Steps; j++)
				{
					float T0 = (float)j / _Steps;
					float T1 = (float)(j + 1) / _Steps;

					// Make our normal bend down with gravity.
					float4 PP0 = normalize(N - (float4(0, _Length * T0, 0, 0) * _Gravity * T0)) * (_Length * T0);
					float4 PP1 = normalize(N - (float4(0, _Length * T1, 0, 0) * _Gravity * T1)) * (_Length * T1);

					// Interpolate the width, and scale the lateral direction vector with it
					float4 W0 = T * lerp(_Width, 0, T0);
					float4 W1 = T * lerp(_Width, 0, T1);

					o.pos = PP0 - W0;
					o.pos += P; //position it to the polygon center
					o.color = ceil(o.pos * 255);
					o.pos = UnityObjectToClipPos(float4(o.pos.xyz, 1.0));
					triangleStream.Append(o);

					o.pos = PP0 + W0;
					o.pos += P;
					o.color = ceil(o.pos * 255);
					o.pos = UnityObjectToClipPos(float4(o.pos.xyz, 1.0));
					triangleStream.Append(o);

					o.pos = PP1 - W1;
					o.pos += P;
					o.color = ceil(o.pos * 255);
					o.pos = UnityObjectToClipPos(float4(o.pos.xyz, 1.0));
					triangleStream.Append(o);

					o.pos = PP1 + W1;
					o.pos += P;
					o.color = ceil(o.pos * 255);
					o.pos = UnityObjectToClipPos(float4(o.pos.xyz, 1.0));
					triangleStream.Append(o);
				}
			}
     
    		FS_Out PS(GS_Out i)
    		{
        		FS_Out o;

				o.color = _FillColor * (i.color / 255.0f);
 
       			return o;
    		}
     
    		ENDCG
    	}
    }
}
Shader "FTPCustom/Lighting/Custom SimilarSpecular"
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf SimpleSpecular fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;

        half4 LightingSimpleSpecular (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) 
        {
            half3 h = normalize (lightDir + viewDir);

            half diff = max (0, dot (s.Normal, lightDir));

            float nh = max (0, dot (s.Normal, h));
            float spec = pow (nh, 48.0);

            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
            c.a = s.Alpha;
            return c;
        }


		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
}

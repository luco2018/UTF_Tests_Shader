Shader "FTPCustom/Feature/Outline Multipass Surface"
{
    Properties 
    {
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _Outline ("Outline width", Range (0, 0.1)) = .005
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader 
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        //==============================================

        Cull Front
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert
        #pragma target 3.0

        struct Input 
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float _Amount;
        uniform float _Outline;
        uniform float4 _OutlineColor;

        void vert (inout appdata_full v, out Input o) 
        {
              UNITY_INITIALIZE_OUTPUT(Input,o);

              UNITY_SETUP_INSTANCE_ID (v);

            v.vertex.xyz += v.normal * _Outline;
        }

        void surf (Input IN, inout SurfaceOutputStandard o) 
        {
            o.Albedo = _OutlineColor.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = _OutlineColor.a;
            //o.Emission = 0;
            //o.Normal fixed3
            //o.Occlusion = 1;
        }
        ENDCG

        //==============================================

        Cull Back
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input 
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o) 
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

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

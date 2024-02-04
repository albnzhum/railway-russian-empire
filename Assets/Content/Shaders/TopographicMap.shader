Shader "Custom/TerrainBorderBlur"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" { }
        _BorderTexture ("Border Texture", 2D) = "white" { }
        _BlurSize ("Blur Size", Range(0, 10)) = 1.0
        _TransitionDistance ("Transition Distance", Range(0, 100)) = 10.0
        
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        CGPROGRAM
        #pragma surface surf Lambert terrain geometry

        sampler2D _MainTex;
        sampler2D _BorderTexture;
        float _BlurSize;
        float _TransitionDistance;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            float borderAlpha = tex2D(_BorderTexture, IN.uv_MainTex).r;
            float fadeFactor = 1.0 - smoothstep(0, _TransitionDistance, borderAlpha);

            // Apply texture and blur based on distance to the border
            float4 baseColor = tex2D(_MainTex, IN.uv_MainTex);
            float4 blurredColor = baseColor;

            for (float i = -_BlurSize; i <= _BlurSize; i += 1.0)
            {
                for (float j = -_BlurSize; j <= _BlurSize; j += 1.0)
                {
                    float2 offset = float2(i, j) * 0.01 * _BlurSize;
                    blurredColor += tex2D(_MainTex, IN.uv_MainTex + offset);
                }
            }

            blurredColor /= ((_BlurSize * 2.0 + 1.0) * (_BlurSize * 2.0 + 1.0));

            // Blend between the original texture and the blurred one
            o.Albedo = lerp(baseColor.rgb, blurredColor.rgb, fadeFactor);
            o.Alpha = baseColor.a;
        }
        ENDCG
    }

    FallBack "Diffuse"
}

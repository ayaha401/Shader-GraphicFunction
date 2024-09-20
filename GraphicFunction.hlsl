#ifndef GRAPHIC_FUNCTION
#define GRAPHIC_FUNCTION

// フレネル反射
float fresnel(float3 worldViewDir, float3 normalWS)
{
    float f0 = 0.02;
    return f0 + (1 - f0) * pow((1 - dot(worldViewDir, normalWS)), 5);
}

// 放射状にブラーをする
// まだ最適化されてないコード
half3 radialBlur(sampler2D tex, float2 uv, float blurWidth, int sampleCount = 100, float2 center = float2(0.5, 0.5))
{
    half3 resultColor = half3(0.0, 0.0, 0.0);
    float2 ray = uv - center;
    for (int i = 0; i < sampleCount; i++)
    {
        float scale = 1.0 - blurWidth * (float(i) / float(sampleCount - 1.0));
        resultColor += tex2D(tex, (ray * scale) + center).xyz;
    }
    resultColor /= float(sampleCount);
    return resultColor;
}

#endif

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

// MatCapを表現する
// 画面端で歪まないように補正されている
// https://qiita.com/marv_kurushimay/items/7d49e503f69ba74df427
// blend_RNMを使用しているためMathFunction.hlslを先に読み込む必要がある
half3 matCap(sampler2D tex, float3 cameraViewCS, float3 normalCS)
{
    float3 matCapViewCS = cameraViewCS * float3(-1, -1, 1);
    float2 matCapUV = blend_RNM(matCapViewCS, normalCS).xy * .5 + .5;
    return tex2D(tex, matCapUV);
}

#endif

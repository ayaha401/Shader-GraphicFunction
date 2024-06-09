#ifndef GRAPHIC_FUNCTION
#define GRAPHIC_FUNCTION

// フレネル反射
float fresnel(float3 worldViewDir, float3 normalWS)
{
    float f0 = 0.02;
    return f0 + (1 - f0) * pow((1 - dot(worldViewDir, normalWS)), 5);
}

#endif

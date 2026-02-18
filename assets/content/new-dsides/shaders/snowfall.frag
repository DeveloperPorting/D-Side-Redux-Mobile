#pragma header

uniform float intensity;
uniform int amount;
uniform float time;

vec2 uv;

float rnd(float x) {
    return fract(sin(dot(vec2(x + 48.0, 38.0 / (x + 2.5)), vec2(13.0, 78.0))) * (43758.0));
}

float drawCircle(vec2 center, float radius) {
    return 1.0 - smoothstep(0.0, radius, length(uv - center));
}

void main()
{
    uv = vec2(openfl_TextureCoordv.x * 2.0, openfl_TextureCoordv.y);
    gl_FragColor = texture2D(bitmap, openfl_TextureCoordv);
    
    float fAmount = float(amount);

    for(int i = 0; i < amount; i++) {
        float fI = float(i);
        float j = fI * 2.0;
        float realIntensity = intensity * 1.0;
        
        float speed = (0.3 + rnd(cos(j)) * (0.7 + 0.5 * cos(j / (fAmount * 0.25))));
        
        vec2 centerPos = vec2(((0.5 - uv.y) * realIntensity + rnd(j) + 0.1 * (cos(time + sin(j)))) * 2.0, 
              mod(sin(j) + speed * (time * 1.5 * (0.1 + realIntensity)), 1.0));
        
        float radius = 0.001 + speed * (intensity / (0.2 / 1.5)) * 0.012;
        
        gl_FragColor += vec4(0.45 * drawCircle(centerPos, radius));
    }
}
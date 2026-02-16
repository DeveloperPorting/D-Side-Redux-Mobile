#pragma header

uniform float inf;

void main(){
    vec4 col = flixel_texture2D(bitmap, openfl_TextureCoordv);
    gl_FragColor = mix(col, vec4(192.0 / 255.0, 106.0 / 255.0, 230.0 / 255.0, 1.) * col.a, inf);
}
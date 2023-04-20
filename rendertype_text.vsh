#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;

	// Removes XP Number Display
	vec2 ScrSize = 2 / vec2(ProjMat[0][0], -ProjMat[1][1]);
	vec3 isXpGreen = abs(Color.rgb - vec3(0x7e, 0xfc, 0x20) / 255);
	if (Position.z == 0 && Position.y >= ScrSize.y - 36 && Position.y <= ScrSize.y - 25 && (abs(Position.x - ScrSize.x / 2) <= 33 && (Color.rgb == vec3(0, 0, 0) || (isXpGreen.r < 0.1 && isXpGreen.g < 0.1 && isXpGreen.b < 0.1))) && Color.a == 1) gl_Position = vec4(0);
}

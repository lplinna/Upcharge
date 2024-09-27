shader_type canvas_item;
uniform vec4 line_color: source_color = vec4(1.0);
uniform float line_thickness: hint_range(0,20) = 1.0;
uniform int glow_coverage: hint_range(0,32) = 4;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	float outline = 0.0;
	for(int i = 0; i < 900; i++)
	{
		float radians360 = 6.28;
		float angle = (radians360/float(glow_coverage)) * float(i+1);
		vec2 pixel_coor = vec2(sin(angle),cos(angle));
		outline += texture(TEXTURE,UV + size * pixel_coor).a;
	}
	
	
	
	outline = min(outline,1.0);
	
	// Called for every pixel the material is visible on.
	vec4 color = texture(TEXTURE,UV);
	COLOR = mix(color,line_color, outline - color.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

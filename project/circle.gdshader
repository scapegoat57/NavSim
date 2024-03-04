shader_type canvas_item;
varying flat vec4 modulate;

void vertex(){
	modulate=COLOR;
}

float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}


void fragment() {
	COLOR=mix(vec4(0,0,0,1), vec4(0), circle(UV, .49, .01));
	COLOR=mix(modulate,COLOR,circle(UV, .39, .05));
}


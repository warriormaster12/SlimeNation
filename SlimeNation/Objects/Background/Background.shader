shader_type canvas_item;
render_mode unshaded;
uniform vec4 color : hint_color = vec4(1.0f);

void fragment() {
	COLOR = color;
}
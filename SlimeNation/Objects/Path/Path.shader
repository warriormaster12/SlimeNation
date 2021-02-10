shader_type canvas_item;
uniform sampler2D emissionTexture;
uniform vec4 glowColor : hint_color = vec4(1.0f);

void fragment()
{
	vec4 current_color = texture(TEXTURE, UV);
	vec4 emission_color = texture(emissionTexture, UV);
	
	if(emission_color.r > 0f || emission_color.g > 0f || emission_color.b > 0f)
	{
		COLOR = emission_color + glowColor
	}
	else
	{
		COLOR = current_color;
	}
	
}
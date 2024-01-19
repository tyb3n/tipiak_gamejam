shader_type canvas_item;

//uniform sampler2D noise : repeat_enable;
uniform sampler2D noise1 : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
//uniform vec2 scroll = vec2(0.05, 0.05);
uniform vec2 scroll1 = vec2(0.05, 0.05);
uniform vec2 scroll2 = vec2(0.05, 0.05);
uniform sampler2D textureBack;
uniform float distortion_strength : hint_range(-1,1) = 0.2;
uniform vec4 tone_color : source_color;

void fragment() {
//	vec4 noise_col = texture(noise, UV + scroll * TIME);
//	vec4 screen_col = texture(SCREEN_TEXTURE,
//		SCREEN_UV + distortion_strength * noise_col.rr);
	float depth = texture(noise1, UV + scroll1 * TIME).r
		* texture(noise2, UV + scroll2 * TIME).r;
	vec4 screen_col = texture(textureBack,
		SCREEN_UV + distortion_strength * vec2(depth));
		
		
	COLOR = screen_col;
//	  COLOR = screen_col * tone_color;

}


shader_type canvas_item;

// pega a imagem da tela inteira
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform float strength: hint_range(0.0, 20.0) = 4.0;

void fragment() {
	// pega o tamanho do SCREEN_TEXTURE em pixels e converte para offset UV
	vec2 screen_px = vec2(textureSize(SCREEN_TEXTURE, 0));
	vec2 ps = (1.0 / screen_px) * strength;

	vec2 suv = SCREEN_UV; // coordenada da tela (0..1)
	vec4 c = vec4(0.0);

	// box blur 3x3 (9 amostras)
	c += texture(SCREEN_TEXTURE, suv + vec2(-ps.x, -ps.y));
	c += texture(SCREEN_TEXTURE, suv + vec2(0.0, -ps.y));
	c += texture(SCREEN_TEXTURE, suv + vec2(ps.x, -ps.y));

	c += texture(SCREEN_TEXTURE, suv + vec2(-ps.x, 0.0));
	c += texture(SCREEN_TEXTURE, suv);
	c += texture(SCREEN_TEXTURE, suv + vec2(ps.x, 0.0));

	c += texture(SCREEN_TEXTURE, suv + vec2(-ps.x, ps.y));
	c += texture(SCREEN_TEXTURE, suv + vec2(0.0, ps.y));
	c += texture(SCREEN_TEXTURE, suv + vec2(ps.x, ps.y));

	c /= 9.0;

	COLOR = c;
}

// Draw point text with alpha fade
draw_set_font(fntUI);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(alpha);

draw_text(x, y, point_value);

// Reset alpha
draw_set_alpha(1.0);

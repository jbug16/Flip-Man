var _mid_x = 128;
var _mid_y = 188;

draw_set_font(fntUI);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

// Text
if (ready) {
	draw_set_color(c_yellow);
	draw_text(_mid_x, _mid_y, "READY!");
}
else if (over) {
	draw_set_color(c_red);
	draw_text(_mid_x, _mid_y, "GAME OVER");
}

// Nerd label
draw_set_font(fntSmall);
draw_set_color(c_white);
//draw_text(_mid_x, _mid_y - 24, "MOM'S\nBASEMENT");

// Reset settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
// SCORES

// Positions
var _center_x = room_width / 2;
var _score_y = 2;
var _score_line_spacing = 12;

// Scores (top)
draw_set_font(fntUI);
draw_set_color(c_white);
draw_set_valign(fa_top);

// 1UP (left)
draw_set_halign(fa_left);
draw_text(_score_line_spacing, _score_y, "1UP");
draw_text(_score_line_spacing, _score_y + _score_line_spacing, global.points);

// HI-SCORE (center)
draw_set_halign(fa_center);
draw_text(_center_x, _score_y, "HI-SCORE");
draw_text(_center_x, _score_y + _score_line_spacing, global.highscore);


// LIVES + SNACKS (FRUITS)

if (room == rMenu) exit; // only draws in levels

// Positions
var _left_x = 24;
var _right_x = room_width - 26;
var _bottom_y = 308;
var _spacing = 16;

// Lives
repeat (global.extra_lives) {
	draw_sprite(sFlipMan, 0, _left_x, _bottom_y);
	_left_x += _spacing;
}

// Snacks
repeat (3) {
	draw_sprite(sSnacks, 0, _right_x, _bottom_y);
	_right_x -= _spacing;
}


// SIGN
draw_set_color(c_black);
draw_set_valign(fa_middle);
var _name = "Tarjayy";

draw_sprite_ext(sSignBG, 0, 128, 37, 4, 1, 0, c_white, 1);
draw_text(128, 37, _name);

// Reset settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
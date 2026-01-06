// Settings
draw_set_font(fntPixel);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Score display at top
var _score_y = 20;
var _score_left = 40;
var _score_center = room_width / 2;
var _score_right = room_width - 40;

// 1UP
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(_score_left, _score_y, "1UP");
draw_text(_score_left, _score_y + 20, "00");

// HI-SCORE (centered)
draw_set_halign(fa_center);
draw_text(_score_center, _score_y, "HI-SCORE");
draw_text(_score_center, _score_y + 20, string(global.highscore));

// 2UP
draw_set_halign(fa_right);
draw_text(_score_right, _score_y, "2UP");
draw_text(_score_right, _score_y + 20, "00");

// Player selection menu (below title)
var _menu_x = room_width / 2;
var _menu_y = 400; // Adjust based on your title position
var _menu_spacing = 40;

// Arrow indicator (blinking)
arrow_blink += 0.1;
var _arrow_alpha = 0.5 + 0.5 * abs(sin(arrow_blink));

draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_alpha(_arrow_alpha);

// Draw arrow for selected option
if (menu_selection == 0) {
    draw_text(_menu_x - 100, _menu_y, ">");
} else {
    draw_text(_menu_x - 100, _menu_y + _menu_spacing, ">");
}

// Player options
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_text(_menu_x, _menu_y, "1 PLAYER");
draw_text(_menu_x, _menu_y + _menu_spacing, "2 PLAYERS");

// Copyright text at bottom
draw_set_halign(fa_center);
var _copyright_y = room_height - 100;
draw_set_color(c_red);
draw_text(room_width / 2, _copyright_y, "Flip Man®");
draw_set_color(c_white);
draw_text(room_width / 2, _copyright_y + 25, "TM & © 2026");
draw_text(room_width / 2, _copyright_y + 50, "LICENSED BY GAMEMAKER STUDIO");

// Reset drawing settings
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
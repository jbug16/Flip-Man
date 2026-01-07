// SCORES

// Positions
var _center_x = room_width / 2;
var _score_y = 8;
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

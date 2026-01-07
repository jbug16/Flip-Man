// Positions
var _center_x = room_width / 2;
var _score_y = 8;
var _score_line_spacing = 12;
var _logo_y = 100;
var _insert_coin_y = room_height / 2;
var _copyright_y = 255;
var _copyright_line_spacing = 15;

// Colors
var _color_red = make_color_rgb(255, 0, 0);
var _color_logo = make_color_rgb(255, 200, 0); // Bright orange-yellow


// Title
draw_set_font(fntTitle);
draw_set_color(_color_logo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _title_text = "FLIP-MAN";
var _title_width = string_width(_title_text);

draw_sprite_ext(sTitleBG, 0, _center_x, _logo_y, 13, 3, 0, c_white, 1);
draw_text(_center_x, _logo_y, _title_text);

// TM symbol
draw_set_font(fntUI);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
//draw_text(_center_x + (_title_width / 2) + 4, _logo_y - 18, "TM");


// Insert coin
draw_set_font(fntUI);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

var _text_visible = (abs(sin(arrow_blink)) > 0.3);
if (_text_visible) {
    draw_text(_center_x, _insert_coin_y, "INSERT COIN");
}


// Copyright (bottom)
draw_set_font(fntUI);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

// "namco®" in red
draw_set_color(_color_red);
draw_text(_center_x, _copyright_y, "namco");
draw_text(_center_x+25, _copyright_y-4, "®");

draw_set_color(c_white);
draw_text(_center_x, _copyright_y + _copyright_line_spacing, "TM & © 1980 1993 NAMCO LTD.");
draw_text(_center_x, _copyright_y + (_copyright_line_spacing * 2), "NAMCO HOMETEK, INC.");
draw_text(_center_x, _copyright_y + (_copyright_line_spacing * 3), "LICENSED BY NINTENDO");


// Reset settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
// Check if we're in the credits room
if (room == rCredits) {
	// CREDITS SCREEN
	var _center_x = room_width / 2;
	var _start_y = 60;
	var _line_spacing = 20;
	
	draw_set_font(fntTitle);
	draw_set_color(make_color_rgb(255, 200, 0)); // Bright orange-yellow like title
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	// FLIP-MAN (R)
	var _title_text = "FLIP-MAN";
	var _title_width = string_width(_title_text);
	draw_text(_center_x-4, _start_y, _title_text);
	draw_set_font(fntUI);
	draw_set_halign(fa_left);
	draw_text(_center_x + (_title_width / 2) + 2, _start_y + 4, "®");
	draw_set_halign(fa_center);
	
	// Credits text
	draw_set_font(fntUI);
	draw_set_color(c_white);
	var _credits_y = _start_y + 80;
	draw_text(_center_x, _credits_y, "Created by Nir 'Mad Hatter' Paniry");
	draw_text(_center_x, _credits_y + _line_spacing, "Produced by Ralph Andino");
	draw_text(_center_x, _credits_y + (_line_spacing * 2), "Art by Ray Robinson");
	draw_text(_center_x, _credits_y + (_line_spacing * 3), "Programming by Jenna Curls");
	
	// Reset settings
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
} else if (!show_tutorial) {
	// REGULAR MENU SCREEN
	// Positions
	var _center_x = room_width / 2;
	var _score_y = 8;
	var _score_line_spacing = 12;
	var _logo_y = 80;
	var _insert_coin_y = room_height / 2 - 20;
	var _copyright_y = 240;
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

	//draw_sprite_ext(sTitleBG, 0, _center_x, _logo_y, 13, 3, 0, c_white, 1);
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


	// Tagline (above copyright)
	draw_set_font(fntUI);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(_center_x, _copyright_y - _copyright_line_spacing, "The greatest toy flipper in the world!");

	// Copyright (bottom)
	draw_set_font(fntUI);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	// "NEFARITY GAMES (R)" in red
	draw_set_color(_color_red);
	var _nefarity_text = "NEFARITY GAMES";
	var _nefarity_width = string_width(_nefarity_text);
	draw_text(_center_x, _copyright_y, _nefarity_text);
	draw_set_halign(fa_left);
	draw_text(_center_x + (_nefarity_width / 2) + 4, _copyright_y - 4, "®");
	draw_set_halign(fa_center);

	draw_set_color(c_white);
	draw_text(_center_x, _copyright_y + _copyright_line_spacing, "TM 1984 HATTER TOYS LLC.");
	draw_text(_center_x, _copyright_y + (_copyright_line_spacing * 2), "FLIP-OR and the Champions");
	draw_text(_center_x, _copyright_y + (_copyright_line_spacing * 3), "of Nefarity TM");
	draw_text(_center_x, _copyright_y + (_copyright_line_spacing * 4), "Licensed by Hatter Toys");


	// Reset settings
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
}
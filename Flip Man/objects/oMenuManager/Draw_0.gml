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
} else if (show_tutorial) {
	// TUTORIAL SCREEN (scores are already drawn by oUIManager)
	var _center_x = room_width / 2;
	var _light_blue = make_color_rgb(135, 206, 250); // Light blue color
	
	draw_set_font(fntUI);
	
	// Instructions (start below scores which are at y=2 and y=14, so start around y=40)
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	var _instruction_y = 40;
	draw_text(_center_x, _instruction_y, "GET ALL THE COINS AND ACTION FIGURES");
	draw_text(_center_x, _instruction_y + 12, "BEFORE THE ANGRY COLLECTORS GET YOU!");
	draw_text(_center_x, _instruction_y + 30, "WHEN THEY TURN GREEN, FLIP THEM");
	draw_text(_center_x, _instruction_y + 42, "ACTION FIGURES FOR PROFIT!");
	
	// Character / Nickname header
	var _char_header_y = _instruction_y + 70;
	draw_set_color(_light_blue);
	draw_set_halign(fa_center);
	var _header_text = "CHARACTER / NICKNAME";
	draw_text(_center_x, _char_header_y, _header_text);
	
	// Calculate where "NICKNAME" starts in header to align nickname text
	var _char_part = "CHARACTER / ";
	var _char_part_width = string_width(_char_part);
	var _header_width = string_width(_header_text);
	var _nickname_start_x = _center_x - (_header_width / 2) + _char_part_width;
	
	// Character lineup (centered)
	var _char_start_y = _char_header_y + 18;
	var _char_spacing = 35; // Increased spacing between nerds
	var _sprite_x = _center_x - 100; // Center sprite with text
	var _nickname_spacing = 50; // Increased spacing between nickname label and name
	
	// Howard - "NERD" (red)
	draw_set_color(c_white);
	draw_sprite_ext(sNerdHoward, 0, _sprite_x, _char_start_y, 2, 2, 0, c_white, 1);
	draw_set_color(make_color_rgb(255, 0, 0)); // Red
	draw_set_halign(fa_left);
	var _nerd_label = "- NERD";
	var _nerd_name = "\"HOWARD\"";
	var _nerd_label_x = _sprite_x + 30;
	draw_text(_nerd_label_x, _char_start_y, _nerd_label);
	draw_text(_nickname_start_x, _char_start_y, _nerd_name);
	
	// Leonard - "GEEK" (pink)
	draw_set_color(c_white);
	draw_sprite_ext(sNerdLeonard, 0, _sprite_x, _char_start_y + _char_spacing, 2, 2, 0, c_white, 1);
	draw_set_color(make_color_rgb(255, 192, 203)); // Pink
	var _geek_label = "- GEEK";
	var _geek_name = "\"LEONARD\"";
	draw_text(_nerd_label_x, _char_start_y + _char_spacing, _geek_label);
	draw_text(_nickname_start_x, _char_start_y + _char_spacing, _geek_name);
	
	// Raj - "DORK" (cyan)
	draw_set_color(c_white);
	draw_sprite_ext(sNerdRaj, 0, _sprite_x, _char_start_y + (_char_spacing * 2), 2, 2, 0, c_white, 1);
	draw_set_color(make_color_rgb(0, 255, 255)); // Cyan
	var _dork_label = "- DORK";
	var _dork_name = "\"RAJ\"";
	draw_text(_nerd_label_x, _char_start_y + (_char_spacing * 2), _dork_label);
	draw_text(_nickname_start_x, _char_start_y + (_char_spacing * 2), _dork_name);
	
	// Sheldon - "DWEEB" (orange)
	draw_set_color(c_white);
	draw_sprite_ext(sNerdSheldon, 0, _sprite_x, _char_start_y + (_char_spacing * 3), 2, 2, 0, c_white, 1);
	draw_set_color(make_color_rgb(255, 165, 0)); // Orange
	var _dweeb_label = "- DWEEB";
	var _dweeb_name = "\"SHELDON\"";
	draw_text(_nerd_label_x, _char_start_y + (_char_spacing * 3), _dweeb_label);
	draw_text(_nickname_start_x, _char_start_y + (_char_spacing * 3), _dweeb_name);
	
	// Point values at bottom (stacked vertically, centered like original Pac-Man)
	var _points_start_y = _char_start_y + (_char_spacing * 4);
	var _points_line_spacing = 20;
	var _points_sprite_x = _center_x - 40; // Center sprites
	
	draw_set_color(_light_blue);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	// Coin points (first line)
	draw_sprite_ext(sCoin, 0, _points_sprite_x, _points_start_y, 1, 1, 0, c_white, 1);
	draw_text(_points_sprite_x + 20, _points_start_y, "10 PTS");
	
	// Toy points (second line, stacked below)
	draw_sprite_ext(sToys, 0, _points_sprite_x, _points_start_y + _points_line_spacing, 1, 1, 0, c_white, 1);
	draw_text(_points_sprite_x + 20, _points_start_y + _points_line_spacing, "50 PTS");
	
	// Snack/Food points (third line, stacked below)
	draw_sprite_ext(sSnacks, 0, _points_sprite_x, _points_start_y + (_points_line_spacing * 2), 1, 1, 0, c_white, 1);
	draw_text(_points_sprite_x + 20, _points_start_y + (_points_line_spacing * 2), "BONUS");
	
	// Reset settings
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
} else {
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
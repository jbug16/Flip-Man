var _mid_x = 128;
var _mid_y = 188;

draw_set_font(fntUI);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

// Text
if (paused) {
	draw_set_color(c_yellow);
	draw_text(_mid_x, _mid_y, "PAUSED");
}
else if (ready) {
	draw_set_color(c_yellow);
	draw_text(_mid_x, _mid_y, "READY!");
}
else if (over) {
	draw_set_color(c_red);
	draw_text(_mid_x, _mid_y, "GAME OVER");
}
else if (won) {
	blink_counter++;
	
    var _blink_speed = 10; 
    var _blink_on = ((blink_counter div _blink_speed) mod 2 == 0);
    
    if (_blink_on) {
        // Draw white sprite at same position as level sprite
        draw_sprite_ext(sLevels, 3, 16, 48, 1, 1, 0, c_white, 1);
    }
}

// Nerd label
draw_set_font(fntSmall);
draw_set_color(c_white);
//draw_text(_mid_x, _mid_y - 24, "MOM'S\nBASEMENT");

// Reset settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
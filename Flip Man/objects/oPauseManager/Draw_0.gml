/// @description Display pause menu when app resumes from background

if (show_pause_menu)
{
    // Draw black overlay covering entire screen
    draw_set_alpha(0.75);
    draw_set_color(c_black);
	depth = -9999;
    draw_rectangle(0, 0, room_width, room_height, false);
    
    var _mid_x = room_width/2;
    var _mid_y = room_height/2;
    
    draw_set_font(fntUI);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    
    // Draw "PAUSED" text
    draw_set_color(c_yellow);
    draw_text(_mid_x, _mid_y - 12, "PAUSED");
    
    // Draw resume instructions
    draw_set_color(c_white);
    draw_text(_mid_x, _mid_y + 12, "Tap to Resume");
    
    // Reset settings
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

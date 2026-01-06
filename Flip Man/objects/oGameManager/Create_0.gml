// Globals
global.highscore = 0;
global.points = 0;

global.dev_mode = true;

// Macros
#macro print show_debug_message

// Size game
window_set_size(768, 720);
window_center();

// End
room_goto(rMenu);
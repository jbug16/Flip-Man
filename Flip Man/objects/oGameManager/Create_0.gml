// Globals
global.highscore = 10000;
global.points = 0;

global.dev_mode = true;

// Macros
#macro print show_debug_message

//
gpu_set_texfilter(false);

// Size game
window_set_size(512, 640);
window_center();

// End
alarm[0] = 10;
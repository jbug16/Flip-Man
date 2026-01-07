// Globals
global.highscore = 10000;
global.points = 0;
global.extra_lives = 0;
global.snacks = 0;

global.dev_mode = true;

// Macros
#macro print show_debug_message
#macro SECOND 60
#macro GRID 16

// Settings
gpu_set_texfilter(false);

// Size game
window_set_size(512, 640);
window_center();

// Go to menu
alarm[0] = 10;
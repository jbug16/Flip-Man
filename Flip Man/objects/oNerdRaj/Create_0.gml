// Inherit the parent event
event_inherited();

// Store starting position for respawning
start_x = x;
start_y = y;

ai = orange_ghost_ai;
image_index = 2;

nerd_sprite = sprite_index;
ghost_sprite = sprite_index;
sprite_index = nerd_sprite;

// Scatter corner position - bottom-left corner
scatter_x = 0;
scatter_y = 320;

box_wait_time = SECOND * 9;
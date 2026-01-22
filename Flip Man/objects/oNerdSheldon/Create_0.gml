// Inherit the parent event
event_inherited();

// Store starting position for respawning
start_x = x;
start_y = y;

ai = blue_ghost_ai;

nerd_sprite = sTestBlob;
ghost_sprite = sTestBlob2;
sprite_index = nerd_sprite;
image_index = 3;

// Scatter corner position - bottom-right corner
scatter_x = 256;
scatter_y = 320;

box_wait_time = SECOND * 6;
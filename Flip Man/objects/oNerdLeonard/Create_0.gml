// Inherit the parent event
event_inherited();

// Store starting position for respawning
start_x = x;
start_y = y;

ai = pink_ghost_ai;

nerd_sprite = sTestBlob;
ghost_sprite = sTestBlob2;
sprite_index = nerd_sprite;
image_index = 1;

// Scatter corner position - top-right corner
scatter_x = 256;
scatter_y = 0;

box_wait_time = SECOND * 3;
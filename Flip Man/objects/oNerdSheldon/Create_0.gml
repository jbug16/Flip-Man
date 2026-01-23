// Inherit the parent event
event_inherited();

// Store starting position for respawning
start_x = x;
start_y = y;

ai = blue_ghost_ai;

nerd_sprite = sNerdSheldon;
ghost_sprite = sGhostSheldon;
sprite_index = nerd_sprite;

// Scatter corner position - bottom-right corner
scatter_x = 256;
scatter_y = 320;

box_wait_time = SECOND * 6;
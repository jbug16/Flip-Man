// State constants
enum s {
	IN_BOX,
	OUT_BOX,
	CHASE,
	SCATTER,
	FRIGHTENED,
	DEAD
}

// State machine
nerd_state = s.IN_BOX;
ghost_mode = false; // Kept for backward compatibility during transition

// Speed settings
spd = 0.8;
spd_frightened = 0.55; // Speed for FRIGHTENED state

// Scatter corner position (placeholder - will be overridden in individual nerd Create events)
scatter_x = 0;
scatter_y = 0;

// CHASE/SCATTER cycle timing (same per level)
scatter_duration = SECOND * 7; // 7 seconds scatter
chase_duration = SECOND * 20; // 20 seconds chase
state_timer = chase_duration; // Start in CHASE mode
is_chase_phase = true; // Track if currently in CHASE phase

// FRIGHTENED state duration
frightened_duration = SECOND * 6;
_tmp = 0;

// Box exit point
box_exit_x = 128;
box_exit_y = 140;

// Box center (where nerds respawn)
box_center_x = 128;
box_center_y = 164;

// Starting position (will be set in individual enemy Create events)
start_x = 0;
start_y = 0;

// How long they are in the box
box_wait_time = 0;

ai = red_ghost_ai;

// Don't start alarm until game starts - set to -1 (disabled) initially
alarm[0] = -1;

// Don't change
image_speed = 0;
image_index = 0;
direction = 180;
image_xscale = 1;

nerd_sprite = noone;
ghost_sprite = noone;
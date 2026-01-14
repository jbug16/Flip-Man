// State constants
#macro STATE_CHASE 0
#macro STATE_SCATTER 1
#macro STATE_FRIGHTENED 2
#macro STATE_DEAD 3

// State machine
nerd_state = STATE_CHASE;
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

ai = red_ghost_ai;

// Don't change
image_speed = 0;
direction = 180;

nerd_sprite = noone;
ghost_sprite = noone;
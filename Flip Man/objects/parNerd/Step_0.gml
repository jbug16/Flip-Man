// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won) exit;

// Don't move if dead
if (nerd_state == s.DEAD) exit;

// Start box exit timer when game starts (if still in IN_BOX state)
if (nerd_state == s.IN_BOX && alarm[0] == -1) {
	alarm[0] = box_wait_time;
}

// Update frightened_timer for enemies in box states (must be before IN_BOX exit check)
if ((nerd_state == s.IN_BOX || nerd_state == s.OUT_BOX) && frightened_timer > 0) {
	frightened_timer--;
	// If timer expires while still in box, clear pending_frightened (missed the window)
	if (frightened_timer <= 0) {
		pending_frightened = false;
		frightened_timer = -1;
	}
}

// Stay inside box if in IN_BOX state (no movement)
// But check if they should transition to OUT_BOX when alarm expires
if (nerd_state == s.IN_BOX) {
	// Don't exit early - let alarm handler transition to OUT_BOX
	// But don't process movement or other logic
	exit;
}

// Track previous state before any transitions
var _previous_state = nerd_state;

// Handle CHASE/SCATTER cycle timing (exclude IN_BOX, OUT_BOX, FRIGHTENED, and DEAD states)
if (nerd_state != s.FRIGHTENED && nerd_state != s.DEAD && nerd_state != s.IN_BOX && nerd_state != s.OUT_BOX) {
	state_timer--;
	
	if (state_timer <= 0) {
		// Transition between CHASE and SCATTER
		if (nerd_state == s.CHASE) {
			nerd_state = s.SCATTER;
			state_timer = scatter_duration;
			is_chase_phase = false;
			direction = (direction + 180) mod 360; // Turn around
		} else if (nerd_state == s.SCATTER) {
			nerd_state = s.CHASE;
			state_timer = chase_duration;
			is_chase_phase = true;
			direction = (direction + 180) mod 360; // Turn around
		}
	}
}

// Handle sprite changes based on state
// Show ghost sprite if FRIGHTENED or if IN_BOX/OUT_BOX with pending_frightened flag
if (nerd_state == s.FRIGHTENED || ((nerd_state == s.IN_BOX || nerd_state == s.OUT_BOX) && pending_frightened)) {
	if (sprite_index != ghost_sprite) {
		sprite_index = ghost_sprite;
	}
} else {
	if (sprite_index != nerd_sprite) {
		sprite_index = nerd_sprite;
	}
}

// Calculate movement speed based on state
var _current_spd = spd;
if (nerd_state == s.FRIGHTENED) {
	_current_spd = spd_frightened;
}
else _current_spd = spd;

// SFX
// Play frightened sound if actually FRIGHTENED or if visually frightened (pending_frightened)
if (nerd_state == s.FRIGHTENED || ((nerd_state == s.IN_BOX || nerd_state == s.OUT_BOX) && pending_frightened)) {
	if (!audio_is_playing(sndGhostFright)) {
		audio_stop_sound(sndGhostSiren);
		audio_play_sound(sndGhostFright, 1, true);
	}
}
else {
	if (!audio_is_playing(sndGhostSiren)) {
		audio_stop_sound(sndGhostFright);
		audio_play_sound(sndGhostSiren, 1, true);
	}
}

// Movement
if (nerd_state == s.CHASE) {
	script_execute(ai);
} else if (nerd_state == s.SCATTER) {
	// Move toward scatter corner
	scatter_ai();
} else if (nerd_state == s.FRIGHTENED) {
	// Random movement
	frightened_ai();
} else if (nerd_state == s.OUT_BOX) {
	// Move toward box exit point
	box_exit_ai();
	
	// Check if enemy has reached exit point
	if (point_distance(x, y, box_exit_x, box_exit_y) < GRID / 2) {
		// If pending_frightened flag is set, transition to FRIGHTENED state
		// Transfer frightened_timer to alarm[0] if timer is still running
		if (pending_frightened) {
			nerd_state = s.FRIGHTENED;
			if (frightened_timer > 0) {
				alarm[0] = frightened_timer; // Use remaining time
			} else {
				alarm[0] = frightened_duration; // Fallback if timer expired
			}
			pending_frightened = false; // Clear the flag
			frightened_timer = -1; // Clear the timer
			ghost_mode = true; // Keep for backward compatibility
		} else {
			// Transition to CHASE state
			nerd_state = s.CHASE;
			state_timer = chase_duration;
			is_chase_phase = true;
		}
	}
}

// Collision
// Store position before movement to check for door collision
var _prev_x = x;
var _prev_y = y;

move_contact_solid(direction, _current_spd);

// Check if we moved through a door (only block if not in OUT_BOX state)
if (nerd_state != s.OUT_BOX && place_meeting(x, y, oNerdDoor)) {
	// Revert to previous position
	x = _prev_x;
	y = _prev_y;
}

// Goes off screen, loop around
if (x < -0) { // LEFT
	x = room_width;
}
else if (x > room_width) { // RIGHT
	x = 0;
}
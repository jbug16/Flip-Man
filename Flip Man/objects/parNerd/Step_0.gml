// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won || oLevelManager.impact_pause || oLevelManager.paused) {
	image_speed = 0; 
	exit; 
}

// Safety check: If enemy is in box area but state is wrong, reset them
// Only check states that should NEVER be in the box: CHASE, SCATTER, FRIGHTENED
// Allow IN_BOX, DEAD, and OUT_BOX (enemies exiting are still in box area)
if (nerd_state != s.IN_BOX && nerd_state != s.DEAD && nerd_state != s.OUT_BOX) {
	if (place_meeting(x, y, oBox)) {
		// Enemy is in box but state is wrong - reset them
		x = box_center_x;
		y = box_center_y;
		nerd_state = s.IN_BOX;
		alarm[0] = -1; // Reset alarm so Step event can set it when game starts
		sprite_index = nerd_sprite; // Ensure correct sprite
		image_index = 0;
		image_speed = 0;
	}
}

// Start box exit timer when game starts (if still in IN_BOX state)
if (nerd_state == s.IN_BOX && alarm[0] == -1 && oLevelManager.start) {
	alarm[0] = box_wait_time;
}

// Stay inside box if in IN_BOX state (no movement)
// But check if they should transition to OUT_BOX when alarm expires
if (nerd_state == s.IN_BOX) {
	// Ensure normal sprite is used when in box
	if (sprite_index != nerd_sprite) {
		sprite_index = nerd_sprite;
	}
	// Stop animation when in box
	image_index = 0;
	image_speed = 0;
	// Don't exit early - let alarm handler transition to OUT_BOX
	// But don't process movement or other logic
	exit;
}

// Track previous state before any transitions
var _previous_state = nerd_state;

// Handle CHASE/SCATTER cycle timing (exclude IN_BOX, OUT_BOX, and FRIGHTENED states)
if (nerd_state != s.FRIGHTENED && nerd_state != s.IN_BOX && nerd_state != s.OUT_BOX) {
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
// Show ghost sprite if FRIGHTENED
// DEAD state uses normal sprite (not ghost sprite)
if (nerd_state == s.FRIGHTENED) {
	if (sprite_index != ghost_sprite) {
		sprite_index = ghost_sprite;
	}
	
	var _time_left = alarm_get(0);
	if (_time_left < frightened_duration/3) {
		_tmp++;
		// Flash white instead of black (Pac-Man style) — white/light-gray alternate keeps them visible
		image_blend = (_tmp % 10 == 0) ? c_white : c_green;
	}
} else {
	_tmp = 0;
	image_blend = c_white;
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
// Only play sounds for active nerds (not in IN_BOX)
// Check if any nerds are still FRIGHTENED before deciding what sound to play
if (nerd_state == s.FRIGHTENED) {
	// This nerd wants frightened sound
	if (!audio_is_playing(sndGhostFright)) {
		audio_stop_sound(sndGhostSiren);
		audio_play_sound(sndGhostFright, 1, true);
	}
}
else if (nerd_state != s.IN_BOX) {
	// This nerd wants siren sound, but only if no other nerds are FRIGHTENED
	var _any_frightened = false;
	with (parNerd) {
		if (nerd_state == s.FRIGHTENED) {
			_any_frightened = true;
		}
	}
	
	// Only play siren if no nerds are frightened
	if (!_any_frightened && !audio_is_playing(sndGhostSiren)) {
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
		// Transition to CHASE state
		nerd_state = s.CHASE;
		state_timer = chase_duration;
		is_chase_phase = true;
	}
}

// Update sprite xscale based on horizontal direction
if (direction == 0) {
	image_xscale = -1; // Moving right
} else if (direction == 180) {
	image_xscale = 1; // Moving left
}
// For vertical movement (90 up, 270 down), keep current xscale

// Collision — use configurable enemy collision list (see EnemyCollision script)
var _exclude = [];
if (nerd_state == s.DEAD || nerd_state == s.OUT_BOX) {
	array_push(_exclude, oNerdDoor); // Dead ghosts and enemies exiting box pass through doors
} else if (nerd_state == s.FRIGHTENED || nerd_state == s.CHASE || nerd_state == s.SCATTER) {
	// If enemy just transitioned from OUT_BOX and is still overlapping the door, exclude it
	// This prevents getting stuck halfway through the door when state changes
	if (place_meeting(x, y, oNerdDoor)) {
		array_push(_exclude, oNerdDoor); // Still passing through door, exclude it
	}
}
enemy_move_with_collision(direction, _current_spd, _exclude);

// Goes off screen, loop around
if (x < -0) { // LEFT
	x = room_width;
}
else if (x > room_width) { // RIGHT
	x = 0;
}

// Animation
switch (nerd_state) {
	case s.IN_BOX:
	case s.DEAD:
		image_speed = 0;
		break;
		
	case s.CHASE:
	case s.FRIGHTENED:
	case s.OUT_BOX:
	case s.SCATTER:
		image_speed = 1;
		break;
}
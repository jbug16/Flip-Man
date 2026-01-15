// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over) exit;

// Don't move if dead
if (nerd_state == STATE_DEAD) exit;

// Track previous state before any transitions
var _previous_state = nerd_state;

// Handle CHASE/SCATTER cycle timing
if (nerd_state != STATE_FRIGHTENED && nerd_state != STATE_DEAD) {
	state_timer--;
	
	if (state_timer <= 0) {
		// Transition between CHASE and SCATTER
		if (nerd_state == STATE_CHASE) {
			nerd_state = STATE_SCATTER;
			state_timer = scatter_duration;
			is_chase_phase = false;
			direction = (direction + 180) mod 360; // Turn around
		} else if (nerd_state == STATE_SCATTER) {
			nerd_state = STATE_CHASE;
			state_timer = chase_duration;
			is_chase_phase = true;
			direction = (direction + 180) mod 360; // Turn around
		}
	}
}

// Handle sprite changes based on state
if (nerd_state == STATE_FRIGHTENED) {
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
if (nerd_state == STATE_FRIGHTENED) {
	_current_spd = spd_frightened;
}
else _current_spd = spd;

// SFX
if (nerd_state == STATE_FRIGHTENED) {
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
if (nerd_state == STATE_CHASE) {
	script_execute(ai);
} else if (nerd_state == STATE_SCATTER) {
	// Move toward scatter corner
	scatter_ai();
} else if (nerd_state == STATE_FRIGHTENED) {
	// Random movement
	frightened_ai();
}

// Collision
move_contact_solid(direction, _current_spd);

// Goes off screen, loop around
if (x < -0) { // LEFT
	x = room_width;
}
else if (x > room_width) { // RIGHT
	x = 0;
}
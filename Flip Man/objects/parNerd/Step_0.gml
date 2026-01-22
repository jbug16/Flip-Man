// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won) exit;

// Start box exit timer when game starts (if still in IN_BOX state)
if (nerd_state == s.IN_BOX && alarm[0] == -1 && oLevelManager.start) {
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
// Show ghost sprite if FRIGHTENED or if IN_BOX/OUT_BOX with pending_frightened flag
// DEAD state uses normal sprite (not ghost sprite)
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
// Only play sounds for active nerds (not in IN_BOX)
// Check if any nerds are still FRIGHTENED before deciding what sound to play
if (nerd_state == s.FRIGHTENED || (nerd_state == s.OUT_BOX && pending_frightened)) {
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
		if (nerd_state == s.FRIGHTENED || (nerd_state == s.OUT_BOX && pending_frightened)) {
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
var _state_name = "UNKNOWN";
if (nerd_state == s.IN_BOX) _state_name = "IN_BOX";
else if (nerd_state == s.OUT_BOX) _state_name = "OUT_BOX";
else if (nerd_state == s.CHASE) _state_name = "CHASE";
else if (nerd_state == s.SCATTER) _state_name = "SCATTER";
else if (nerd_state == s.FRIGHTENED) _state_name = "FRIGHTENED";
else if (nerd_state == s.DEAD) _state_name = "DEAD";

var _pos_before_x = x;
var _pos_before_y = y;
show_debug_message("=== ENEMY MOVEMENT DEBUG ===");
show_debug_message("State: " + _state_name + " | Direction: " + string(direction) + " | Speed: " + string(_current_spd));
show_debug_message("Position before: (" + string(x) + ", " + string(y) + ")");

if (nerd_state != s.OUT_BOX) {
	// Normal movement - will stop at walls and doors (both are solid)
	// Check for door collision BEFORE movement to prevent partial penetration
	var _dx = lengthdir_x(_current_spd, direction);
	var _dy = lengthdir_y(_current_spd, direction);
	var _target_x = x + _dx;
	var _target_y = y + _dy;
	
	show_debug_message("Target position: (" + string(_target_x) + ", " + string(_target_y) + ")");
	var _door_check = place_meeting(_target_x, _target_y, oNerdDoor);
	show_debug_message("Pre-movement door check: " + string(_door_check));
	
	if (_door_check) {
		// Door is in the way - don't move at all
		show_debug_message("BLOCKED: Door detected at target position - preventing movement");
		show_debug_message("Position after: (" + string(x) + ", " + string(y) + ") (unchanged)");
		
		// Force AI to recalculate direction immediately to avoid getting stuck
		show_debug_message("Forcing AI recalculation to avoid door");
		if (nerd_state == s.CHASE) {
			script_execute(ai);
		} else if (nerd_state == s.SCATTER) {
			scatter_ai();
		} else if (nerd_state == s.FRIGHTENED) {
			frightened_ai();
		}
		show_debug_message("New direction after recalculation: " + string(direction));
	} else {
		// No door in the way - use normal movement
		show_debug_message("Using move_contact_solid (will stop at walls and doors)");
		move_contact_solid(direction, _current_spd);
		show_debug_message("Position after: (" + string(x) + ", " + string(y) + ")");
		show_debug_message("Moved distance: " + string(point_distance(_pos_before_x, _pos_before_y, x, y)));
		
		// Check what we're colliding with
		if (place_meeting(x, y, oWall)) {
			show_debug_message("COLLISION: Hit oWall at final position");
		}
		if (place_meeting(x, y, oNerdDoor)) {
			show_debug_message("COLLISION: Hit oNerdDoor at final position (unexpected!)");
		}
	}
} else {
	// OUT_BOX state - can pass through doors but not walls
	show_debug_message("OUT_BOX state - manual movement (can pass through doors)");
	var _dx = lengthdir_x(_current_spd, direction);
	var _dy = lengthdir_y(_current_spd, direction);
	show_debug_message("Movement delta: (" + string(_dx) + ", " + string(_dy) + ")");
	show_debug_message("Target position: (" + string(x + _dx) + ", " + string(y + _dy) + ")");
	
	// Check for wall collision only (ignore doors)
	var _wall_collision = place_meeting(x + _dx, y + _dy, oWall);
	var _door_collision = place_meeting(x + _dx, y + _dy, oNerdDoor);
	show_debug_message("Wall collision check: " + string(_wall_collision));
	show_debug_message("Door collision check: " + string(_door_collision) + " (ignored in OUT_BOX)");
	
	if (!_wall_collision) {
		show_debug_message("No wall collision - moving manually");
		x += _dx;
		y += _dy;
		show_debug_message("Position after: (" + string(x) + ", " + string(y) + ")");
		show_debug_message("Moved distance: " + string(point_distance(_pos_before_x, _pos_before_y, x, y)));
	} else {
		show_debug_message("Wall collision detected - using move_contact_solid");
		move_contact_solid(direction, _current_spd);
		show_debug_message("Position after: (" + string(x) + ", " + string(y) + ")");
		show_debug_message("Moved distance: " + string(point_distance(_pos_before_x, _pos_before_y, x, y)));
	}
	
	// Final collision check
	if (place_meeting(x, y, oWall)) {
		show_debug_message("FINAL CHECK: Colliding with oWall");
	}
	if (place_meeting(x, y, oNerdDoor)) {
		show_debug_message("FINAL CHECK: Colliding with oNerdDoor (should be able to pass through)");
	}
}
show_debug_message("=============================");

// Goes off screen, loop around
if (x < -0) { // LEFT
	x = room_width;
}
else if (x > room_width) { // RIGHT
	x = 0;
}
/// @desc Handle alarm transitions
if (nerd_state == s.IN_BOX) {
	// Transition from IN_BOX to OUT_BOX (only if game has started)
	if (oLevelManager.start && !oLevelManager.over && !oLevelManager.won) {
		nerd_state = s.OUT_BOX;
		// If pending_frightened is set, enemy will transition to FRIGHTENED when they exit
		// Don't transition here - let them exit first
		// frightened_timer continues counting in Step event
	} else {
		// Game hasn't started yet, reset alarm to wait again
		alarm[0] = box_wait_time;
	}
} else if (nerd_state == s.FRIGHTENED) {
	// Return from FRIGHTENED state back to cycle
	// Return to CHASE or SCATTER based on current cycle phase
	if (is_chase_phase) {
		nerd_state = s.CHASE;
	} else {
		nerd_state = s.SCATTER;
	}
	
	// Turn around when exiting FRIGHTENED
	direction = (direction + 180) mod 360;
	
	// Restore normal sprite
	if (sprite_index != nerd_sprite) {
		sprite_index = nerd_sprite;
	}
	
	ghost_mode = false; // Keep for backward compatibility
}
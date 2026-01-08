/// @desc Return from FRIGHTENED state back to cycle
if (nerd_state == STATE_FRIGHTENED) {
	// Return to CHASE or SCATTER based on current cycle phase
	if (is_chase_phase) {
		nerd_state = STATE_CHASE;
	} else {
		nerd_state = STATE_SCATTER;
	}
	
	// Turn around when exiting FRIGHTENED
	direction = (direction + 180) mod 360;
	
	// Restore normal sprite
	if (sprite_index != nerd_sprite) {
		sprite_index = nerd_sprite;
	}
	
	ghost_mode = false; // Keep for backward compatibility
}
/// @desc Handle alarm transitions
if (nerd_state == s.IN_BOX) {
	// Transition from IN_BOX to OUT_BOX (only if game has started)
	if (oLevelManager.start && !oLevelManager.over && !oLevelManager.won) {
		nerd_state = s.OUT_BOX;
	} else {
		// Game hasn't started yet - don't reset alarm, just exit
		// The Step event will set the alarm when the game starts
		alarm[0] = -1; // Set to -1 so Step event can set it when game starts
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
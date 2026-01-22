// Ignore collision if nerd is in box states (IN_BOX or OUT_BOX) or DEAD
if (other.nerd_state == s.DEAD || other.nerd_state == s.IN_BOX || other.nerd_state == s.OUT_BOX) {
	exit;
}

// Check if nerd is in FRIGHTENED state
if (other.nerd_state == s.FRIGHTENED) {
	// Award points for eating frightened nerd
	global.points += 200;
	audio_play_sound(sndEatGhost, 1, false);
	
	CheckHighscore();
	
	// Teleport nerd to box center and set to IN_BOX state for respawn
	with (other) {
		// Teleport to box center (all nerds respawn at same position)
		x = box_center_x;
		y = box_center_y;
		nerd_state = s.IN_BOX;
		alarm[0] = SECOND * 5;
		// Reset state for respawn
		ghost_mode = false;
		pending_frightened = false;
		frightened_timer = -1;
	}
} else {
	// Nerd is not frightened - player gets hit
	audio_stop_all();
	audio_play_sound(sndPacmanDying, 1, false);
	
	// Lives
	if (global.extra_lives == 0) {
		// No more drawn lives - this is the "one more try"
		// Player got hit, so game over
		with (oLevelManager) {
			over = true;
		
			// Delay for game over text, then go to menu
			alarm[1] = SECOND * 3;
		}
		
		// Delete player
		instance_destroy();
	}
	else {
		// Still have drawn lives remaining
		global.extra_lives--;
		LevelRestart();
	}
}
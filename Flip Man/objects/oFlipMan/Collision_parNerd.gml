// Check if nerd is in FRIGHTENED state
if (other.nerd_state == STATE_FRIGHTENED) {
	// Award points for eating frightened nerd
	global.points += 200;
	audio_play_sound(sndEatGhost, 1, false);
	
	CheckHighscore();
	
	// Destroy the nerd (respawn logic will be added later)
	with (other) {
		nerd_state = STATE_DEAD;
		audio_play_sound(sndGhostBackToBase, 1, false); // needs to loop and only play once, should stop when ghost gets to base
		instance_destroy();
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
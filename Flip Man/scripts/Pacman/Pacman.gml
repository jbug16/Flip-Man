function CheckHighscore() {
	// Check and update highscore
	if (global.points > global.highscore) {
		global.highscore = global.points;
		var _ini = ini_open("highscore.ini");
		ini_write_real("Highscore", "score", global.highscore);
		ini_close();
		
		// SFX
		if (!beat_highscore) {
			beat_highscore = true; // doesn't play again
			audio_play_sound(sndHighscore, 2, false);
		}
	}
}

function LevelRestart() {
	// Player is placed back in starting point
	// "Ready!" text appears
	// Enemies are reset to starting point
	// Level is otherwise unchanged 
	
	// Starting positions from room definition
	var _player_start_x = 128;
	var _player_start_y = 236;
	
	// Recreate player at starting position if it doesn't exist (player was destroyed on death)
	if (!instance_exists(oFlipMan)) {
		instance_create_layer(_player_start_x, _player_start_y, "Player", oFlipMan);
	} else {
		// If player exists, just move to start position
		with (oFlipMan) {
			x = _player_start_x;
			y = _player_start_y;
			// Reset player direction
			direction = 180;
			image_xscale = 1;
		}
	}
	
	// Reset all nerds to their starting positions and states
	with (oNerdHoward) {
		x = 128; 
		y = 140;
		nerd_state = s.IN_BOX;
		ghost_mode = false;
		alarm[0] = -1; // Don't set alarm here - let Step event set it when game starts
	}

	with (oNerdLeonard) {
		x = 128;
		y = 164;
		nerd_state = s.IN_BOX;
		ghost_mode = false;
		alarm[0] = -1; // Don't set alarm here - let Step event set it when game starts
	}

	with (oNerdRaj) {
		x = 144;
		y = 164;
		nerd_state = s.IN_BOX;
		ghost_mode = false;
		alarm[0] = -1; // Don't set alarm here - let Step event set it when game starts
	}

	with (oNerdSheldon) {
		x = 112;
		y = 164;
		nerd_state = s.IN_BOX;
		ghost_mode = false;
		alarm[0] = -1; // Don't set alarm here - let Step event set it when game starts
	}
	
	// Reset LevelManager to show "Ready!" screen
	with (oLevelManager) {
		ready = true;   // Show "Ready!" text
		start = false;  // Player can't move yet
		// Set alarm to start the game after startup sound
		alarm[0] = SECOND * audio_sound_length(sndPacmanDying) + 1;
	}
}
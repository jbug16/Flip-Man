//// Check if nerd is in FRIGHTENED state
//if (other.nerd_state == STATE_FRIGHTENED) {
//	// Award points for eating frightened nerd
//	global.points += 200;
	
//	// Check and update highscore
//	if (global.points > global.highscore) {
//		global.highscore = global.points;
//		var _ini = ini_open("highscore.ini");
//		ini_write_real("Highscore", "score", global.highscore);
//		ini_close();
//	}
	
//	// Destroy the nerd (respawn logic will be added later)
//	with (other) {
//		nerd_state = STATE_DEAD;
//		instance_destroy();
//	}
//} else {
//	// Nerd is not frightened - player gets hit
//	// Lives
//	if (global.extra_lives == 0) {
//		// No more drawn lives - this is the "one more try"
//		// Player got hit, so game over
//		with (oLevelManager) {
//			over = true;
		
//			// Delay for game over text, then go to menu
//			alarm[1] = SECOND * 3;
//		}
		
//		// Delete player
//		instance_destroy();
//	}
//	else {
//		// Still have drawn lives remaining
//		global.extra_lives--;
//		room_restart();
//	}
//}
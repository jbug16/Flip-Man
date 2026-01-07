//if (other.ghost_mode) global.points += 200;
//else {
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
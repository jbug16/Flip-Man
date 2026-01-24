// Ignore collision if nerd is in box states (IN_BOX or OUT_BOX) or DEAD
if (other.nerd_state == s.DEAD || other.nerd_state == s.IN_BOX || other.nerd_state == s.OUT_BOX) {
	exit;
}

// Distance check: ensure sprites are actually visually overlapping before processing collision
// Both sprites are 16x16, so 8 pixels (half sprite size) ensures they're touching
var _collision_threshold = 8;
var _distance = point_distance(x, y, other.x, other.y);
if (_distance > _collision_threshold) {
	exit; // Too far apart, ignore collision
}

if (other.object_index == oBoss) {
	// Boss frightened (all dots eaten): eating boss wins the level
	if (other.nerd_state == s.FRIGHTENED) {
		global.points += 200;
		audio_stop_all();
		audio_play_sound(sndEatGhost, 1, false);
		CheckHighscore();
		instance_destroy(other);
		with (oLevelManager) {
			won = true;
			alarm[2] = SECOND * 2;
		}
		exit;
	}
	// Boss not frightened - hits the player
	audio_stop_all();
	audio_play_sound(sndPacmanDying, 1, false);
	if (global.extra_lives == 0) {
		with (oLevelManager) {
			over = true;
			alarm[1] = SECOND * 3;
		}
		instance_destroy();
	} else {
		global.extra_lives--;
		LevelRestart();
	}
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
		// Switch back to normal sprite when sent back to box
		if (sprite_index != nerd_sprite) {
			sprite_index = nerd_sprite;
		}
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
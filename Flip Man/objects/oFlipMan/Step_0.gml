// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over) exit;

// Coins
var _coin = collision_rectangle(x-6, y-4, x+6, y+4, oCoin, false, false);
if (_coin != noone) {
	global.points += 10;
	
	CheckHighscore();
	
	// Track coins eaten for snack spawning
	oLevelManager.coins_eaten++;
	
	if (oLevelManager.coins_eaten % 2 == 1) sfx_cur = wa;
	else sfx_cur = ka;
	audio_play_sound(sfx_cur, 1, false);
	
	instance_destroy(_coin);
	
	return;
}

// Snacks
var _snack = collision_rectangle(x-6, y-4, x+6, y+4, oSnack, false, false);
if (_snack != noone) {
	global.snacks++;
	
	audio_play_sound(sndEatFruit, 0, false);
	
	// Clear snack_active reference and destroy snack
	oLevelManager.snack_active = noone;
	instance_destroy(_snack);
	
	return;
}

// Toys
var _toy = collision_rectangle(x-6, y-4, x+6, y+4, oToy, false, false);
if (_toy != noone) {
	global.points += 50;
	
	CheckHighscore();
	
	// Trigger FRIGHTENED state for all nerds
	with (parNerd) {
		if (nerd_state != STATE_DEAD) {
			// Only set FRIGHTENED if not already dead
			// Turn around immediately when entering frightened mode
			if (nerd_state != STATE_FRIGHTENED) {
				direction = (direction + 180) mod 360;
			}
			nerd_state = STATE_FRIGHTENED;
			alarm[0] = frightened_duration;
			ghost_mode = true; // Keep for backward compatibility
		}
	}
	
	instance_destroy(_toy);
	
	return;
}

// Controls
if (keyboard_check(vk_left)) {
	if (!place_meeting(x-2, y, oWall)) {
		direction = 180;
		image_xscale = 1;
		image_speed = 1;
	}
}
if (keyboard_check(vk_right)) {
	if (!place_meeting(x+2, y, oWall)) {
		direction = 0;
		image_xscale = -1;
		image_speed = 1;
	}
}
if (keyboard_check(vk_up)) {
	if (!place_meeting(x, y-2, oWall)) {
		direction = 90;
		image_speed = 1;
	}
}
if (keyboard_check(vk_down)) {
	if (!place_meeting(x, y+2, oWall)) {
		direction = 270;
		image_speed = 1;
	}
}

// Collision
move_contact_solid(direction, spd);

// Goes off screen, loop around
if (x < -0) { // LEFT
	x = room_width;
}
else if (x > room_width) { // RIGHT
	x = 0;
}
// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won) exit;

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
	
	// Check if this was the last coin
	if (instance_number(oCoin) <= 0) {
		oLevelManager.won = true;
		audio_stop_all();
		oLevelManager.alarm[2] = SECOND * 2;
	}
	
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
	
	// Trigger FRIGHTENED state for all nerds (skip enemies in box or already frightened)
	with (parNerd) {
		if (nerd_state != s.DEAD && nerd_state != s.IN_BOX && nerd_state != s.OUT_BOX && nerd_state != s.FRIGHTENED) {
			// Turn around immediately when entering frightened mode
			direction = (direction + 180) mod 360;
			nerd_state = s.FRIGHTENED;
			alarm[0] = frightened_duration;
			ghost_mode = true; // Keep for backward compatibility
		}
	}
	
	instance_destroy(_toy);
	
	return;
}

// Controls
if (keyboard_check(vk_left)) {
	if (!place_meeting(x-2, y, oWall) && !place_meeting(x-2, y, oNerdDoor)) {
		direction = 180;
		image_xscale = 1;
		image_speed = 1;
	}
}
if (keyboard_check(vk_right)) {
	if (!place_meeting(x+2, y, oWall) && !place_meeting(x+2, y, oNerdDoor)) {
		direction = 0;
		image_xscale = -1;
		image_speed = 1;
	}
}
if (keyboard_check(vk_up)) {
	if (!place_meeting(x, y-2, oWall) && !place_meeting(x, y-2, oNerdDoor)) {
		direction = 90;
		image_speed = 1;
	}
}
if (keyboard_check(vk_down)) {
	if (!place_meeting(x, y+2, oWall) && !place_meeting(x, y+2, oNerdDoor)) {
		direction = 270;
		image_speed = 1;
	}
}

// Collision
// Store position before movement to check for door collision
var _prev_x = x;
var _prev_y = y;

move_contact_solid(direction, spd);

// Check if we moved through a door and revert if so
if (place_meeting(x, y, oNerdDoor)) {
	// Revert to previous position
	x = _prev_x;
	y = _prev_y;
}

// Goes off screen, loop around
if (x < -0) { // LEFT
	x = room_width;
}
else if (x > room_width) { // RIGHT
	x = 0;
}
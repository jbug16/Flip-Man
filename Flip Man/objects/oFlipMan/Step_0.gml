// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won || oLevelManager.impact_pause || global.game_paused) {
	image_speed = 0;
	exit;
}

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
		// Boss level: boss goes frightened; player must eat boss to win
		if (room == rLevelBoss && instance_exists(oBoss)) {
			audio_stop_all();
			audio_play_sound(sndGhostFright, 1, true);
			with (oBoss) {
				nerd_state = s.FRIGHTENED;
				direction = (direction + 180) mod 360;
				alarm[0] = 999999; // No timeout; stay frightened until eaten
				sprite_index = ghost_sprite;
			}
			// All other enemies (nerds) also go frightened
			with (parNerd) {
				if (object_index != oBoss && nerd_state != s.DEAD && nerd_state != s.IN_BOX && nerd_state != s.OUT_BOX && nerd_state != s.FRIGHTENED) {
					direction = (direction + 180) mod 360;
					nerd_state = s.FRIGHTENED;
					alarm[0] = 999999; // Stay frightened until boss is eaten
					ghost_mode = true;
				}
			}
		} else {
			oLevelManager.won = true;
			audio_stop_all();
			oLevelManager.alarm[2] = SECOND * 2;
		}
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
}

// Toys
var _toy = collision_rectangle(x-6, y-4, x+6, y+4, oToy, false, false);
if (_toy != noone) {
	global.points += 50;
	
	CheckHighscore();
	
	// Trigger FRIGHTENED state for all nerds (skip enemies in box or already frightened, and skip boss)
	with (parNerd) {
		if (object_index != oBoss && nerd_state != s.DEAD && nerd_state != s.IN_BOX && nerd_state != s.OUT_BOX && nerd_state != s.FRIGHTENED) {
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

// Controls — on-screen D-pad, buffered swipe, keyboard
touch_controls_poll();

if (touch_buffered_dir != -1) {
	if (player_try_turn(touch_buffered_dir))
		touch_buffered_dir = -1;
}

if (keyboard_check(vk_left) || keyboard_check(vk_right) || keyboard_check(vk_up) || keyboard_check(vk_down))
	touch_buffered_dir = -1;
else if (global.touch_ctrl_pressed_dir == -1 && !device_mouse_check_button(0, mb_left))
	touch_buffered_dir = -1;

if (keyboard_check(vk_left))
	player_try_turn(180);
if (keyboard_check(vk_right))
	player_try_turn(0);
if (keyboard_check(vk_up))
	player_try_turn(90);
if (keyboard_check(vk_down))
	player_try_turn(270);

// Collision
// Store position before movement to check for door collision and movement
var _prev_x = x;
var _prev_y = y;

move_contact_solid(direction, spd);

// Check if we moved through a door and revert if so
if (place_meeting(x, y, oNerdDoor)) {
	// Revert to previous position
	x = _prev_x;
	y = _prev_y;
}

// Check if player actually moved - if not, stop animation
var _moved = (x != _prev_x || y != _prev_y);
if (_moved) {
	image_speed = 1;
} else {
	image_speed = 0;
}

// Goes off screen, loop around
if (x < -0) { // LEFT
	x = room_width;
}
else if (x > room_width) { // RIGHT
	x = 0;
}
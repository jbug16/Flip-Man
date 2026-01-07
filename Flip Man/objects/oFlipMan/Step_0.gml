// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over) exit;

// Coins
var _coin = collision_rectangle(x-6, y-4, x+6, y+4, oCoin, false, false);
if (_coin != noone) {
	global.points += 10;
	
	// Check and update highscore
	if (global.points > global.highscore) {
		global.highscore = global.points;
		var _ini = ini_open("highscore.ini");
		ini_write_real("Highscore", "score", global.highscore);
		ini_close();
	}
	
	instance_destroy(_coin);
	return;
}

// Toys
var _toy = collision_rectangle(x-6, y-4, x+6, y+4, oToy, false, false);
if (_toy != noone) {
	global.points += 50;
	
	// Check and update highscore
	if (global.points > global.highscore) {
		global.highscore = global.points;
		var _ini = ini_open("highscore.ini");
		ini_write_real("Highscore", "score", global.highscore);
		ini_close();
	}
	
	// Trigger ghost mode
	with (parNerd) {
		ghost_mode = true;
		alarm[0] = SECOND * 6;
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
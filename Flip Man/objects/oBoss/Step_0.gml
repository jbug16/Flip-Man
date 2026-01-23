// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won) exit;

var _m = spd;
var _g = GRID;

if (nerd_state == s.FRIGHTENED) {
	// Frightened: random movement at same speed (no slowdown)
	sprite_index = ghost_sprite;
	var choices = [];
	var n = 0;
	if (direction != 270 && enemy_direction_clear(x, y - _m, x, y - _g, []) ) { choices[n++] = 90; }
	if (direction != 90  && enemy_direction_clear(x, y + _m, x, y + _g, []) ) { choices[n++] = 270; }
	if (direction != 0   && enemy_direction_clear(x - _m, y, x - _g, y, []) ) { choices[n++] = 180; }
	if (direction != 180 && enemy_direction_clear(x + _m, y, x + _g, y, []) ) { choices[n++] = 0; }
	if (n > 0) direction = choices[irandom(n - 1)];
} else {
	// Chase: follow player
	sprite_index = nerd_sprite;
	var new_dir = -1;
	var distance_to_flipman = 9999999;
	if (direction != 270 && enemy_direction_clear(x, y - _m, x, y - _g, []) ) {
		var _dist = point_distance(x, y - GRID, oFlipMan.x, oFlipMan.y);
		if (_dist < distance_to_flipman) { new_dir = 90; distance_to_flipman = _dist; }
	}
	if (direction != 90 && enemy_direction_clear(x, y + _m, x, y + _g, []) ) {
		var _dist = point_distance(x, y + GRID, oFlipMan.x, oFlipMan.y);
		if (_dist < distance_to_flipman) { new_dir = 270; distance_to_flipman = _dist; }
	}
	if (direction != 0 && enemy_direction_clear(x - _m, y, x - _g, y, []) ) {
		var _dist = point_distance(x - GRID, y, oFlipMan.x, oFlipMan.y);
		if (_dist < distance_to_flipman) { new_dir = 180; distance_to_flipman = _dist; }
	}
	if (direction != 180 && enemy_direction_clear(x + _m, y, x + _g, y, []) ) {
		var _dist = point_distance(x + GRID, y, oFlipMan.x, oFlipMan.y);
		if (_dist < distance_to_flipman) { new_dir = 0; distance_to_flipman = _dist; }
	}
	if (new_dir != -1) direction = new_dir;
}

enemy_move_with_collision(direction, spd, []);

// Goes off screen, loop around
if (x < 0) {
	x = room_width;
} else if (x > room_width) {
	x = 0;
}

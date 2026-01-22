// Functions for each different type of ghost AI in pacman

function stay_in_box() {
	
}

function box_exit_ai() {
	// Get to middle of box first
	// Then move up
	
	// Use tolerance to avoid oscillation - if close enough to exit x, move up
	var _tolerance = 0.1; // pixels
	
	// If close enough to the exit x position, move up
	if (abs(x - box_exit_x) <= _tolerance) {
		direction = 90; // Move up
	}
	// If spawned on the left side
	else if (x < box_exit_x) {
		// Move right
		direction = 0;
	}
	// If spawned on the right side
	else {
		// Move left
		direction = 180;
	}
}

function dead_ghost_ai() {
	// Move dead ghost back to box center. Dead ghosts ignore oNerdDoor (use exclude list).
	var new_dir = -1;
	var distance_to_box = 9999999;
	var target_x = box_exit_x;
	var target_y = box_exit_y;
	var _exclude = [oNerdDoor];

	if (direction != 270) {
		if (!enemy_collision_at(x, y - 2, _exclude)) {
			var _dist = point_distance(x, y - GRID, target_x, target_y);
			if (_dist < distance_to_box) { new_dir = 90; distance_to_box = _dist; }
		}
	}
	if (direction != 90) {
		if (!enemy_collision_at(x, y + 2, _exclude)) {
			var _dist = point_distance(x, y + GRID, target_x, target_y);
			if (_dist < distance_to_box) { new_dir = 270; distance_to_box = _dist; }
		}
	}
	if (direction != 0) {
		if (!enemy_collision_at(x - 2, y, _exclude)) {
			var _dist = point_distance(x - GRID, y, target_x, target_y);
			if (_dist < distance_to_box) { new_dir = 180; distance_to_box = _dist; }
		}
	}
	if (direction != 180) {
		if (!enemy_collision_at(x + 2, y, _exclude)) {
			var _dist = point_distance(x + GRID, y, target_x, target_y);
			if (_dist < distance_to_box) { new_dir = 0; distance_to_box = _dist; }
		}
	}
	if (new_dir != -1) direction = new_dir;
}

function red_ghost_ai() {
	var new_dir = -1;
	var distance_to_flipman = 9999999;
	var _m = spd;
	var _g = GRID;

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
	
function pink_ghost_ai() {
	var new_dir = -1;
	var distance_to_flipman = 9999999;
	var _size = GRID * 4;
	var x_dirs = [_size, -_size, -_size, 0];
	var y_dirs = [0, -_size, 0, _size];
	var dx = x_dirs[oFlipMan.direction / 90];
	var dy = y_dirs[oFlipMan.direction / 90];
	var _m = spd;
	var _g = GRID;

	if (direction != 270 && enemy_direction_clear(x, y - _m, x, y - _g, []) ) {
		var _dist = point_distance(x, y - GRID, oFlipMan.x + dx, oFlipMan.y + dy);
		if (_dist < distance_to_flipman) { new_dir = 90; distance_to_flipman = _dist; }
	}
	if (direction != 90 && enemy_direction_clear(x, y + _m, x, y + _g, []) ) {
		var _dist = point_distance(x, y + GRID, oFlipMan.x + dx, oFlipMan.y + dy);
		if (_dist < distance_to_flipman) { new_dir = 270; distance_to_flipman = _dist; }
	}
	if (direction != 0 && enemy_direction_clear(x - _m, y, x - _g, y, []) ) {
		var _dist = point_distance(x - GRID, y, oFlipMan.x + dx, oFlipMan.y + dy);
		if (_dist < distance_to_flipman) { new_dir = 180; distance_to_flipman = _dist; }
	}
	if (direction != 180 && enemy_direction_clear(x + _m, y, x + _g, y, []) ) {
		var _dist = point_distance(x + GRID, y, oFlipMan.x + dx, oFlipMan.y + dy);
		if (_dist < distance_to_flipman) { new_dir = 0; distance_to_flipman = _dist; }
	}
	if (new_dir != -1) direction = new_dir;
}
	
function orange_ghost_ai() {
	var new_dir = -1;
	var distance_to_flipman = 9999999;
	var dx = oFlipMan.x;
	var dy = oFlipMan.y;
	if (point_distance(x, y, oFlipMan.x, oFlipMan.y) < 160) { dx = 16; dy = 296; }
	var _m = spd;
	var _g = GRID;

	if (direction != 270 && enemy_direction_clear(x, y - _m, x, y - _g, []) ) {
		var _dist = point_distance(x, y - GRID, dx, dy);
		if (_dist < distance_to_flipman) { new_dir = 90; distance_to_flipman = _dist; }
	}
	if (direction != 90 && enemy_direction_clear(x, y + _m, x, y + _g, []) ) {
		var _dist = point_distance(x, y + GRID, dx, dy);
		if (_dist < distance_to_flipman) { new_dir = 270; distance_to_flipman = _dist; }
	}
	if (direction != 0 && enemy_direction_clear(x - _m, y, x - _g, y, []) ) {
		var _dist = point_distance(x - GRID, y, dx, dy);
		if (_dist < distance_to_flipman) { new_dir = 180; distance_to_flipman = _dist; }
	}
	if (direction != 180 && enemy_direction_clear(x + _m, y, x + _g, y, []) ) {
		var _dist = point_distance(x + GRID, y, dx, dy);
		if (_dist < distance_to_flipman) { new_dir = 0; distance_to_flipman = _dist; }
	}
	if (new_dir != -1) direction = new_dir;
}
	
function blue_ghost_ai() {
	var new_dir = -1;
	var distance_to_flipman = 9999999;
	var _size = GRID * 2;
	var x_dirs = [_size, -_size, -_size, 0];
	var y_dirs = [0, -_size, 0, _size];
	var dx = oNerdHoward.x + x_dirs[oFlipMan.direction / 90];
	var dy = oNerdHoward.y + y_dirs[oFlipMan.direction / 90];
	var ddx = oNerdHoward.x - dx;
	var ddy = oNerdHoward.y - dy;
	dx -= ddx;
	dy -= ddy;
	var _m = spd;
	var _g = GRID;

	if (direction != 270 && enemy_direction_clear(x, y - _m, x, y - _g, []) ) {
		var _dist = point_distance(x, y - GRID, dx, dy);
		if (_dist < distance_to_flipman) { new_dir = 90; distance_to_flipman = _dist; }
	}
	if (direction != 90 && enemy_direction_clear(x, y + _m, x, y + _g, []) ) {
		var _dist = point_distance(x, y + GRID, dx, dy);
		if (_dist < distance_to_flipman) { new_dir = 270; distance_to_flipman = _dist; }
	}
	if (direction != 0 && enemy_direction_clear(x - _m, y, x - _g, y, []) ) {
		var _dist = point_distance(x - GRID, y, dx, dy);
		if (_dist < distance_to_flipman) { new_dir = 180; distance_to_flipman = _dist; }
	}
	if (direction != 180 && enemy_direction_clear(x + _m, y, x + _g, y, []) ) {
		var _dist = point_distance(x + GRID, y, dx, dy);
		if (_dist < distance_to_flipman) { new_dir = 0; distance_to_flipman = _dist; }
	}
	if (new_dir != -1) direction = new_dir;
}

function scatter_ai() {
	var new_dir = -1;
	var distance_to_corner = 9999999;
	var target_x = scatter_x;
	var target_y = scatter_y;
	var _m = spd;
	var _g = GRID;

	if (direction != 270 && enemy_direction_clear(x, y - _m, x, y - _g, []) ) {
		var _dist = point_distance(x, y - GRID, target_x, target_y);
		if (_dist < distance_to_corner) { new_dir = 90; distance_to_corner = _dist; }
	}
	if (direction != 90 && enemy_direction_clear(x, y + _m, x, y + _g, []) ) {
		var _dist = point_distance(x, y + GRID, target_x, target_y);
		if (_dist < distance_to_corner) { new_dir = 270; distance_to_corner = _dist; }
	}
	if (direction != 0 && enemy_direction_clear(x - _m, y, x - _g, y, []) ) {
		var _dist = point_distance(x - GRID, y, target_x, target_y);
		if (_dist < distance_to_corner) { new_dir = 180; distance_to_corner = _dist; }
	}
	if (direction != 180 && enemy_direction_clear(x + _m, y, x + _g, y, []) ) {
		var _dist = point_distance(x + GRID, y, target_x, target_y);
		if (_dist < distance_to_corner) { new_dir = 0; distance_to_corner = _dist; }
	}
	if (new_dir != -1) direction = new_dir;
}

function frightened_ai() {
	var choices = [];
	var n = 0;
	var _m = spd_frightened;
	var _g = GRID;

	if (direction != 270 && enemy_direction_clear(x, y - _m, x, y - _g, []) ) { choices[n++] = 90; }
	if (direction != 90  && enemy_direction_clear(x, y + _m, x, y + _g, []) ) { choices[n++] = 270; }
	if (direction != 0   && enemy_direction_clear(x - _m, y, x - _g, y, []) ) { choices[n++] = 180; }
	if (direction != 180 && enemy_direction_clear(x + _m, y, x + _g, y, []) ) { choices[n++] = 0; }

	if (n > 0) direction = choices[irandom(n - 1)];
}
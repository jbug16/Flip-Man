// Functions for each different type of ghost AI in pacman

function red_ghost_ai() {
	// Movement
	var new_dir = -1;
	var distance_to_flipman = 9999999;

	if (direction != 270) { // UP
		if (!place_meeting(x, y-2, oWall)) {
			var _dist = point_distance(x, y-GRID, oFlipMan.x, oFlipMan.y);
			if (_dist < distance_to_flipman) {
				new_dir	= 90;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 90) { // DOWN
		if (!place_meeting(x, y+2, oWall)) {
			var _dist = point_distance(x, y+GRID, oFlipMan.x, oFlipMan.y);
			if (_dist < distance_to_flipman) {
				new_dir	= 270;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 0) { // LEFT
		if (!place_meeting(x-2, y, oWall)) {
			var _dist = point_distance(x-GRID, y, oFlipMan.x, oFlipMan.y);
			if (_dist < distance_to_flipman) {
				new_dir	= 180;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 180) { // RIGHT
		if (!place_meeting(x+2, y, oWall)) {
			var _dist = point_distance(x+GRID, y, oFlipMan.x, oFlipMan.y);
			if (_dist < distance_to_flipman) {
				new_dir	= 0;
				distance_to_flipman = _dist;
			}
		}
	}

	if (new_dir != -1) {
		direction = new_dir;
	}
}
	
function pink_ghost_ai() {
	// Movement
	var new_dir = -1;
	var distance_to_flipman = 9999999;
	
	var _size = GRID * 4;
	
	var x_dirs = [_size, -_size, -_size, 0];
	var y_dirs = [0, -_size, 0, _size];
	
	var dx = x_dirs[oFlipMan.direction / 90];
	var dy = y_dirs[oFlipMan.direction / 90];

	if (direction != 270) { // UP
		if (!place_meeting(x, y-2, oWall)) {
			var _dist = point_distance(x, y-GRID, oFlipMan.x+dx, oFlipMan.y+dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 90;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 90) { // DOWN
		if (!place_meeting(x, y+2, oWall)) {
			var _dist = point_distance(x, y+GRID, oFlipMan.x+dx, oFlipMan.y+dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 270;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 0) { // LEFT
		if (!place_meeting(x-2, y, oWall)) {
			var _dist = point_distance(x-GRID, y, oFlipMan.x+dx, oFlipMan.y+dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 180;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 180) { // RIGHT
		if (!place_meeting(x+2, y, oWall)) {
			var _dist = point_distance(x+GRID, y, oFlipMan.x+dx, oFlipMan.y+dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 0;
				distance_to_flipman = _dist;
			}
		}
	}

	if (new_dir != -1) {
		direction = new_dir;
	}
}
	
function orange_ghost_ai() {
	// Movement
	var new_dir = -1;
	var distance_to_flipman = 9999999;
	
	var dx = oFlipMan.x;
	var dy = oFlipMan.y;
	
	if (point_distance(x, y, oFlipMan.x, oFlipMan.y) < 160) {
		dx = 16;
		dy = 296;
	}

	if (direction != 270) { // UP
		if (!place_meeting(x, y-2, oWall)) {
			var _dist = point_distance(x, y-GRID, dx, dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 90;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 90) { // DOWN
		if (!place_meeting(x, y+2, oWall)) {
			var _dist = point_distance(x, y+GRID, dx, dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 270;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 0) { // LEFT
		if (!place_meeting(x-2, y, oWall)) {
			var _dist = point_distance(x-GRID, y, dx, dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 180;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 180) { // RIGHT
		if (!place_meeting(x+2, y, oWall)) {
			var _dist = point_distance(x+GRID, y, dx, dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 0;
				distance_to_flipman = _dist;
			}
		}
	}

	if (new_dir != -1) {
		direction = new_dir;
	}
}
	
function blue_ghost_ai() {
	// Movement
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

	if (direction != 270) { // UP
		if (!place_meeting(x, y-2, oWall)) {
			var _dist = point_distance(x, y-GRID, dx, dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 90;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 90) { // DOWN
		if (!place_meeting(x, y+2, oWall)) {
			var _dist = point_distance(x, y+GRID, dx, dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 270;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 0) { // LEFT
		if (!place_meeting(x-2, y, oWall)) {
			var _dist = point_distance(x-GRID, y, dx, dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 180;
				distance_to_flipman = _dist;
			}
		}
	}

	if (direction != 180) { // RIGHT
		if (!place_meeting(x+2, y, oWall)) {
			var _dist = point_distance(x+GRID, y, dx, dy);
			if (_dist < distance_to_flipman) {
				new_dir	= 0;
				distance_to_flipman = _dist;
			}
		}
	}

	if (new_dir != -1) {
		direction = new_dir;
	}
}
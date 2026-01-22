/// @description Enemy collision system — configurable list of objects enemies collide with.
/// Set global.enemy_collision_objects in oGameManager (or edit default above). Use enemy_collision_add/remove for runtime changes.

/// @description Returns the list of objects enemies collide with. Uses global.enemy_collision_objects.
function enemy_collision_objects() {
	if (!variable_global_exists("enemy_collision_objects")) {
		global.enemy_collision_objects = [oWall, oNerdDoor];
	}
	return global.enemy_collision_objects;
}

/// @description Add an object to the enemy collision list. Call at runtime to enable collision with new object types.
/// @param {asset.GMObject} obj — Object (e.g. oWall, oNerdDoor) to add
function enemy_collision_add(obj) {
	var _list = enemy_collision_objects();
	for (var i = 0; i < array_length(_list); i++) {
		if (_list[i] == obj) return; // already in list
	}
	array_push(_list, obj);
}

/// @description Remove an object from the enemy collision list. Call at runtime to stop colliding with that type.
/// @param {asset.GMObject} obj — Object to remove
function enemy_collision_remove(obj) {
	var _list = enemy_collision_objects();
	for (var i = array_length(_list) - 1; i >= 0; i--) {
		if (_list[i] == obj) {
			array_delete(_list, i, 1);
			return;
		}
	}
}

/// @description Returns true if the calling instance would collide with any enemy collision object at (px, py).
/// @param {real} px — X position to check
/// @param {real} py — Y position to check
/// @param {array} [exclude] — Optional array of objects to ignore (e.g. [oNerdDoor] for dead ghosts)
/// @param {array} [include] — Optional. If provided, only check these objects instead of the global list (exclude still applies)
function enemy_collision_at(px, py, exclude, include) {
	var _list = enemy_collision_objects();
	if (argument_count >= 4 && is_array(include) && array_length(include) > 0)
		_list = include;
	var _ex = (argument_count >= 3 && is_array(exclude)) ? exclude : [];
	for (var i = 0; i < array_length(_list); i++) {
		var _obj = _list[i];
		var _skip = false;
		for (var j = 0; j < array_length(_ex); j++) {
			if (_ex[j] == _obj) { _skip = true; break; }
		}
		if (_skip) continue;
		if (place_meeting(px, py, _obj)) return true;
	}
	return false;
}

/// @description Returns true if both (x_move, y_move) and (x_grid, y_grid) are clear. Use for AI pathfinding (move + grid check).
/// @param {array} [exclude] — Optional array of objects to ignore (e.g. [oNerdDoor] for dead_ghost_ai)
/// @param {array} [include] — Optional. If provided, only check these objects instead of the global list
function enemy_direction_clear(x_move, y_move, x_grid, y_grid, exclude, include) {
	return !enemy_collision_at(x_move, y_move, exclude, include)
		&& !enemy_collision_at(x_grid, y_grid, exclude, include);
}

/// @description Move the calling instance in direction _dir by _spd, stopping before any enemy collision object.
/// @param {real} _dir — Direction in degrees (0=right, 90=up, 180=left, 270=down)
/// @param {real} _spd — Distance to move
/// @param {array} [exclude] — Optional array of objects to ignore (e.g. [oNerdDoor] when nerd_state == s.DEAD)
/// @param {array} [include] — Optional. If provided, only check these objects instead of the global list
function enemy_move_with_collision(_dir, _spd, exclude, include) {
	var _rem = _spd;
	var _step = 1;
	while (_rem > 0) {
		var _move = min(_step, _rem);
		var _nx = x + lengthdir_x(_move, _dir);
		var _ny = y + lengthdir_y(_move, _dir);
		if (enemy_collision_at(_nx, _ny, exclude, include)) break;
		x = _nx;
		y = _ny;
		_rem -= _move;
	}
}

/// @description Nearest tile center on an axis (8, 24, 40 … for GRID 16).
function player_nearest_lane_coord(_pos) {
	return round((_pos - GRID / 2) / GRID) * GRID + GRID / 2;
}

function player_path_clear_from(_px, _py, _dir) {
	var _tx = _px + lengthdir_x(TURN_PROBE, _dir);
	var _ty = _py + lengthdir_y(TURN_PROBE, _dir);
	return !place_meeting(_tx, _ty, oWall) && !place_meeting(_tx, _ty, oNerdDoor);
}

/// @description Body and path are clear for a turn at a candidate position.
function player_pose_valid_for_turn(_px, _py, _dir) {
	if (place_meeting(_px, _py, oWall) || place_meeting(_px, _py, oNerdDoor))
		return false;
	return player_path_clear_from(_px, _py, _dir);
}

function player_apply_facing(_dir) {
	direction = _dir;
	if (_dir == 180)
		image_xscale = 1;
	else if (_dir == 0)
		image_xscale = -1;
}

function player_pose_push_unique(_poses, _px, _py) {
	for (var i = 0; i < array_length(_poses); i++) {
		if (_poses[i][0] == _px && _poses[i][1] == _py)
			return;
	}
	array_push(_poses, [_px, _py]);
}

/// @description Candidate positions: current, lane-centered, junction, then rewind along travel for late turns.
function player_collect_turn_poses(_dir) {
	var _poses = [];
	var _cur = direction;

	player_pose_push_unique(_poses, x, y);

	if (_dir == _cur || _dir == (_cur + 180) mod 360)
		return _poses;

	if (_cur == 90 || _cur == 270) {
		var _lx = player_nearest_lane_coord(x);
		var _jy = player_nearest_lane_coord(y);
		player_pose_push_unique(_poses, _lx, y);
		player_pose_push_unique(_poses, _lx, _jy);

		// Rewind along Y toward junction when past the center (late turn)
		if (_cur == 90) {
			if (y < _jy) {
				for (var i = 1; i <= LATE_TURN_MAX; i++) {
					var _ty = y + i;
					if (_ty > _jy)
						break;
					player_pose_push_unique(_poses, _lx, _ty);
				}
			}
		} else {
			if (y > _jy) {
				for (var j = 1; j <= LATE_TURN_MAX; j++) {
					var _ty2 = y - j;
					if (_ty2 < _jy)
						break;
					player_pose_push_unique(_poses, _lx, _ty2);
				}
			}
		}
	} else if (_cur == 0 || _cur == 180) {
		var _ly = player_nearest_lane_coord(y);
		var _jx = player_nearest_lane_coord(x);
		player_pose_push_unique(_poses, x, _ly);
		player_pose_push_unique(_poses, _jx, _ly);

		if (_cur == 0) {
			if (x > _jx) {
				for (var k = 1; k <= LATE_TURN_MAX; k++) {
					var _tx = x - k;
					if (_tx < _jx)
						break;
					player_pose_push_unique(_poses, _tx, _ly);
				}
			}
		} else {
			if (x < _jx) {
				for (var m = 1; m <= LATE_TURN_MAX; m++) {
					var _tx2 = x + m;
					if (_tx2 > _jx)
						break;
					player_pose_push_unique(_poses, _tx2, _ly);
				}
			}
		}
	}

	return _poses;
}

/// @description Try turn in place, or rewind along the corridor to the last valid junction pose.
function player_try_turn(_dir) {
	var _poses = player_collect_turn_poses(_dir);
	for (var i = 0; i < array_length(_poses); i++) {
		var _p = _poses[i];
		if (player_pose_valid_for_turn(_p[0], _p[1], _dir)) {
			x = _p[0];
			y = _p[1];
			player_apply_facing(_dir);
			return true;
		}
	}
	return false;
}

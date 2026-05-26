/// @description Layout shared by draw + input (GUI space).
function touch_controls_layout() {
	var _strip_top = global.play_h;
	var _strip_h = global.base_h - global.play_h;
	var _cx = global.base_w / 2;
	var _cy = _strip_top + _strip_h / 2;
	var _r = 20;
	var _gap = 16;
	var _step = _r * 2 + _gap;
	return {
		strip_top: _strip_top,
		strip_h: _strip_h,
		r: _r,
		hit_r: _r + 6,
		dirs: [180, 270, 90, 0],
		x: [_cx - _step * 1.5, _cx - _step * 0.5, _cx + _step * 0.5, _cx + _step * 1.5],
		y: [_cy, _cy, _cy, _cy]
	};
}

function touch_controls_gameplay_active() {
	if (room == rMenu)
		return false;
	if (!instance_exists(oLevelManager) || !instance_exists(oFlipMan))
		return false;
	if (!oLevelManager.start || oLevelManager.over || oLevelManager.won || oLevelManager.impact_pause)
		return false;
	if (global.game_paused)
		return false;
	return true;
}

/// @description Read GUI touch/mouse; drive oFlipMan like held arrow keys.
function touch_controls_poll() {
	global.touch_ctrl_pressed_dir = -1;

	if (!touch_controls_gameplay_active())
		return;

	var _layout = touch_controls_layout();
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _down = device_mouse_check_button(0, mb_left);

	var _hit_dir = -1;
	var _best = infinity;
	for (var i = 0; i < 4; i++) {
		var _d = point_distance(_mx, _my, _layout.x[i], _layout.y[i]);
		if (_d <= _layout.hit_r && _d < _best) {
			_best = _d;
			_hit_dir = _layout.dirs[i];
		}
	}

	if (_down && _hit_dir != -1) {
		global.touch_ctrl_pressed_dir = _hit_dir;
		with (oFlipMan) {
			touch_buffered_dir = _hit_dir;
			player_try_turn(_hit_dir);
		}
	}
}

function draw_touch_controls_dpad() {
	if (room == rMenu)
		return;

	var _layout = touch_controls_layout();
	draw_touch_controls_strip_bg(_layout.strip_top, _layout.strip_h);

	for (var i = 0; i < 4; i++) {
		var _dir = _layout.dirs[i];
		var _pressed = (global.touch_ctrl_pressed_dir == _dir);
		draw_touch_control_arrow(_layout.x[i], _layout.y[i], _layout.r, _dir, _pressed);
	}
}

function draw_touch_controls_strip_bg(_top, _h) {
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_rectangle(0, _top, global.base_w, _top + _h, false);
}

/// @param {real} _cx Center x (GUI)
/// @param {real} _cy Center y (GUI)
/// @param {real} _r Button radius
/// @param {real} _dir Arrow direction (0 right, 90 up, 180 left, 270 down)
/// @param {bool} _pressed
function draw_touch_control_arrow(_cx, _cy, _r, _dir, _pressed) {
	var _fill = _pressed ? make_color_rgb(56, 56, 104) : make_color_rgb(28, 28, 56);
	var _rim = _pressed ? make_color_rgb(255, 220, 64) : make_color_rgb(140, 140, 210);
	var _arrow = _pressed ? c_white : make_color_rgb(255, 220, 64);
	var _draw_r = _pressed ? _r - 1 : _r;
	var _ox = _pressed ? 0 : 0;
	var _oy = _pressed ? 1 : 0;

	draw_set_alpha(1);
	draw_set_color(_fill);
	draw_circle(_cx + _ox, _cy + _oy, _draw_r, false);

	draw_set_color(_rim);
	draw_circle(_cx + _ox, _cy + _oy, _draw_r, true);

	var _half_len = _draw_r * 0.38;
	var _half_w = _draw_r * 0.32;
	var _tx = _cx + _ox + lengthdir_x(_half_len, _dir);
	var _ty = _cy + _oy + lengthdir_y(_half_len, _dir);
	var _bx = _cx + _ox - lengthdir_x(_half_len, _dir);
	var _by = _cy + _oy - lengthdir_y(_half_len, _dir);
	var _wx = lengthdir_x(_half_w, _dir + 90);
	var _wy = lengthdir_y(_half_w, _dir + 90);

	draw_set_color(_arrow);
	draw_triangle(_tx, _ty, _bx + _wx, _by + _wy, _bx - _wx, _by - _wy, false);

	draw_set_color(c_white);
}

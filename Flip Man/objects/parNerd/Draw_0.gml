// Handle blinking when frightened state is about to end
var _should_blink = false;
var _blink_white = false;

if (nerd_state == STATE_FRIGHTENED) {
	// Blink during the last 2 seconds (120 frames) before returning to chase/scatter
	var _time_remaining = alarm[0];
	if (_time_remaining <= SECOND * 2) {
		_should_blink = true;
		// Blink every 10 frames (6 times per second)
		var _blink_frame = floor(_time_remaining / 10);
		_blink_white = (_blink_frame mod 2 == 0);
	}
}

// Draw the sprite with blinking color if needed
if (_should_blink && _blink_white) {
	// Draw white (blinking)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 0);
} else {
	// Draw normally (blue ghost when frightened, normal sprite otherwise)
	draw_self();
}

if (!global.dev_mode) exit;

// Get state name
var _state_name = "?";
if (nerd_state == STATE_CHASE) {
	_state_name = "C";
} else if (nerd_state == STATE_SCATTER) {
	_state_name = "S";
} else if (nerd_state == STATE_FRIGHTENED) {
	_state_name = "F";
} else if (nerd_state == STATE_DEAD) {
	_state_name = "D";
}

// Draw debug text above the enemy
draw_set_font(fntSmall);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);

// Position text above the sprite
draw_text(x, y, _state_name);

// Calculate and draw target position
var _target_x = 0;
var _target_y = 0;
var _has_target = false;
var _col = c_green;

if (nerd_state == STATE_SCATTER) {
	// Scatter mode: target is scatter corner
	_target_x = scatter_x;
	_target_y = scatter_y;
	_has_target = true;
} else if (nerd_state == STATE_CHASE) {
	if (instance_exists(oFlipMan)) {
		// Chase mode: target depends on AI type
		if (ai == red_ghost_ai) {
			// Red: Directly targets FlipMan
			_target_x = oFlipMan.x;
			_target_y = oFlipMan.y;
			_has_target = true;
			_col = c_red;
		} else if (ai == pink_ghost_ai) {
			// Pink: Targets 4 tiles ahead of FlipMan's direction
			var _size = GRID * 4;
			var x_dirs = [_size, -_size, -_size, 0];
			var y_dirs = [0, -_size, 0, _size];
			var dx = x_dirs[oFlipMan.direction / 90];
			var dy = y_dirs[oFlipMan.direction / 90];
			_target_x = oFlipMan.x + dx;
			_target_y = oFlipMan.y + dy;
			_has_target = true;
			_col = c_fuchsia;
		} else if (ai == orange_ghost_ai) {
			// Orange: Targets FlipMan if far, otherwise scatter corner
			if (point_distance(x, y, oFlipMan.x, oFlipMan.y) < 160) {
				_target_x = 16;
				_target_y = 296;
			} else {
				_target_x = oFlipMan.x;
				_target_y = oFlipMan.y;
			}
			_has_target = true;
			_col = c_orange;
		} else if (ai == blue_ghost_ai) {
			// Blue: Targets position based on Howard and FlipMan
			var _size = GRID * 2;
			var x_dirs = [_size, -_size, -_size, 0];
			var y_dirs = [0, -_size, 0, _size];
			var dx = oNerdHoward.x + x_dirs[oFlipMan.direction / 90];
			var dy = oNerdHoward.y + y_dirs[oFlipMan.direction / 90];
			var ddx = oNerdHoward.x - dx;
			var ddy = oNerdHoward.y - dy;
			_target_x = dx - ddx;
			_target_y = dy - ddy;
			_has_target = true;
			_col = c_blue;
		}
	}
}

// Draw target circle if we have a target
if (_has_target) {
	draw_set_color(_col);
	draw_circle(_target_x, _target_y, 3, false);
	draw_circle(_target_x, _target_y, 2, true);
}

// Reset alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
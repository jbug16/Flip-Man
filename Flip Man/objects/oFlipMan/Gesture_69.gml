// Only when gameplay is active
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won || oLevelManager.impact_pause || global.game_paused)
	exit;

var _diffX = event_data[? "diffX"];
var _diffY = event_data[? "diffY"];
// Ignore very small flicks
if (point_distance(0, 0, _diffX, _diffY) < 8)
	exit;

var _a;
if (abs(_diffX) >= abs(_diffY)) {
	_a = (_diffX >= 0) ? 0 : 180;
} else {
	_a = (_diffY >= 0) ? 270 : 90;
}

touch_buffered_dir = _a;
// Only when gameplay is active
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won || oLevelManager.impact_pause || global.game_paused)
	exit;

var _posX = event_data[? "posX"];
var _posY = event_data[? "posY"];
var _vx = _posX - x;
var _vy = _posY - y;
if (point_distance(0, 0, _vx, _vy) < 8)
	exit;

// Dominant axis: more reliable than rounding angle (fewer wrong up/down vs left/right picks)
var _a;
if (abs(_vx) >= abs(_vy)) {
	_a = (_vx >= 0) ? 0 : 180;
} else {
	_a = (_vy >= 0) ? 270 : 90;
}

touch_buffered_dir = _a;
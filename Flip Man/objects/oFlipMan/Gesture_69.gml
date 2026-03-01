// Only when gameplay is active
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won || oLevelManager.impact_pause || oLevelManager.paused)
	exit;

var _diffX = event_data[? "diffX"];
var _diffY = event_data[? "diffY"];
// Ignore very small flicks
if (point_distance(0, 0, _diffX, _diffY) < 8)
	exit;

var _angle = point_direction(0, 0, _diffX, _diffY);
var _a = (round(_angle / 90) * 90) mod 360;
if (_a == 360) _a = 0;

touch_direction = _a;
touch_one_move = true;
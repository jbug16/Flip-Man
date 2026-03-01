// Only when gameplay is active
if (!oLevelManager.start || oLevelManager.over || oLevelManager.won || oLevelManager.impact_pause || oLevelManager.paused)
	exit;

var _posX = event_data[? "posX"];
var _posY = event_data[? "posY"];
var _angle = point_direction(x, y, _posX, _posY);
var _a = (round(_angle / 90) * 90) mod 360;
if (_a == 360) _a = 0;

touch_direction = _a;
touch_one_move = true;
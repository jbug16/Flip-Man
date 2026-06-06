// Drag end — slow swipes (PM256 cached movement)
if (!player_input_gameplay_active())
	exit;

var _dir = player_swipe_dir_from_delta(event_data[? "diffX"], event_data[? "diffY"]);
if (_dir == -1)
	exit;

player_cache_dir(_dir);

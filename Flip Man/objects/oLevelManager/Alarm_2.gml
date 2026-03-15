/// @desc Next level

// Don't proceed if game is paused
if (global.game_paused) {
	alarm[2] = 1; // Check again next frame
	exit;
}

room_goto_next();
blink_counter = 0;
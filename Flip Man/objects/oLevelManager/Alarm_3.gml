/// @desc End eat impact pause

// Don't proceed if game is paused
if (global.game_paused) {
	alarm[3] = 1; // Check again next frame
	exit;
}

impact_pause = false;

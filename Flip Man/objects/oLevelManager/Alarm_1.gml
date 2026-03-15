/// @desc Game over

// Don't proceed if game is paused
if (global.game_paused) {
	alarm[1] = 1; // Check again next frame
	exit;
}

game_restart();
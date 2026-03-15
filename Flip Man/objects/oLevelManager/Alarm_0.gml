/// @desc Game start

// Don't start if game is paused
if (global.game_paused) {
	alarm[0] = 1; // Check again next frame
	exit;
}

ready = false;
start = true;
over = false;
won = false;
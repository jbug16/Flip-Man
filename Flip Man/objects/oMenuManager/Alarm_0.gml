// Don't proceed if game is paused
if (global.game_paused) {
	alarm[0] = 1; // Check again next frame
	exit;
}

// Check if we're in credits room
if (room == rCredits) {
	// Credits finished, go back to menu screen
	room_goto(rMenu);
} else {
	// Tutorial finished, go to first level
	show_tutorial = false;
	layer_set_visible("Tutorial", false);
	room_goto(rLevel1);
	audio_play_sound(sndStartup, 1, false);
}
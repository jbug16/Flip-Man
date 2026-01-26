// Check if we're in credits room
if (room == rCredits) {
	// Credits finished, restart the game
	game_restart();
} else {
	// Tutorial finished, go to first level
	show_tutorial = false;
	room_goto(rLevel1);
	audio_play_sound(sndStartup, 1, false);
}
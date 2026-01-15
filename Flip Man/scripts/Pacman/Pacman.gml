function CheckHighscore() {
	// Check and update highscore
	if (global.points > global.highscore) {
		global.highscore = global.points;
		var _ini = ini_open("highscore.ini");
		ini_write_real("Highscore", "score", global.highscore);
		ini_close();
		
		// SFX
		if (!beat_highscore) {
			beat_highscore = true; // doesn't play again
			audio_play_sound(sndHighscore, 2, false);
		}
	}
}
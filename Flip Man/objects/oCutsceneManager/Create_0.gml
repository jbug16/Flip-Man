// First cutscene
if (room == rCutscence1) {
	// Background music
	audio_play_sound(sndIntermission_1, 0, false);
	
	// Animation done
	alarm[0] = SECOND * (audio_sound_length(sndIntermission_1));
}

// Last cutscene
if (room == rCutscence2) {
	// Background music
	audio_play_sound(sndIntermission, 0, false);
	
	// Animation done
	alarm[1] = SECOND * (audio_sound_length(sndIntermission));
}
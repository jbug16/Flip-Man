// First cutscene
if (room == rCutscence1) {
	// Background music
	audio_play_sound(sndIntermission, 0, true);
	
	// Animation done
	alarm[0] = SECOND * (audio_sound_length(sndIntermission) * 2) + 1;
}

// Last cutscene
if (room == rCutscence2) {
	// Background music
	audio_play_sound(sndIntermission, 0, true);
	
	// Animation done
	alarm[1] = SECOND * (audio_sound_length(sndIntermission) * 2) + 1;
}
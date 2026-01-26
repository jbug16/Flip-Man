audio_stop_all();

// First cutscene
if (room == rCutscence1) {
	// Background music
	audio_play_sound(sndIntermission1, 0, false);
	
	// Animation done
	alarm[0] = SECOND * (audio_sound_length(sndIntermission1));
}

// Next cutscene
if (room == rCutscence2) {
	// Background music
	audio_play_sound(sndIntermission2, 0, false);
	
	// Animation done
	alarm[1] = SECOND * (audio_sound_length(sndIntermission2));
}

// Last cutscene
if (room == rCutscence3) {
	// Background music
	audio_play_sound(sndIntermission3, 0, false);
	
	// Animation done
	alarm[2] = SECOND * (audio_sound_length(sndIntermission3));
}
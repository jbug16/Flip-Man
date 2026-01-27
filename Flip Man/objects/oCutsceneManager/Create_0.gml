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

// Highscore cutscene
if (room == rCutscence4) {
	// No background music for this cutscene
	// Just show text for a few seconds
	alarm[3] = SECOND * 5; // Show for 3 seconds
}
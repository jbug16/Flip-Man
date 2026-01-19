// Background music
if (room == rCutscence) audio_play_sound(sndIntermission, 0, true);

// Animation done
alarm[0] = SECOND * (audio_sound_length(sndIntermission) * 2) + 1;
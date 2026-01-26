// Blink timer for "INSERT COIN" text
arrow_blink = 0;

// Tutorial state
show_tutorial = false;

// Credits room - set timer to restart after 10 seconds
if (room == rCredits) {
	audio_stop_all();
	alarm[0] = SECOND * 10;
}
// Check if we're in a cutscene room with sequences
if (room == rCutscence1 || room == rCutscence2 || room == rCutscence3 || room == rCutscence4) {
	var _layer_id = layer_get_id("Animation");
	var _seq_id = -1;
	var a = layer_get_all_elements(_layer_id);
	for (var i = 0; i < array_length(a); i++)
	{
	    if (layer_get_element_type(a[i]) == layerelementtype_sequence)
	    {
	        _seq_id = a[i];
	        break;
	    }
	}
	
	if (global.game_paused) {
		layer_sequence_pause(_seq_id);
	} else if (layer_sequence_is_paused(_seq_id)) {
		layer_sequence_play(_seq_id);
	}
}

if (global.game_paused) {
	// First cutscene
	if (room == rCutscence1) {
		alarm[0] += 1;
	}

	// Next cutscene
	if (room == rCutscence2) {
		alarm[1] += 1;
	}

	// Last cutscene
	if (room == rCutscence3) {
		alarm[2] += 1;
	}

	// Highscore cutscene
	if (room == rCutscence4) {
		alarm[3] += 1;
	}
}

/*
// Update timer
if (!global.game_paused) timer--;
else print("timer paused");

// Carry out transitions
if (timer < 0) {
	print("timer done");
	switch (room) {
		case rCutscence3:
			// Check if player achieved a new highscore
			if (global.points > global.highscore or global.points >= 99000) {
				// New highscore achieved - go to cutscene 4
				room_goto(rCutscence4);
			} else {
				// No new highscore - skip to credits
				room_goto(rCredits);
			}
			break;
		
		case rCutscence4:
			audio_stop_all();
			room_goto(rCredits);
			break;
		
		default:
			audio_stop_all();
			room_goto_next();
			break;
	}
}

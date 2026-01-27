// Check if player achieved a new highscore
if (global.points > global.highscore) {
	// New highscore achieved - go to cutscene 4
	room_goto(rCutscence4);
} else {
	// No new highscore - skip to credits
	room_goto(rCredits);
}
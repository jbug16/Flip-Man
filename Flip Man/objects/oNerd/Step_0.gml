//if (ghost_mode) {
//	sprite_index = ghost_sprite;
//}
//else sprite_index = nerd_sprite;

// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over) exit;

// Movement
choices = [];
number_of_choices = 0;

if (direction != 270) { // UP
	if (!place_meeting(x, y-2, oWall)) {
		choices[number_of_choices] = 90;
		++number_of_choices;
	}
}

if (direction != 90) { // DOWN
	if (!place_meeting(x, y+2, oWall)) {
		choices[number_of_choices] = 270;
		++number_of_choices;
	}
}

if (direction != 0) { // LEFT
	if (!place_meeting(x-2, y, oWall)) {
		choices[number_of_choices] = 180;
		++number_of_choices;
	}
}

if (direction != 180) { // RIGHT
	if (!place_meeting(x+2, y, oWall)) {
		choices[number_of_choices] = 0;
		++number_of_choices;
	}
}

if (number_of_choices > 0) {
	direction = choices[irandom(number_of_choices - 1)];
}

move_contact_solid(direction, spd);
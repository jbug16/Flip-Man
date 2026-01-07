// Don't move if game hasn't started or is over
if (!oLevelManager.start || oLevelManager.over) exit;

// Movement
script_execute(ai);

// Collision
move_contact_solid(direction, spd);

// Goes off screen, loop around
if (x < -0) { // LEFT
	x = room_width;
}
else if (x > room_width) { // RIGHT
	x = 0;
}
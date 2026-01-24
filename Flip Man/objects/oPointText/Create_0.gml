// Initialize point text
// point_value should be set by the creating instance
if (!variable_instance_exists(id, "point_value")) {
	point_value = 0;
}

// Starting position and animation variables
start_y = y;
move_speed = -0.3; // Move upward slowly (reduced from -1)
duration = SECOND * 1.5; // 1.5 seconds
timer = 0;
alpha = 1.0;

// Set alarm to destroy after duration
alarm[0] = duration;

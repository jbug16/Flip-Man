// Check for any key press to start game
if (!show_tutorial) {
    // Start tutorial
	layer_set_visible("Assets", false);
	show_tutorial = true;
	layer_set_visible("Tutorial", true);
	alarm[0] = SECOND * 18; // 18 seconds
}
// Check for key press to skip tutorial
else alarm[0] = 1;

// Check for key press to skip credits
if (room == rCredits) alarm[0] = 1;
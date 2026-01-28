// Update blink timer for "INSERT COIN" text
arrow_blink += 0.1;

// Check for any key press to start game
if (keyboard_check_pressed(vk_anykey) && !show_tutorial) {
    // Start tutorial
	layer_set_visible("Assets", false);
	show_tutorial = true;
	layer_set_visible("Tutorial", true);
	alarm[0] = SECOND * 18; // 18 seconds
}
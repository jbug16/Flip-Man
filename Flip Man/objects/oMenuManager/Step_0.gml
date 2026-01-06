// KeyPress_Up or KeyPress_Down
if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down)) {
    menu_selection = 1 - menu_selection; // Toggle between 0 and 1
}

// KeyPress_Enter or KeyPress_Space
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    if (menu_selection == 0) {
        // Start 1 player game
        // room_goto(rGame); // Replace with your game room
		print("Start p1");
    } else {
        // Start 2 player game
        // room_goto(rGame2P); // Replace with your 2P room
		print("Start p2");
    }
}
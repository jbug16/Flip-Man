// Update blink timer for "INSERT COIN" text
arrow_blink += 0.1;

// Check for any key press to start game
if (keyboard_check_pressed(vk_anykey)) {
    // Start game
    room_goto(rLevel1);
    audio_play_sound(sndStartup, 1, false);
}
ready = true;		// player can't move
start = false;		// player can move
over = false;		// player can't move + level restart
won = false;		// player can't move + next level

// Coin and snack tracking
coins_eaten = 0;
snack_spawned_first = false;
snack_spawned_second = false;
snack_active = noone;

// Draw helpers
blink_counter = 0;
impact_pause = false;

// Delay for game start
alarm[0] = SECOND * audio_sound_length(sndStartup);
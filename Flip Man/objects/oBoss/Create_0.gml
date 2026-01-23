event_inherited();

spd = 0.9;

// Sprites for normal vs frightened (blue/vulnerable) state
nerd_sprite = sBoss;
ghost_sprite = sTestBlob2;

// Set a custom state that won't be affected by parent logic
nerd_state = s.CHASE;
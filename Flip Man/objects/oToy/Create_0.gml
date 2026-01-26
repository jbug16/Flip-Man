// Assign sToy1–sToy4 using room imageIndex (0,1,2,4 from editor); one of each per level
var _idx = min(image_index, 3);
var _sprites = [sToy1, sToy2, sToy3, sToy4];
sprite_index = _sprites[_idx];
image_index = 0;
image_speed = 0; // Stop animation to prevent frame-based blinking

// Pulsation variables
pulse_timer = 0;
pulse_speed = 0.15;
pulse_min_scale = 0.6;
pulse_max_scale = 0.9;

// Initialize scale to minimum (will be updated in Step event)
image_xscale = pulse_min_scale;
image_yscale = pulse_min_scale;
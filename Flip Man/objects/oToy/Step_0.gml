// Update pulsation timer and scale
pulse_timer += pulse_speed;

// Calculate and set pulsating scale using sine wave
// sin() returns -1 to 1, so (sin() + 1) / 2 gives us 0 to 1, which we map to our scale range
var _scale = pulse_min_scale + (pulse_max_scale - pulse_min_scale) * (sin(pulse_timer) + 1) / 2;
image_xscale = _scale;
image_yscale = _scale;


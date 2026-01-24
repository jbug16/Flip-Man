// Move upward
y += move_speed;

// Update timer and calculate fade alpha
timer++;
var _progress = timer / duration;
alpha = 1.0 - _progress; // Fade from 1.0 to 0.0

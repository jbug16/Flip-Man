// Logical resolution: 256×368 (playfield y0–319, control strip y320–367)
global.base_w = 256;
global.base_h = 368;
global.play_h = 320;

// Actual device resolution
var disp_w = display_get_width();
var disp_h = display_get_height();

// Aspect ratios
var base_ratio    = global.base_w / global.base_h;
var display_ratio = disp_w / disp_h;

// How much of the room the camera should see
var view_w, view_h;

if (display_ratio > base_ratio) {
    // Phone is relatively wider than your game
    view_h = global.base_h;
    view_w = view_h * display_ratio;
} else {
    // Phone is relatively taller/narrower
    view_w = global.base_w;
    view_h = view_w / display_ratio;
}

// Apply to camera 0
var cam = view_camera[0];
camera_set_view_size(cam, view_w, view_h);

// Top-align view so the maze/HUD stay fixed; extra room height is the bottom control strip
var _cam_x = max(0, (room_width - view_w) * 0.5);
var _cam_y = 0;
if (view_h > room_height)
	_cam_y = (room_height - view_h) * 0.5;
camera_set_view_pos(cam, _cam_x, _cam_y);

display_set_gui_size(global.base_w, global.base_h);
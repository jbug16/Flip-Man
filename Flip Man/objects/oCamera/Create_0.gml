// Your logical game resolution
global.base_w = 256;
global.base_h = 320;

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

// Center the camera in the room if room is larger than 256x320
camera_set_view_pos(cam, (room_width - view_w) * 0.5, (room_height - view_h) * 0.5);

// GUI: keep UI in 256x320 logical space
display_set_gui_size(global.base_w, global.base_h);
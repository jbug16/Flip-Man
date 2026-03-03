if (!global.dev_mode) exit;

// 0 – reset to your current dev size
if (keyboard_check_pressed(ord("0")))
{
    window_set_size(512, 640);
    window_center();
}

// 1 – iPhone 8 / SE-style (16:9)
if (keyboard_check_pressed(ord("1")))
{
    window_set_size(750, 1334);
    window_center();
}

// 2 – Modern iPhone (13/14 style, tall)
if (keyboard_check_pressed(ord("2")))
{
    window_set_size(1170, 2532);
    window_center();
}

// 3 – iPad (4:3)
if (keyboard_check_pressed(ord("3")))
{
    window_set_size(1536, 2048);
    window_center();
}

// 4 – Android classic (16:9)
if (keyboard_check_pressed(ord("4")))
{
    window_set_size(1080, 1920);
    window_center();
}

// 5 – Tall Android (20:9)
if (keyboard_check_pressed(ord("5")))
{
    window_set_size(1080, 2400);
    window_center();
}

// room controls
if (keyboard_check_pressed(ord("A"))) {
    room_goto_previous();
}

if (keyboard_check_pressed(ord("D"))) {
    room_goto_next();
}
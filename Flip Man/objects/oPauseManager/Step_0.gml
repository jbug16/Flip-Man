/// @description OS pause detection and resume handling

// Detect when OS pauses the app (app backgrounded)
if (os_is_paused() && !global.app_was_paused)
{
    global.app_was_paused = true;
    
    // Mark game as paused
    global.game_paused = true;
    
    // Show pause menu when app resumes
    show_pause_menu = false; // Don't show yet, wait for resume
}

// Detect when app resumes from background
if (global.app_was_paused && !os_is_paused())
{
    global.app_was_paused = false;
    
    // Keep game paused until player explicitly resumes
    global.game_paused = true;
    
    // Show pause menu on resume
    show_pause_menu = true;
}
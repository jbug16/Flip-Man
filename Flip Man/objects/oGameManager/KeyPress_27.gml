// Toggle pause with Escape key
// Only allow pausing if game has started and isn't over/won
if (instance_exists(oLevelManager)) {
	if (oLevelManager.start && !oLevelManager.over && !oLevelManager.won) {
		oLevelManager.paused = !oLevelManager.paused;
	}
}

// Dev mode: end game (only if not paused)
if (global.dev_mode && (!instance_exists(oLevelManager) || !oLevelManager.paused)) {
	game_end();
}
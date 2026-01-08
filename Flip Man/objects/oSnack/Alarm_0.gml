// Timeout - snack wasn't collected, destroy it
// Clear the snack_active reference in oLevelManager
with (oLevelManager) {
	snack_active = noone;
}
instance_destroy();

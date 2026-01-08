// Snack spawning logic
// First snack spawns at 70 coins eaten
if (coins_eaten == 70 && !snack_spawned_first && snack_active == noone) {
	snack_active = instance_create_layer(128, 236, "Coins", oSnack);
	snack_spawned_first = true;
}

// Second snack spawns at 170 coins eaten (only if first has been collected/disappeared)
if (coins_eaten == 170 && snack_spawned_first && snack_active == noone) {
	snack_active = instance_create_layer(128, 236, "Coins", oSnack);
	snack_spawned_second = true;
}

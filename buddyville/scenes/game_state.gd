extends Node
# This script will hold information between switching scenes

# different states of the game
enum{
	MEET,
	COLLECT,
	DIG,
	CHOP,
	POISON,
	BURY,
	BEAT,
	AXE,
	COMPLETE
}

# keeps track of which quest player is on
var game_state = MEET
# player inventory
var inventory = []
# player position when swapping scenes
var player_spawn_pos = Vector2(1100, 1100)
# villager states
var villager_state = {
	"Monkey": {
		"met": false,
		"dead": false
	},
	"Owl": {
		"met": false,
		"dead": false
	},
	"Porcupine": {
		"met": false,
		"dead": false
	},
	"Rabbit": {
		"met": false,
		"dead": false
	}
}

func next_game_state():
	self.game_state += 1

func give_item(item: String):
	inventory.push_front(item)
	print(inventory)

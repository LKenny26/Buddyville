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
	AXE
}

# keeps track of which quest player is on
var game_state = MEET
# player inventory
var inventory = []
# player position when swapping scenes
var player_spawn_pos = Vector2(1100, 1100)

func next_game_state():
	self.game_state += 1

func give_item(item: String):
	pass

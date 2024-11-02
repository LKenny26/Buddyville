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

#keeps track of which quest player is on
var game_state = MEET
var inventory = []

func next_game_state():
	self.game_state += 1

func give_item(item: String):
	pass

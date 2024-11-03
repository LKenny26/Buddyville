extends Node
# This script will hold information between switching scenes

# different states of the game
enum{
	PRE,
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

const QUEST_STRINGS = {
	PRE: "Quests you are doing show up here!",
	MEET: "Go meet everyone!\n\n Then, return to Petey",
	COLLECT: "Go collect an apple!\n\n Then, return to Petey",
	DIG: "Go dig up some gold!\n\n Then, return to Petey",
	CHOP: "Go get some wood!\n\n Then, return to Petey",
	POISON: "Go deliver an 'apple' to Rosie! \n\n Then, return to Petey",
	BURY: "Oh no! What have you done.\n\n...What have you done?\n\nDig a hole for Paul!",
	BEAT: "Greet Manny with your hands.\n\n",
	AXE: "\n\n\nI think Oliver is made out of wood.",
	COMPLETE: "\n\n\n ........"
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
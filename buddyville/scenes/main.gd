extends Node2D

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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func give_item(item: String):
	$player.inventory.add(item)

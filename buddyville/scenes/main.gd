extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$player.position = GameState.player_spawn_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

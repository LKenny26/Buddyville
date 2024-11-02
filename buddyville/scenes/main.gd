extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$player.exit.connect(exit_game)
	$player.pause.connect(minimap_toggle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func exit_game():
	get_tree().quit()
	
func minimap_toggle():
	$MiniMap.visible = !$MiniMap.visible

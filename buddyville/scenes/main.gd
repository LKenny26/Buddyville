extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$player.pause.connect(minimap_toggle)
	$player.position = GameState.player_spawn_pos
	if GameState.villager_state["Monkey"]["dead"]:
		$Monkey.queue_free()
	if GameState.villager_state["Owl"]["dead"]:
		$Owl.queue_free()
	if GameState.villager_state["Porcupine"]["dead"]:
		$Porcupine.queue_free()
	if GameState.villager_state["Rabbit"]["dead"]:
		$Rabbit.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func minimap_toggle():
	$MiniMap.visible = !$MiniMap.visible

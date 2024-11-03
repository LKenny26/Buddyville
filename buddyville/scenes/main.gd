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
	$player.set_quest_window()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.grave_state == GameState.DUG:
		$hole.visible = true
	if GameState.grave_state == GameState.BURIED:
		$hole.visible = false
		$grave.visible = true
	if GameState.villager_state["Owl"]["dead"] == true:
		$unalive_owl.visible = true
	
func minimap_toggle():
	$MiniMap.visible = !$MiniMap.visible


func _on_dirt_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if $player.has_shovel && GameState.grave_state == GameState.NOT_DUG:
			$hole.visible = true
			GameState.grave_state = GameState.DUG
			

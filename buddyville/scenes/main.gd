extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Map.connect("entered_building", Callable(self, "switch_indoor"))
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
		if GameState.game_state == GameState.BURY && GameState.grave_state == GameState.NOT_DUG:
			$hole.visible = true
			GameState.grave_state = GameState.DUG
			

func switch_indoor():

	queue_free()
	#tween.tween_callback(func(): main.get_node("./player/QuestHUD").visible = true; main.visible = true; main.get_node("./player").process_mode = Node.PROCESS_MODE_INHERIT)
	#tween.tween_callback(Callable(self, "free"))
	#tween.tween_callback(func(): get_tree().current_scene = main)

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$player.pause.connect(minimap_toggle)
	$player.position = GameState.player_spawn_pos
	if GameState.villager_state["Monkey"]["dead"]:
		$Monkey/AnimatedSprite2D.play("dead_monkey")
	if GameState.villager_state["Owl"]["dead"]:
		$Owl.queue_free()
	if GameState.villager_state["Porcupine"]["dead"]:
		$Porcupine.queue_free()
	if GameState.villager_state["Rabbit"]["dead"]:
		$Rabbit/AnimatedSprite2D.play("rabbit dead")
	$player.set_quest_window()
	$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.grave_state == GameState.DUG:
		$hole.visible = true
	if GameState.grave_state == GameState.BURIED:
		$hole.visible = false
		$grave.visible = true
	if GameState.villager_state["Owl"]["dead"] == true:
		$unalive_owl.visible = true
		$unalive_owl/CollisionShape2D.disabled = false
	
func minimap_toggle():
	$MiniMap.visible = !$MiniMap.visible


func _on_dirt_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if GameState.game_state == GameState.BURY && GameState.grave_state == GameState.NOT_DUG:
			$hole.visible = true
			GameState.grave_state = GameState.DUG
			

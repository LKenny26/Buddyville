extends Node2D

var player_close = false
var sound_player := AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Map.connect("entered_building", Callable(self, "switch_indoor"))
	add_child(sound_player)
	$player.pause.connect(minimap_toggle)
	$player.position = GameState.player_spawn_pos
	if GameState.villager_state["Monkey"]["dead"]:
		GameState.villager_state["Monkey"]["met"] = true
		$Monkey/AnimatedSprite2D.play("dead_monkey")
	if GameState.villager_state["Owl"]["dead"]:
		$Owl.queue_free()
	if GameState.villager_state["Porcupine"]["dead"]:
		$Porcupine.queue_free()
	if GameState.villager_state["Rabbit"]["dead"]:
		GameState.villager_state["Rabbit"]["met"] = true
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
			var dig = load("res://resources/porcupine_death/digging-dirt-cu-variations-06-24481.mp3")
			sound_player.stream = dig
			sound_player.play()
			$player.can_move = false
			await get_tree().create_timer(6.5).timeout
			sound_player.stop()
			$player.can_move = true
			$hole.visible = true
			GameState.grave_state = GameState.DUG
			


func _on_dirt_body_entered(body: Node2D) -> void:
	if body == $player && GameState.game_state == GameState.BURY:
		$dirt/Tooltip.visible = true
		player_close = true


func _on_dirt_body_exited(body: Node2D) -> void:
	$dirt/Tooltip.visible = false
	player_close = false
		

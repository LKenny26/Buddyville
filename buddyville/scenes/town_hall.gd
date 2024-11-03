extends Node2D

func _ready():
	$Panda.connect("update_quest", Callable($player, "set_quest_window"))
	$player.set_quest_window()
	$enter_sfx.play()
	await get_tree().create_timer(2).timeout
	$bgm.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $player:
		$exit_sfx.play()
		$player.process_mode = Node.PROCESS_MODE_DISABLED
		var main_res = load("res://scenes/main.tscn")
		var main = main_res.instantiate()
		get_tree().get_root().add_child(main)
		main.get_node("./player").process_mode = Node.PROCESS_MODE_DISABLED
		main.visible = false
		main.get_node("./MiniMap").visible = false
		main.get_node("./player/QuestHUD").visible = false
		var tween = get_tree().create_tween()
		tween.tween_property($player/Dimmer/ColorRect, "color", Color.BLACK, 0.8)
		tween.tween_callback(func(): main.get_node("./MiniMap").visible = true; main.get_node("./player/QuestHUD").visible = true; main.visible = true; main.get_node("./player").process_mode = Node.PROCESS_MODE_ALWAYS)
		tween.tween_callback(Callable(self, "queue_free"))
		tween.tween_callback(func(): get_tree().current_scene = main)

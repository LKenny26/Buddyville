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
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/main.tscn")

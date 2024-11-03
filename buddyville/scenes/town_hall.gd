extends Node2D

func _ready():
	$Panda.connect("update_quest", Callable($player, "set_quest_window"))
	$player.set_quest_window()
	$AudioStreamPlayer2D.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $player:
		print("exit")
		get_tree().change_scene_to_file("res://scenes/main.tscn")

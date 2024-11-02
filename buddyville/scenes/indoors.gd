extends Node2D

func _on_exit_body_entered(body: Node2D) -> void:
	print("exit")
	get_tree().change_scene_to_file("res://scenes/main.tscn")

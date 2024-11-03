extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$panda.play() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

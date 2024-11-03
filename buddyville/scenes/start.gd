extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Main/MiniMap.queue_free()
	$Main/player.queue_free()
	var newcam = Camera2D.new()
	match choose([0, 1, 2, 3]):
		0: $Main/Monkey.add_child(newcam)
		1: $Main/Owl.add_child(newcam)
		2: $Main/Porcupine.add_child(newcam)
		3: $Main/Rabbit.add_child(newcam)
		_: $Main/Monkey.add_child(newcam)
	newcam.make_current()
	newcam.global_position = newcam.get_parent().position
	newcam.zoom = Vector2(7,7)

func choose(array):
	array.shuffle()
	return array.front()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	var main_res = load("res://scenes/main.tscn")
	var main = main_res.instantiate()
	get_tree().get_root().add_child(main)
	var tween = get_tree().create_tween()
	main.visible = false
	main.get_node("./MiniMap").visible = false
	main.get_node("./player/QuestHUD").visible = false
	tween.tween_property($CanvasLayer/ColorRect, "color", Color.BLACK, 0.8)
	tween.tween_callback(func(): main.get_node("./MiniMap").visible = true; main.get_node("./player/QuestHUD").visible = true; main.visible = true)
	tween.tween_callback(Callable(self, "queue_free"))
	tween.tween_callback(func(): get_tree().current_scene = main)

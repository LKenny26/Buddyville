extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# sends player to monkey's house when clicking the door
func _on_door_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		GameState.inventory = get_node("../player").inventory
		get_tree().change_scene_to_file("res://scenes/indoors.tscn")

# sends player to owl's house when clicking the door
func _on_door_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		GameState.inventory = get_node("../player").inventory
		get_tree().change_scene_to_file("res://scenes/indoors.tscn")

# sends player to porcupine's house when clicking the door
func _on_door_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		GameState.inventory = get_node("../player").inventory
		get_tree().change_scene_to_file("res://scenes/indoors.tscn")

# sends player to rabbit's house when clicking the door
func _on_door_4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		GameState.inventory = get_node("../player").inventory
		get_tree().change_scene_to_file("res://scenes/indoors.tscn")

extends Node2D

signal give_player(item)
var interacted = false
var player_close = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body != self:
		$Tooltip.visible = true
		player_close = true


func _on_area_2d_body_exited(body):
	$Tooltip.visible = false
	player_close = false

func _input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact"):
		if !interacted && player_close:
			print("apple")
			emit_signal("give_player", "apple")
			interacted = true
			$Sprite2D.region_rect = Rect2(221,153,17,17)

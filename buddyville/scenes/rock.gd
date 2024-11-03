extends Node2D

var interacted = false
var player_close = false
var has_shovel = GameState.has_shovel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body != self && has_shovel && !interacted:
		$Tooltip.visible = true
		player_close = true


func _on_area_2d_body_exited(body):
	$Tooltip.visible = false
	player_close = false

func _input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact"):
		if !interacted && player_close && has_shovel:
			print("gold")
			GameState.give_item("gold")
			interacted = true
			$Sprite2D.region_rect = Rect2(765,170,16,16)
			$CollisionShape2D.disabled = true
			await get_tree().create_timer(0.5).timeout
			$Sprite2D.visible = false

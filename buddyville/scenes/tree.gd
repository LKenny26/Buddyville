extends Node2D

signal give_player(item)
var interacted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body != self:
		$Tooltip.visible = true


func _on_area_2d_body_exited(body):
	$Tooltip.visible = false

func interact():
	if !interacted:
		print("apple")
		emit_signal("give_player", "apple")
		interacted = true
		print($Sprite2D.get_region_rect())
		# += Vector2(-160,0)

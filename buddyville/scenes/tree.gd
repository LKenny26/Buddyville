extends Node2D

signal give_player(item)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	$Tooltip.visible = true


func _on_area_2d_body_exited(body):
	$Tooltip.visible = false

func interact():
	print("apple")
	emit_signal("give_player", "apple")

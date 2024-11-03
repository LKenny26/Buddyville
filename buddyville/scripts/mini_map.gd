extends CanvasLayer


@export var player : CharacterBody2D
@export var tileMap : Node2D

@onready var sub_viewport = $SubViewportContainer/SubViewport

var miniMapPlayer

func _ready() -> void:
	miniMapPlayer = player.duplicate()
	miniMapPlayer.get_node("QuestHUD").queue_free()
	miniMapPlayer.get_node("Pause_Menu").queue_free()
	
	sub_viewport.add_child(tileMap.duplicate())
	sub_viewport.add_child(miniMapPlayer)
	
func _process(delta: float) -> void:
	miniMapPlayer.position = player.position

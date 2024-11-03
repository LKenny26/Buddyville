extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$player.pause.connect(minimap_toggle)
	$player.position = GameState.player_spawn_pos
	if GameState.grave_state == GameState.DUG:
		$hole.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func minimap_toggle():
	$MiniMap.visible = !$MiniMap.visible


func _on_dirt_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if $player.has_shovel && GameState.grave_state == GameState.NOT_DUG:
			$hole.visible = true
			GameState.grave_state = GameState.DUG
			

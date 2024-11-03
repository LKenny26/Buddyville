extends Node2D

var interacted = false
var player_close = false
var sound_player := AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(sound_player)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body != self && GameState.inventory.has("shovel") && !interacted:
		$Tooltip.visible = true
		player_close = true


func _on_area_2d_body_exited(body):
	$Tooltip.visible = false
	player_close = false

func _input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact"):
		if !interacted && player_close && GameState.inventory.has("shovel"):
			print("gold")
			GameState.give_item("gold")
			interacted = true
			$Sprite2D.region_rect = Rect2(765,170,16,16)
			var rock_hit = load("res://resources/sfx/rock-hit.mp3")
			sound_player.stream = rock_hit
			sound_player.play()
			await get_tree().create_timer(1).timeout
			$CollisionShape2D.disabled = true
			var gold = load("res://resources/sfx/coin-flip-88793.mp3")
			sound_player.stream = gold
			sound_player.play()
			await get_tree().create_timer(1).timeout
			$Sprite2D.visible = false

extends Node2D

var interacted = false
var chopped = false
var player_close = false
var sound_player := AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(sound_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body != self && !interacted:
		$Tooltip.visible = true
		player_close = true


func _on_area_2d_body_exited(body):
	$Tooltip.visible = false
	player_close = false

func _input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact"):
		if !chopped && player_close && GameState.inventory.has("axe"):
			print("wood")
			GameState.give_item("wood")
			chopped = true
			interacted = true
			$Sprite2D.region_rect = Rect2(903, 375, 13, 15)
			$Tooltip.visible = false
			var chop = load("res://resources/sfx/chopping-wood-96709.mp3")
			sound_player.stream = chop
			sound_player.play()
			await get_tree().create_timer(0.5).timeout
			self.queue_free()
		if !interacted && player_close:
			print("apple")
			GameState.give_item("apple")
			interacted = true
			$Sprite2D.region_rect = Rect2(221,153,17,17)
			var pick_apple = load("res://resources/sfx/pick-apple.mp3")
			sound_player.stream = pick_apple
			sound_player.play()
			await get_tree().create_timer(1).timeout

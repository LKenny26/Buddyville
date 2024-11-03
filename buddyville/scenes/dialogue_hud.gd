extends CanvasLayer

@onready var dim = $ColorRect
@onready var box = $BottomSection
@onready var body_text = $BottomSection/Body/BodyText
@onready var title_text = $BottomSection/Title/TitleText
@onready var text_animation = $BottomSection/Body/AnimationPlayer
@onready var next = $BottomSection/Body/Next

var curr_state = START

# states of "reading" text
enum{
	START,
	READING,
	DONE
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print("START")
	hide_all()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match curr_state:
		START:
			pass
		READING:
			text_animation.play("new_animation")
			if Input.is_action_just_pressed("Next"): # skips reading
				$BottomSection/Body/AnimationPlayer.seek(2.0)
				change_state(DONE)
		DONE: # finished reading
			next.visible = true
			if Input.is_action_just_pressed("Next"):
				change_state(START)
				hide_all()

# hides everything
func hide_all():
	body_text.visible = false
	title_text.visible = false
	dim.visible = false
	box.visible = false
	next.visible = false

# shows everything
func show_all():
	body_text.visible = true
	title_text.visible = true
	dim.visible = true
	box.visible = true

# plays text
func say(text):
	change_state(READING) # state is "reading"
	$BottomSection/Body/BodyText.text = text
	text_animation.play("new_animation")
	show_all()

# text is done playing
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
		print(body_text.visible_ratio)
		change_state(DONE)

func set_title(text):
	$BottomSection/Title/TitleText.text = text

func change_state(next_state):
	curr_state = next_state
	match curr_state:
		START:
			print("START")
		READING:
			print("READING")
		DONE:
			print("DONE")

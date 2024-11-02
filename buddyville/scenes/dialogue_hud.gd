extends CanvasLayer

@onready var dim = $ColorRect
@onready var box = $BottomSection
@onready var body_text = $BottomSection/Body/BodyText
@onready var title_text = $BottomSection/Title/TitleText

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
	say("some random text")
	set_title("ooga booga")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match curr_state:
		START:
			pass
		READING:
			pass
		DONE:
			if Input.is_action_just_pressed("Interact"):
				change_state(START)
				hide_all()

# hides everything
func hide_all():
	body_text.text = ""
	title_text.text = ""
	dim.visible = false
	box.visible = false

# shows everything
func show_all():
	dim.visible = true
	box.visible = true

# plays text
func say(text):
	change_state(READING) # state is "reading"
	$BottomSection/Body/BodyText.text = text
	show_all()

# text is done playing
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
		change_state(DONE)

func set_title(text):
	$BottomSection/Title/TitleText.text = text

func change_state(next_state):
	curr_state = next_state
	match curr_state:
		START:
			print("START")
		READING:
			print("READINNG")
		DONE:
			print("DONE")

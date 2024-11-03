class_name Villager extends CharacterBody2D	

const speed = 75 # speed villagers move at
var start_pos
var curr_state = IDLE # state that the villager is in
var dir = Vector2.RIGHT # direction villager will move in
var player_close = false # if the player is close to villager
@onready var dialogue = $DialogueHud
var interacted_monkey = 0
var punch_monkey = 0
var interacted_owl = 0
var interacted_porcupine = 0
var interacted_rabbit = 0
var state = GameState.game_state # game state

var lines = ["How's your day going? Mine is going great!", 
"Every day is a good day in Buddyville :)",
"Have you met everybody on the island yet? They're really nice animals",
"I could really go for some fresh fruit right now... Good thing there's some apple trees nearby!",
"This is all a simulation. Wake up."]

# different villager states 
enum{
	IDLE,
	CHOOSE_DIR,
	MOVING
}

func _ready():
	$AnimatedSprite2D.play() # start animation
	$Timer.start() # start timer
	
	start_pos = position # set starting position (for bounds)
	randomize() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	match curr_state:
		# does nothing if idle
		IDLE:
			pass
		# chooses a random direction to walk in
		CHOOSE_DIR:
			dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		# villager moves !
		MOVING:
			move(delta)

# to help randomly choose (anything)
func choose(array):
	array.shuffle()
	return array.front()

# villager moving
func move(delta):
	move_and_collide(dir * speed * delta)
	# bounds for villagers
	if position.x >= start_pos.x + 50:
		position.x = start_pos.x + 49.9
	elif position.x <= start_pos.x - 50:
		position.x = start_pos.x - 49.9
	elif position.y >= start_pos.y + 50:
		position.y = start_pos.y + 49.9
	elif position.y <= start_pos.y - 50:
		position.y = start_pos.y - 49.9 
	
	# changes dir villager is facing
	if dir == Vector2.RIGHT:
		$AnimatedSprite2D.flip_h = true
	elif dir == Vector2.LEFT:
		$AnimatedSprite2D.flip_h = false

# chooses random state
func _on_timer_timeout() -> void:
	$Timer.wait_time = 0.5
	curr_state = choose([IDLE, CHOOSE_DIR, MOVING])

func _on_area_2d_input_event_monkey(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact") && player_close:
		# meet monkey
		dialogue.set_title("Manny")
		if interacted_monkey == 0 && state != 7:
			dialogue.say("Ooh ooh, a new person !! I'm Manny, I hope we can be friends!")
			interacted_monkey += 1
		# kill monkey
		elif state == 7:
			dialogue.say("What's up!  \n ... \n What are you...")
			$DeathTimer.start(2)
		# any other interaction w/ monkey
		else:
			dialogue.say(choose(lines))
		

func _on_area_2d_input_event_owl(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact") && player_close:
		if interacted_owl == 0:
			dialogue.say("Hi! I'm Oliver, nice to meet you! I've never seen you around before. Welcome to Buddyville!")
			dialogue.set_title("Oliver")
			interacted_owl += 1
		else:
			dialogue.say(choose(lines))
		
		
func _on_area_2d_input_event_porcupine(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact") && player_close:
		if interacted_porcupine == 0:
			dialogue.say("You must be the new person everybody's talking about! My name's Paul. I hope to see you around!")
			dialogue.set_title("Paul")
			interacted_porcupine += 1
		else:
			dialogue.say(choose(lines))

func _on_area_2d_input_event_rabbit(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact") && player_close:
		if interacted_rabbit == 0:
			dialogue.say("Heya, I'm Rosie! Welcome to Buddyville! Why don't you stop by my place sometime? We could have some apples and tea :)")
			dialogue.set_title("Rosie")
			interacted_rabbit += 1
		else:
			dialogue.say(choose(lines))
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	player_close = true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	player_close = false

func _on_death_timer_timeout() -> void:
	$CanvasLayer/ColorRect.visible = true
	$DeathTimer.stop()
	$DoneTimer.start(5)

func _on_done_timer_timeout() -> void:
	$DoneTimer.stop()
	$CanvasLayer/ColorRect.visible = false
	dialogue.set_title("(Petey)")
	dialogue.say("One more to go.....")

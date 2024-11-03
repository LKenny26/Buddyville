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
var sound_player := AudioStreamPlayer.new()




var lines = ["How's your day going? Mine is going great!", 
"Every day is a good day in Buddyville :)",
"Have you met everybody on the island yet? They're really nice animals",
"I heard there's gold at the mines!",
"I could really go for some fresh fruit right now... Good thing there's some apple trees nearby!",
"This is all a simulation. Wake up."]

# different villager states 
enum{
	IDLE,
	TALKING,
	CHOOSE_DIR,
	MOVING
}

func _ready():
	$AnimatedSprite2D.play("monkey") # start animation for monkey
	$AnimatedSprite2D.play("porcupine") # animation for porcupine
	$AnimatedSprite2D.play("owl") # owl animation
	$AnimatedSprite2D.play("rabbit") # rabbit animation
	$Timer.start() # start timer
	
	start_pos = position # set starting position (for bounds)
	randomize()
	add_child(sound_player) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	match curr_state:
		# does nothing if idle
		IDLE:
			pass
		# stays still if villager is talking
		TALKING:
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
	if curr_state == TALKING:
		$Timer.stop()
	else:
		$Timer.wait_time = 0.5
		curr_state = choose([IDLE, CHOOSE_DIR, MOVING])

func _on_area_2d_input_event_monkey(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact") && player_close:
		# meet monkey
		curr_state = TALKING
		dialogue.set_title("Manny")
		if interacted_monkey == 0 && state != 7:
			dialogue.say("Ooh ooh, a new person !! I'm Manny, I hope we can be friends!")
			GameState.villager_state["Monkey"]["met"] = true
			interacted_monkey += 1
		# after monkey dead
		elif GameState.villager_state["Monkey"]["dead"]:
			dialogue.say("(He's a boxing star in my heart)")
			dialogue.set_title("Petey")
		# kill monkey
		elif state == 7:
			dialogue.say("What's up!  \n ... \n What are you...")
			$DeathTimer.start(2)
		# any other interaction w/ monkey
		else:
			curr_state = TALKING
			dialogue.say(choose(lines))
			
	curr_state = choose([IDLE, CHOOSE_DIR, MOVING])
		

func _on_area_2d_input_event_owl(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact") && player_close:
		if GameState.game_state == GameState.AXE && GameState.has_axe == true:
			curr_state = TALKING
			dialogue.say("Did ya chop down those trees? Wait what are you.....")
			dialogue.set_title("Oliver")
			await get_tree().create_timer(4).timeout
			$Blackout.visible = true
			await get_tree().create_timer(0.5).timeout
			var axe_murder = load("res://resources/oliver_death/axe_murder.mp3")
			sound_player.stream = axe_murder
			sound_player.play()
			await get_tree().create_timer(9).timeout
			GameState.villager_state["Owl"]["dead"] = true
			queue_free()
			$Blackout.visible = false
		elif interacted_owl == 0:
			curr_state = TALKING
			dialogue.say("Hi! I'm Oliver, nice to meet you! I've never seen you around before. Welcome to Buddyville!")
			dialogue.set_title("Oliver")
			interacted_owl += 1
			GameState.villager_state["Owl"]["met"] = true
		else:
			curr_state = TALKING
			dialogue.say(choose(lines))
	curr_state = choose([IDLE, CHOOSE_DIR, MOVING])
		
		
func _on_area_2d_input_event_porcupine(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact") && player_close:
		if GameState.grave_state == GameState.DUG && GameState.game_state == GameState.BURY:
			curr_state = TALKING
			dialogue.say("Hey... why did you dig that hole?")
			dialogue.set_title("Paul")
			await get_tree().create_timer(3).timeout
			$Blackout.visible = true
			var shovel_hit = load("res://resources/porcupine_death/hit-sound-effect-240898.mp3")
			sound_player.stream = shovel_hit
			await get_tree().create_timer(0.5).timeout
			sound_player.play()
			await get_tree().create_timer(4).timeout
			var drag = load("res://resources/porcupine_death/footstep-drag-indoors-104989.mp3")
			sound_player.stream = drag
			sound_player.play()
			await get_tree().create_timer(7).timeout
			var dig = load("res://resources/porcupine_death/digging-dirt-cu-variations-06-24481.mp3")
			sound_player.stream = dig
			sound_player.play()
			await get_tree().create_timer(7).timeout
			$Blackout.visible = false
			GameState.grave_state = GameState.BURIED
			GameState.villager_state["Porcupine"]["dead"] = true
			queue_free()
		elif interacted_porcupine == 0:
			curr_state = TALKING
			dialogue.say("You must be the new person everybody's talking about! My name's Paul. I hope to see you around!")
			dialogue.set_title("Paul")
			interacted_porcupine += 1
			GameState.villager_state["Porcupine"]["met"] = true

		else:
			curr_state = TALKING
			dialogue.say(choose(lines))
	curr_state = choose([IDLE, CHOOSE_DIR, MOVING])

func _on_area_2d_input_event_rabbit(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact") && player_close:
		print(GameState.villager_state)
		curr_state = TALKING
		if interacted_rabbit == 0 && state != 5:
			dialogue.say("Heya, I'm Rosie! Welcome to Buddyville! Why don't you stop by my place sometime? We could have some apples and tea :)")
			dialogue.set_title("Rosie")
			interacted_rabbit += 1
			GameState.villager_state["Rabbit"]["met"] = true
			curr_state = choose([IDLE, CHOOSE_DIR, MOVING])
		elif GameState.villager_state["Rabbit"]["dead"]:
			print("DEAD")
			dialogue.say("(I think she enjoyed it. \n her skin glowing.)")
			dialogue.set_title("Petey")
		elif state == 5:
			dialogue.say("An apple? For me? Thank you so much!")
			dialogue.set_title("Rosie")
			$DeathTimer.start(2)
		else:
			dialogue.say(choose(lines))
	curr_state = choose([IDLE, CHOOSE_DIR, MOVING])
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	player_close = true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	player_close = false

func _on_death_timer_timeout() -> void:
	if state == 5: # rabbit death
		GameState.villager_state["Rabbit"]["dead"] = true
		$AnimatedSprite2D.play("rabbit dead")
		var apple = load("res://resources/sfx/Rosie_Death.wav")
		sound_player.stream = apple
		sound_player.play()
	elif state == 7: # monkey death
		GameState.villager_state["Monkey"]["dead"] = true
		$AnimatedSprite2D.play("dead_monkey")
		var punch = load("res://resources/sfx/punching_sfx.wav")
		sound_player.stream = punch
		sound_player.play()
	$CanvasLayer/ColorRect.visible = true
	get_parent().get_node("MiniMap").visible = false
	$DeathTimer.stop()
	$DoneTimer.start(5)

func _on_done_timer_timeout() -> void:
	$DoneTimer.stop()
	$CanvasLayer/ColorRect.visible = false
	get_parent().get_node("MiniMap").visible = true
	if state == 7:
		dialogue.set_title("Petey")
		dialogue.say("(He's a boxing star in my heart.)")
	elif state == 5:
		dialogue.set_title("Petey")
		dialogue.say("(I think she enjoyed it. \n her skin glowing.)")

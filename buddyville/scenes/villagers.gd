extends CharacterBody2D

const speed = 75 # speed villagers move at
var start_pos
var curr_state = IDLE # state that the villager is in
var dir = Vector2.RIGHT # direction villager will move in

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

func interact():
	print("Hello!")

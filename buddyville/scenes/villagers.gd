extends CharacterBody2D

const speed = 50 # speed villagers move at
var curr_state = IDLE # state that the villager is in
var dir = Vector2.RIGHT # direction villager will move in

# different villager states 
enum{
	IDLE,
	CHOOSE_DIR,
	MOVING
}

func _ready():
	$AnimatedSprite2D.play()
	$Timer.start()
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
	position += dir * speed * delta


func _on_timer_timeout() -> void:
	print(curr_state)
	$Timer.wait_time = 0.5
	curr_state = choose([IDLE, CHOOSE_DIR, MOVING])

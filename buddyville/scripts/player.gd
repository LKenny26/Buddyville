extends CharacterBody2D

# consts for movement
const LEFT = 0
const RIGHT = 1
const UP = 2
const DOWN = 3

var speed = 300.0
var last_dir = LEFT
var run = false

var inventory = []

func _ready():
	inventory = GameState.inventory

func _process(delta: float) -> void:
	
	#---------------- movement code----------------
	var direction = Vector2.ZERO # (0,0) no direction rn
	# move the character by changing vector
	if Input.is_action_pressed("Up"):
		direction.y -= 1
		last_dir = UP
	if Input.is_action_pressed("Down"):
		direction.y += 1
		last_dir = DOWN
	if Input.is_action_pressed("Left"):
		direction.x -= 1
		last_dir = LEFT
	if Input.is_action_pressed("Right"):
		direction.x += 1
		last_dir = RIGHT
	
	if Input.is_action_pressed("Run"):
		run = true
		speed = 600
	else:
		run = false
		speed = 300
	
	if direction.length() > 1:
		direction = direction.normalized()
		
	if direction.length() > 0:
		if run == true:
			if last_dir == LEFT:
				get_node("AnimatedSprite2D").play("run-left") 
			elif last_dir == RIGHT:
				get_node("AnimatedSprite2D").play("run-right")
			elif last_dir == UP:
				get_node("AnimatedSprite2D").play("run-up")
			else:
				get_node("AnimatedSprite2D").play("run-down")
		else:
			if last_dir == LEFT:
				get_node("AnimatedSprite2D").play("walk-left") 
			elif last_dir == RIGHT:
				get_node("AnimatedSprite2D").play("walk-right")
			elif last_dir == UP:
				get_node("AnimatedSprite2D").play("walk-up")
			else:
				get_node("AnimatedSprite2D").play("walk-down")
	else:
		if last_dir == LEFT:
			$AnimatedSprite2D.play("idle-left")
		elif last_dir == RIGHT:
			$AnimatedSprite2D.play("idle-right")
		elif last_dir == UP:
			get_node("AnimatedSprite2D").play("idle-up")
		else:
			get_node("AnimatedSprite2D").play("idle-down")
	move_and_collide(direction * speed * delta) # cheat to get it to move and collide right

func get_item():
	inventory.add

func death():
	set_process(false)
	$AnimatedSprite2D.play("death")
	queue_free()

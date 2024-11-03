extends Villager

func _process(delta: float):
	if GameState.villager_state["Rabbit"]["dead"]:
		pass
	else:
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

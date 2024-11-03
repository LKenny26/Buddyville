extends Villager

func check_quest():
	# check current game state
	match GameState.game_state:
		# player must talk to all villagers at least once
		GameState.MEET:
			for name in GameState.villager_state:
				if !GameState.villager_state[name]["met"]:
					no_pass()
					return
		# player must collect an apple
		GameState.COLLECT:
			if !GameState.inventory.contains("apple"):
				no_pass()
				return
			else:
				GameState.give_item("shovel")
		# player must dig to collect gold
		GameState.DIG:
			if !GameState.inventory.contains("gold"):
				no_pass()
				return
			else:
				GameState.give_item("axe")
		# player must chop a tree to collect wood
		GameState.CHOP:
			if !GameState.inventory.contains("wood"):
				no_pass()
				return
			else:
				# replace an apple with a poison apple
				GameState.inventory.remove_at(GameState.inventory.find("apple"))
				GameState.give_item("poison apple")
		# player must poison an apple and kill the rabbit with it
		GameState.POISON:
			if !GameState.villager_state["Rabbit"]["dead"]:
				no_pass()
				return
		# player must bury the porcupine
		GameState.BURY:
			if !GameState.villager_state["Porcupine"]["dead"]:
				no_pass()
				return
		# player must beat the monkey to death
		GameState.BEAT:
			if !GameState.villager_state["Monkey"]["dead"]:
				no_pass()
				return
		# player must murder the owl with the axe
		GameState.AXE:
			if !GameState.villager_state["Owl"]["dead"]:
				no_pass()
				return
		GameState.COMPLETE:
			return
	# continue to next game state if check successful
	GameState.next_game_state()

# func to alert the player they have not completed the quest
func no_pass():
	pass

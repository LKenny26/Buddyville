extends Villager

var first_dialogue = true
signal update_quest()

func _ready():
	pass

func quest_passed() -> bool:
	# check current game state
	match GameState.game_state:
		GameState.PRE:
			dialogue.say("Welcome to Buddyville! Your first quest is to say hello to everyone on the island! Good luck friend!")
			# continue to next game state if check successful
			GameState.next_game_state()
			emit_signal("update_quest")
			return true
		# player must talk to all villagers at least once
		GameState.MEET:
			for name in GameState.villager_state:
				if !GameState.villager_state[name]["met"]:
					return false
			dialogue.say("Everyone is nice here right? \n Here at Buddyville we have our own apple orchard! Go collect an apple now!")
			GameState.next_game_state()
			emit_signal("update_quest")
			return true
		# player must collect an apple
		GameState.COLLECT:
			if !GameState.inventory.has("apple"):
				return false
			else:
				GameState.give_item("shovel")
				dialogue.say("Nice work! There is a lot of buried treasure here at Buddyville! Go dig up something shiny!")
				GameState.next_game_state()
				emit_signal("update_quest")
				return true
		# player must dig to collect gold
		GameState.DIG:
			if !GameState.inventory.has("gold"):
				return false
			else:
				GameState.give_item("axe")
				dialogue.say("You can also chop down trees here for some wood! Here's an axe for you!")
				GameState.next_game_state()
				emit_signal("update_quest")
				return true
		# player must chop a tree to collect wood
		GameState.CHOP:
			if !GameState.inventory.has("wood"):
				return false
			else:
				# replace an apple with a poison apple
				GameState.inventory.remove_at(GameState.inventory.find("apple"))
				GameState.give_item("poison apple")
				dialogue.say("Awesome work! I replaced one of your apples with an EXTRA tasty one! Go give it to Rosie as a gift!")
				GameState.next_game_state()
				emit_signal("update_quest")
				return true
		# player must poison an apple and kill the rabbit with it
		GameState.POISON:
			if !GameState.villager_state["Rabbit"]["dead"]:
				return false
			dialogue.say("Great work buddy! I hope Rosie enjoyed that apple. Go dig a hole for Paul.")
			GameState.next_game_state()
			emit_signal("update_quest")
			return true
		# player must bury the porcupine
		GameState.BURY:
			if !GameState.villager_state["Porcupine"]["dead"]:
				return false
			dialogue.say("Manny wants to be a boxing star.")
			GameState.next_game_state()
			emit_signal("update_quest")
			return true
		# player must beat the monkey to death
		GameState.BEAT:
			if !GameState.villager_state["Monkey"]["dead"]:
				return false
			dialogue.say("Kill Oliver.")
			GameState.next_game_state()
			emit_signal("update_quest")
			return true
		# player must murder the owl with the axe
		GameState.AXE:
			if !GameState.villager_state["Owl"]["dead"]:
				return false
			dialogue.say("Good job.")
			GameState.next_game_state()
			emit_signal("update_quest")
			return true
		GameState.COMPLETE:
			GameState.game_state = GameState.COMPLETE
			dialogue.say("HEHEHEHEHE")
			return true
		_:
			return true

# func to alert the player they have not completed the quest
func no_pass():
	dialogue.say("You didn't finish your quest yet. Go do it then come back to me!")
	
func _process(delta: float):
	pass

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("Interact") && player_close:
		dialogue.set_title("Petey")
		if !quest_passed():
			no_pass()
			
func _on_death_timer_timeout() -> void:
	pass
		

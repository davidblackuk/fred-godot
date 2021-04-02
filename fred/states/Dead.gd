extends "res://state-machine/StateMachineState.gd"

func get_transition(_delta, _player):
	# like in life there is no transition out of being dead
	return null

func state_logic(delta, player):
	player.process_gravity()
	player.process_movement(delta)

func enter_state(_new_state, _old_state, player):
	GameStateManager.life_lost()
	player.die()

func exit_state(_old_state, _new_state, _player):
	pass


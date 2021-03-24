extends "res://state-machine/StateMachineState.gd"

func get_transition(delta, parent):
	# like in life there is no transition out of being dead
	return null

func state_logic(delta, parent):
	parent.process_gravity()
	parent.process_movement(delta)

func enter_state(new_state, old_state, parent):
	GameState.life_lost()
	parent.die()

func exit_state(old_state, new_state, parent):
	pass


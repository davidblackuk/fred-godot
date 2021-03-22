extends "res://state-machine/StateMachineState.gd"

func get_transition(delta, parent):
	if parent.is_on_floor():
		return Player.STATE_DEAD
	return null
	
func state_logic(delta, parent):
	parent.process_gravity()
	parent.process_movement(delta)

func enter_state(new_state, old_state, parent):
	pass

func exit_state(old_state, new_state, parent):
	pass


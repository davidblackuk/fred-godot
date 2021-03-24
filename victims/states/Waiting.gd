extends "res://state-machine/StateMachineState.gd"


func get_transition(delta, entity):
	if entity.is_rescued():
				return VictimStateMachine.STATE_RESCUED
	return null
	
func state_logic(delta, parent):
	pass

func enter_state(new_state, old_state, parent):
	pass

func exit_state(old_state, new_state, parent):
	pass

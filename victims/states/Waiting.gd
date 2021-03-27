extends "res://state-machine/StateMachineState.gd"


func get_transition(_delta, _victim):
	if _victim.is_rescued():
				return VictimStateMachine.STATE_RESCUED
	return null
	
func state_logic(_delta, _victim):
	pass

func enter_state(_new_state, _old_state, _victim):
	pass

func exit_state(_old_state, _new_state, _victim):
	pass

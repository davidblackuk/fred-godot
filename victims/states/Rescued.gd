extends "res://state-machine/StateMachineState.gd"


func get_transition(delta, entity):
	# No need to handle RESCUED as the transition to it, is a terminal transition
	return null

func state_logic(delta, parent):
	pass

func enter_state(new_state, old_state, parent):
	GameState.add_score(parent.POINTS_SCORED)
	parent.broadcast_rescued()
	parent.animate_and_dequeue()

func exit_state(old_state, new_state, parent):
	pass

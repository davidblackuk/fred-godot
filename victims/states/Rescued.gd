extends "res://state-machine/StateMachineState.gd"


func get_transition(_delta, _victim):
	# No need to handle RESCUED as the transition to it, is a terminal transition
	return null

func state_logic(_delta, _victim):
	pass

func enter_state(_new_state, _old_state, victim):
	GameManager.add_score(victim.POINTS_SCORED)
	victim.broadcast_rescued()
	victim.animate_and_dequeue()

func exit_state(_old_state, _new_state, _victim):
	pass

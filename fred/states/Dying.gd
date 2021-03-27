extends "res://state-machine/StateMachineState.gd"

func get_transition(_delta, player):
	if player.is_on_floor():
		return Player.STATE_DEAD
	return null
	
func state_logic(delta, player):
	player.process_gravity()
	player.process_movement(delta)

func enter_state(_new_state, _old_state, _player):
	pass

func exit_state(_old_state, _new_state, _player):
	pass


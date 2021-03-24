extends "res://state-machine/StateMachineState.gd"

func get_transition(delta, parent):
	if parent.has_enemy_hit:
		return Player.STATE_DYING
	if parent.is_on_floor():
		if parent.has_fallen_to_death():
			return Player.STATE_DYING
		else:
			return Player.STATE_IDLE
	return null

func state_logic(delta, parent):
	parent.process_gravity()
	parent.fall();
	parent.process_movement(delta)

func enter_state(new_state, old_state, parent):
	if old_state == Player.STATE_WALKING:
		parent.motion.x = 0
	parent.jump_start_y = parent.global_position.y

func exit_state(old_state, new_state, parent):
	pass


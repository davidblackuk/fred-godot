extends "res://state-machine/StateMachineState.gd"

func get_transition(delta, parent):
	if parent.has_enemy_hit:
		return Player.STATE_DYING
	if parent.motion.y > 0:
		return Player.STATE_FALLING
	return null

func state_logic(delta, parent):
	parent.process_gravity()
	parent.jump();
	parent.process_movement(delta)
	
func enter_state(new_state, old_state, parent):
	parent.jump_start_y = parent.global_position.y
	parent.motion.y = -parent.JUMP_VELOCITY

func exit_state(old_state, new_state, parent):
	pass


extends "res://state-machine/StateMachineState.gd"

func get_transition(_delta, player):
	if player.has_enemy_hit:
		return Player.STATE_DYING
	if player.is_on_floor():
		if player.has_fallen_to_death():
			return Player.STATE_DYING
		else:
			return Player.STATE_IDLE
	return null

func state_logic(delta, player):
	player.process_gravity()
	player.fall();
	player.process_movement(delta)

func enter_state(_new_state, old_state, player):
	if old_state == Player.STATE_WALKING:
		player.motion.x = 0
	player.jump_start_y = player.global_position.y

func exit_state(_old_state, _new_state, _player):
	pass


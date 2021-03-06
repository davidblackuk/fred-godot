extends "res://state-machine/StateMachineState.gd"

func get_transition(_delta, player):
	if player.has_enemy_hit:
		return Player.STATE_DYING
	elif player.is_on_floor():
		return "POP"
	return null

func state_logic(delta, player):
	player.process_gravity()
	
	if player.is_on_floor():
		player.snap_vector = Vector2.ZERO
	player.jump_height = (player.jump_start_y - player.global_position.y)
	
	player.process_movement(delta)
	
func enter_state(_new_state, _old_state, player):
	player.jump_start_y = player.global_position.y
	player.motion.y = -player.JUMP_VELOCITY

func exit_state(_old_state, _new_state, _player):
	pass


extends "res://state-machine/StateMachineState.gd"

func get_transition(_delta, player):
	if player.has_enemy_hit:
		return Player.STATE_DYING
	if player.is_standing_on_conveyer():
		return Player.STATE_CONVEYED
	if Input.is_action_pressed("ui_up") && player.is_on_ladder():
		return Player.STATE_CLIMBING
	elif Input.is_action_pressed("ui_down") && player.is_on_ladder() :
		return Player.STATE_CLIMBING
	elif Input.is_action_just_pressed("ui_jump") && player.is_on_floor():
		return "PUSH:" + Player.STATE_JUMPING
	elif Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		return Player.STATE_WALKING
	elif player.is_on_ladder() && !player.is_on_floor():
		return Player.STATE_CLIMBING
	return null

func state_logic(delta, player):
	player.motion.x = 0
	player.process_gravity()
	if (player.is_on_floor()):
		player.jump_height = 0
	else:
		player.jump_height = (player.jump_start_y - player.global_position.y)
	player.process_movement(delta)

func enter_state(_new_state, _old_state, player):
	player.motion.x = 0
	player.jump_start_y = player.global_position.y
	player.animation_player.play("Idle")
			
func exit_state(_old_state, _new_state, _player):
	pass


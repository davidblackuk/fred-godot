extends "res://state-machine/StateMachineState.gd"

func enter_state(_new_state, _old_state, player):
	player.animation_player.play("Walk")

func exit_state(_old_state, _new_state, _player):
	pass

func get_transition(_delta, player):
	if player.has_enemy_hit:
		return Player.STATE_DYING
	elif player.motion.y > 0 && !(player.is_on_ladder() && !player.is_on_floor()):
		return "PUSH:" + Player.STATE_FALLING
	elif Input.is_action_pressed("ui_up") && player.is_on_ladder():
		return Player.STATE_CLIMBING
	elif Input.is_action_pressed("ui_down") && player.is_on_ladder() && !player.is_on_floor():
		return Player.STATE_CLIMBING
	elif Input.is_action_just_pressed("ui_jump") && player.is_on_floor():
		return "PUSH:" + Player.STATE_JUMPING
	elif !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		return Player.STATE_IDLE
	return null

func state_logic(delta, player):
	player.process_gravity()
	
	if Input.is_action_pressed("ui_left"):
		player.motion.x = -player.HORIZONTAL_VELOCITY
		player.sprite.set_flip_h(true)
	elif Input.is_action_pressed("ui_right"):
		player.sprite.set_flip_h(false)		
		player.motion.x = player.HORIZONTAL_VELOCITY
	
	player.process_movement(delta)



 

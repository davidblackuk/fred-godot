extends "res://state-machine/StateMachineState.gd"

func get_transition(_delta, player):
	
	if player.has_enemy_hit:
		return Player.STATE_DYING
	
	var left_or_right_pressed = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")
	
	if !player.is_standing_on_conveyer() && !left_or_right_pressed:
		return Player.STATE_IDLE
	if !player.is_standing_on_conveyer() && left_or_right_pressed:
		return Player.STATE_WALKING
	if player.is_standing_on_conveyer() && Input.is_action_pressed("ui_jump"):
		return "PUSH:"+Player.STATE_JUMPING
		
	
	return null;
	
func state_logic(delta, player):
	player.process_gravity()
	
	if player.current_conveyor_direction == ConveyorBelt.DIRECTION_LEFT:
		player.motion.x = -player.HORIZONTAL_VELOCITY
	elif player.current_conveyor_direction == ConveyorBelt.DIRECTION_RIGHT:
		player.motion.x = player.HORIZONTAL_VELOCITY
	
	player.process_movement(delta)

func enter_state(_new_state, _old_state, player):
	player.animation_player.play("Walk")	
	player.sprite.set_flip_h(player.current_conveyor_direction == ConveyorBelt.DIRECTION_LEFT)

func exit_state(_old_state, _new_state, _player):
	pass


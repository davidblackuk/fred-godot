extends "res://state-machine/StateMachineState.gd"

func enter_state(new_state, old_state, parent):
	parent.animation_player.play("Walk")

func exit_state(old_state, new_state, parent):
	pass

func get_transition(delta, parent):
	if parent.has_enemy_hit:
		return Player.STATE_DYING
	if parent.motion.y > 0:
		return Player.STATE_FALLING
	elif Input.is_action_pressed("ui_up") && parent.is_on_ladder():
		return Player.STATE_CLIMBING
	elif Input.is_action_pressed("ui_down") && parent.is_on_ladder() && !parent.is_on_floor():
		return Player.STATE_CLIMBING
	elif Input.is_action_just_pressed("ui_jump") && parent.is_on_floor():
		return Player.STATE_JUMPING
	elif !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		return Player.STATE_IDLE
	return null

func state_logic(delta, parent):
	parent.process_gravity()
	
	if Input.is_action_pressed("ui_left"):
		parent.motion.x = -parent.HORIZONTAL_VELOCITY
		parent.sprite.set_flip_h(true)
	elif Input.is_action_pressed("ui_right"):
		parent.sprite.set_flip_h(false)		
		parent.motion.x = parent.HORIZONTAL_VELOCITY
	
	parent.process_movement(delta)




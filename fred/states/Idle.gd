extends "res://state-machine/StateMachineState.gd"

func get_transition(delta, parent):
	if parent.has_enemy_hit:
		return Player.STATE_DYING
	if Input.is_action_pressed("ui_up") && parent.is_on_ladder():
		return Player.STATE_CLIMBING
	elif Input.is_action_pressed("ui_down") && parent.is_on_ladder() :
		return Player.STATE_CLIMBING
	elif Input.is_action_just_pressed("ui_jump") && parent.is_on_floor():
		return Player.STATE_JUMPING
	elif Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		return Player.STATE_WALKING
	return null

func state_logic(delta, parent):
	parent.process_gravity()
	parent.process_movement(delta)

func enter_state(new_state, old_state, parent):
	parent.motion.x = 0
	parent.animation_player.play("Idle")
			
func exit_state(old_state, new_state, parent):
	pass


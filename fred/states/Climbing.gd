extends "res://state-machine/StateMachineState.gd"


func get_transition(delta, parent):
	if parent.has_enemy_hit:
		return Player.STATE_DYING
	if  Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		return Player.STATE_WALKING
	return null;
	
func state_logic(delta, parent):
	parent.process_gravity()
	parent.climb()
	parent.process_movement(delta)

func enter_state(new_state, old_state, parent):
	parent.animation_player.play("Climb")

func exit_state(old_state, new_state, parent):
	pass


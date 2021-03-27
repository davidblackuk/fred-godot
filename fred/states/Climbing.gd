extends "res://state-machine/StateMachineState.gd"

func get_transition(_delta, player):
	if player.has_enemy_hit:
		return Player.STATE_DYING
	if  Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		return Player.STATE_WALKING
	return null;
	
func state_logic(delta, player):
	player.process_gravity()
	player.climb()
	player.process_movement(delta)

func enter_state(_new_state, _old_state, player):
	player.animation_player.play("Climb")

func exit_state(_old_state, _new_state, _player):
	pass


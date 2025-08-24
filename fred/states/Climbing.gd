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
	# when we enter climb on a ladder ove a hole, we move fred up a couple of pixels
	# So that he can just walk off again with out falling through the hole
	print("enter state climbing " + _new_state + " from " + _old_state)
	if not player.is_on_floor(): # only doo this from walking?
		player.global_position.y = player.global_position.y - 20
	player.animation_player.play("Climb")

func exit_state(_old_state, _new_state, _player):
	pass

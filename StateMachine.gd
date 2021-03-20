extends "res://common/StateMachine.gd"

const STATE_WALKING = "walking"
const STATE_JUMPING = "jumping"
const STATE_CLIMBING = "climbing"
const STATE_DYING = "dying"
const STATE_DEAD = "dead"



func _ready():
	add_state(STATE_WALKING)
	add_state(STATE_JUMPING)
	add_state(STATE_CLIMBING)
	add_state(STATE_DYING)
	add_state(STATE_DEAD)
	call_deferred("set_state", STATE_WALKING)

func _state_logic(delta):
	parent.process_gravity();
	parent.process_input(delta)
	parent.process_movement(delta)



func _get_transition(delta):
	return null

	
func _enter_state(new_state, old_state):
	pass
	
func _exit_state(old_state, new_state):
	pass

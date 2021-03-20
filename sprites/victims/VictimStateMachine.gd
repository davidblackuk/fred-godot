extends "res://common/StateMachine.gd"

const STATE_WAITING = "waiting"
const STATE_RESCUED = "rescued"


func _ready():
	add_state(STATE_WAITING)
	add_state(STATE_RESCUED)
	call_deferred("set_state", STATE_WAITING)

func _state_logic(delta):
	pass


func _get_transition(delta):
	match state:
		STATE_WAITING:
			if parent.is_rescued():
				return STATE_RESCUED
	# No need to handle RESCUED as the transition to it is a terminal transition
	return null

	
func _enter_state(new_state, old_state):
	match new_state:
		STATE_RESCUED:
			parent.show_rescued()

	
func _exit_state(old_state, new_state):
	pass

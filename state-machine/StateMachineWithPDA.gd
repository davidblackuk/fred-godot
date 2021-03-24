extends Node

class_name StateMachineWithPDA

var states = {}

var state = null 

var previous_state = null

onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		states[state].state_logic(delta, parent)
		
		var transition = states[state].get_transition(delta, parent)
		if transition != null:
			_set_state(transition)

#
# sets the new state and orchestrates the leave / enter calls
#
func _set_state(new_state):
	previous_state = state
	state = new_state

	print(previous_state, " >> ", new_state)

	if previous_state != null:
		states[state].exit_state(previous_state, new_state, parent)
		
	if new_state != null:
		states[state].enter_state(new_state, previous_state, parent)

#
# Attaches the state to the script for that state
#
func add_state(state_name, script):
	states[state_name] = script


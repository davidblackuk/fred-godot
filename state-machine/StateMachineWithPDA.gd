extends Node

class_name StateMachineWithPDA

var states = {}

var state = null 

var previous_state = null

var _state_stack = []

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
	var have_popped = false
	print(previous_state, " >> ", new_state)

	if (new_state.begins_with("PUSH:")):
		new_state = str(new_state).substr(5)
		_state_stack.push_front(state)
		print("pushed state: " , new_state)
	elif (new_state == "POP"):
		new_state = _state_stack.pop_front()
		have_popped = true


	previous_state = state
	state = new_state


	if previous_state != null:
		states[state].exit_state(previous_state, new_state, parent)
	
	# if we are popping back to an existing state don't re-initialize
	if new_state != null && !have_popped:
		states[state].enter_state(new_state, previous_state, parent)

#
# Attaches the state to the script for that state
#
func add_state(state_name, script):
	states[state_name] = script


extends Node2D

onready var state_machine = get_parent().get_node("StateMachine")
onready var label = get_node("Label")



func _process(delta):
	if GameState.show_states:
		label.text = state_machine.state

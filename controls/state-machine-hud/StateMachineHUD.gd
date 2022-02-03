extends Node2D

onready var state_machine = get_parent().get_node("StateMachine")
onready var label = get_node("Label")



func _process(_delta):
	if GameManager.game_state.debug_mode:
		label.text = state_machine.state
	else:
		queue_free()

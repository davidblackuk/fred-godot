extends Node2D

onready var label = get_node("Label")
onready var player = get_parent()


func _process(delta):
	if GameStateManager.debug_mode:
		label.text = str(int(player.jump_height))

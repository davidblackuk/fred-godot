extends Node2D

onready var jump_height = get_node("JumpHeight")
onready var motion = get_node("Motion")
onready var player = get_parent()


func _process(delta):
	if GameStateManager.debug_mode:
		jump_height.text = str(int(player.jump_height))
		motion.text = str(player.motion)
extends Node2D

signal fade_complete()

onready var player = get_node("AnimationPlayer")

func fade():
	show()
	player.play("fade_out")


func _on_animation_finished(anim_name):
	emit_signal("fade_complete")

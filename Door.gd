tool
extends Node2D

export(String, FILE, "*.tscn") var next_level

export(Color, RGB) var door_tint = Color.white setget set_door_tint, get_door_tint

#
# Fred has walked into the door and triggered entry to the next level
#
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		# warning-ignore:return_value_discarded
		get_tree().change_scene(next_level) # Replace with function body.

#
# Animate the shutter then when complete, remove the static body 
# collision that prevents pred from entering and hitting the Area2d
# that initiates the level change
#
func _level_complete():
	var animator = get_node("Area2D/AnimationPlayer")
	animator.play("Roller")
	yield(animator, "animation_finished")
	get_node("StaticBody2D").set_collision_mask_bit(0, false)


func get_door_tint():
	return get_node("Area2D/Roller").modulate

func set_door_tint(value):
	get_node("Area2D/Roller").modulate = value
	get_node("Area2D/Door Top").modulate = value
	get_node("Area2D/Door Bottom").modulate = value

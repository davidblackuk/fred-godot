extends Node2D

export(String, FILE, "*.tscn") var next_level

#
# Fred has walked into the door and triggered entry to the next level
#
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(next_level) # Replace with function body.

#
# Animate the shutter then when complete, remove the static body 
# collision that prevents pred from entering and hitting the Area2d
# that initiates the level change
#
func _on_Player_level_complete():
	var animator = get_node("Area2D/AnimationPlayer")
	animator.play("Roller")
	yield(animator, "animation_finished")
	get_node("StaticBody2D").set_collision_mask_bit(0, false)


func _on_ladder_enter(ladder_node):
	pass # Replace with function body.


func _on_ladder_exit(ladder_node):
	pass # Replace with function body.

tool
extends Node2D

signal go_to_next_scene()

export(Color, RGB) var door_tint = Color.white 

onready var roller = get_node("Area2D/Roller")
onready var door_top = get_node("Area2D/Door Top")
onready var door_bottom = get_node("Area2D/Door Bottom")



func _ready():
	roller.modulate = door_tint
	door_top.modulate = door_tint
	door_bottom.modulate = door_tint

#
# Fred has walked into the door and triggered entry to the next level
#
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		emit_signal("go_to_next_scene")

#
# Animate the shutter then when complete, remove the static body 
# collision that prevents fred from entering and hitting the Area2d
# that initiates the level change
#
func _level_complete():
	var animator = get_node("Area2D/AnimationPlayer")
	animator.play("Roller")
	yield(animator, "animation_finished")
	get_node("StaticBody2D").set_collision_mask_bit(0, false)


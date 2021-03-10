extends Node2D


export(float) var animation_speed = 1 setget set_animation_speed, get_animation_speed

export(Color, RGB) var sprite_tint = Color.white setget set_sprite_tint, get_sprite_tint

	
func get_sprite_tint():
	return get_node("Area2D/Sprite").modulate

func set_sprite_tint(value):
	get_node("Area2D/Sprite").modulate = value

func get_animation_speed():
	var node = get_node("Area2D/AnimationPlayer")
	if node:
		return node.playback_speed
	return 1
	
func set_animation_speed(value):
	var node = get_node("Area2D/AnimationPlayer")
	if node:
		node.playback_speed = value


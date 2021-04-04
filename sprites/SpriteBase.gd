extends Node2D


export(float) var animation_speed = 1 setget set_animation_speed, get_animation_speed

export(Color, RGB) var sprite_tint = Color.white setget set_sprite_tint, get_sprite_tint

export(bool) var flip_horizontal setget set_flip_h, get_flip_h
	

onready var sprite = get_node_or_null("Area2D/Sprite")

var _flip_h = false

func _ready():
	sprite.set_flip_h(flip_horizontal if flip_horizontal != null else false)
	
func get_sprite_tint():
	var node = get_node("Area2D/Sprite");
	if node:
		return node.modulate
	return Color.white

func set_sprite_tint(value):
	var node = get_node("Area2D/Sprite");
	if node:
		node.modulate = value

func get_animation_speed():
	var node = get_node("Area2D/AnimationPlayer")
	if node:
		return node.playback_speed
	return 1
	
func set_animation_speed(value):
	var node = get_node("Area2D/AnimationPlayer")
	if node:
		node.playback_speed = value

func get_flip_h():
	return _flip_h

func set_flip_h(value):
	_flip_h = value
	if sprite:
		sprite.set_flip_h(value)

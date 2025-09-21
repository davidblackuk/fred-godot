extends Node2D


@export var animation_speed: float = 1: get = get_animation_speed, set = set_animation_speed

@export var sprite_tint = Color.WHITE: get = get_sprite_tint, set = set_sprite_tint # (Color, RGB)

@export var flip_horizontal: bool: get = get_flip_h, set = set_flip_h
	

@onready var sprite: Sprite2D = $Area2D/Sprite2D


var _flip_h = false

func _ready():
	sprite.set_flip_h(flip_horizontal if flip_horizontal != null else false)
	
func get_sprite_tint():
	var node = get_node("Area2D/Sprite2D");
	if node:
		return node.modulate
	return Color.WHITE

func set_sprite_tint(value):
	var node = get_node("Area2D/Sprite2D");
	if node:
		node.modulate = value

func get_animation_speed() -> float:
	var node: AnimationPlayer = get_node("Area2D/AnimationPlayer") as AnimationPlayer
	if node:
		return node.playback_speed
	return 1
	
func set_animation_speed(value: float):
	var node: AnimationPlayer = get_node("Area2D/AnimationPlayer") as AnimationPlayer
	if node:
		node.playback_speed = value

func get_flip_h():
	return _flip_h

func set_flip_h(value):
	_flip_h = value
	if sprite:
		sprite.set_flip_h(value)

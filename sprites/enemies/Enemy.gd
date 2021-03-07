tool
extends Node2D

signal fred_is_dead()

export(float) var speed setget set_speed, get_speed

export(Color, RGB) var enemy_tint = Color.white setget set_enemy_tint, get_enemy_tint

	
func get_enemy_tint():
	return get_node("Node2D/Sprite").modulate

func set_enemy_tint(value):
	get_node("Node2D/Sprite").modulate = value

func get_speed():
	var node = get_node("Node2D/AnimationPlayer")
	if node:
		return node.playback_speed
	return 1
	
func set_speed(value):
	var node = get_node("Node2D/AnimationPlayer")
	if node:
		node.playback_speed = value


func _on_StaticBody2D_body_entered(body):
	if body.name == "Player":
		emit_signal("fred_is_dead")

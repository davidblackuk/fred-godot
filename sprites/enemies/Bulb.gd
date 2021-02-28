tool
extends Node2D



export(Color, RGB) var enemy_tint = Color.white setget set_enemy_tint, get_enemy_tint

	
func get_enemy_tint():
	return get_node("StaticBody2D/Sprite").modulate

func set_enemy_tint(value):
	get_node("StaticBody2D/Sprite").modulate = value

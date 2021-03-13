tool
extends "res://sprites/SpriteBase.gd"

signal fred_is_dead()

export(String) var animation_name setget set_animation, get_animation


func _on_StaticBody2D_body_entered(body):
	if body.name == "Player":
		emit_signal("fred_is_dead")

func get_animation():
	var player = get_node_or_null("AnimationPlayer")
	if player:
		return player.current_animation
	return ""
	
func set_animation(value):
	var player = get_node_or_null("AnimationPlayer")
	if player:
		player.play(value)

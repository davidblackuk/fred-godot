tool
extends "res://sprites/SpriteBase.gd"

signal fred_is_dead()

export(String) var animation_name setget set_animation, get_animation

var animation = "Bulb"

func _ready():
	var player = get_node_or_null("Area2D/AnimationPlayer")
	if player:
		player.play(animation)

func _on_StaticBody2D_body_entered(body):
	if body.name == "Player" && !GameStateManager.god_mode:
		emit_signal("fred_is_dead")

func get_animation():
	return animation
	
func set_animation(value):
	animation = value

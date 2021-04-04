tool
extends "res://sprites/SpriteBase.gd"

signal fred_is_dead()

export(String) var animation_name = "Bulb"

func _ready():
	var player = get_node_or_null("Area2D/AnimationPlayer")
	if player:
		print("Play ", animation_name)
		player.play(animation_name)
	

func _on_StaticBody2D_body_entered(body):
	if body.name == "Player" && !GameStateManager.god_mode:
		emit_signal("fred_is_dead")


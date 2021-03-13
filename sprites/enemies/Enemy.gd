tool
extends "res://sprites/SpriteBase.gd"

signal fred_is_dead()



func _on_StaticBody2D_body_entered(body):
	if body.name == "Player":
		emit_signal("fred_is_dead")

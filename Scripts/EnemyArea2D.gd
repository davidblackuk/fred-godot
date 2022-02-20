extends Area2D

# 
# An Aread2d that detects the entry of the play sprite and raises the fred_is_dead signal,
# this node is automatically entered into the Enemies group for binding

signal fred_is_dead()

func _ready():
	connect("body_entered", self, "_on_body_entered")
	add_to_group("Enemies")

func _on_body_entered(body):
	if body.name == "Player" && !GameManager.game_state.god_mode:
		emit_signal("fred_is_dead")


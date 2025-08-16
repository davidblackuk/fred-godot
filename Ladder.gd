@tool
extends Node2D

signal ladder_status_changed(ladder_node, is_entry)

@export var ladder_type = 0  # (int, "MIDDLE", "BOTTOM", "TOP")

@export var ladder_tint = Color.WHITE  # (Color, RGB)

@onready var sprite = get_node("Sprite2D")

func _ready():
	sprite.frame = ladder_type
	sprite.modulate = ladder_tint

func _on_Collider_body_entered(body):
	if body.name == "Player":
		emit_signal("ladder_status_changed", self, true)

func _on_Collider_body_exited(body):
	if body.name == "Player":
		emit_signal("ladder_status_changed", self, false)

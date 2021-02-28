tool
extends Node2D

signal ladder_status_changed(ladder_node, is_entry)

export(int, "MIDDLE", "BOTTOM", "TOP") var ladder_type = 0 setget set_ladder_type, get_ladder_type

export(Color, RGB) var ladder_tint = Color.white setget set_ladder_tint, get_ladder_tint


func _on_Collider_body_entered(body):
	if body.name == "Player":
		emit_signal("ladder_status_changed", self, true)

func _on_Collider_body_exited(body):
	if body.name == "Player":
		emit_signal("ladder_status_changed", self, false)


func get_ladder_type():
	return get_node("Sprite").frame
	
func set_ladder_type(value):
	get_node("Sprite").frame = value
	
func get_ladder_tint():
	return get_node("Sprite").modulate

func set_ladder_tint(value):
	get_node("Sprite").modulate = value

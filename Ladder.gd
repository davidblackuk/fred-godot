extends Node2D

signal on_ladder_available(ladder_node)

export var ladder_type = 0 setget set_ladder_type, get_ladder_type

func _on_Collider_body_entered(body):
	if body.name == "Player":
		emit_signal("on_ladder_available", self)


func get_ladder_type():
	return get_node("Sprite").frame
	
func set_ladder_type(value):
	get_node("Sprite").frame = value
	

tool
extends Node2D

signal on_ladder_enter(ladder_node)
signal on_ladder_exit(ladder_node)



export(int, "MIDDLE", "BOTTOM", "TOP") var ladder_type = 0 setget set_ladder_type, get_ladder_type

export(Color, RGB) var ladder_tint = Color.white setget set_ladder_tint, get_ladder_tint


func _on_Collider_body_entered(body):
	if body.name == "Player":
		emit_signal("on_ladder_enter", self)

func _on_Collider_body_exited(body):
	if body.name == "Player":
		emit_signal("on_ladder_exit", self)


func get_ladder_type():
	return get_node("Sprite").frame
	
func set_ladder_type(value):
	get_node("Sprite").frame = value
	

func get_ladder_tint():
	return get_node("Sprite").modulate
	
func set_ladder_tint(value):
	get_node("Sprite").modulate = value
	



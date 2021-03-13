extends "res://sprites/SpriteBase.gd"

enum VictimState { WAITING, RESCUED }

var state = VictimState.WAITING

func _on_Area2D_body_entered(body):
	if state == VictimState.WAITING:
		var sprite = get_node("Area2D/Sprite") 
		var player = get_node("Area2D/AnimationPlayer")
		player.play("Rescued")
		state = VictimState.RESCUED
	# Replace with function body.
